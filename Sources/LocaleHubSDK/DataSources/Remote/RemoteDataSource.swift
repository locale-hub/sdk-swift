import Combine
import Foundation
import os.log

class RemoteDataSource: DataSource {
    private let offlineDataSource: OfflineDataSource
    
    private let config: RemoteDataSourceConfiguration
    
    private var cancellables: [AnyCancellable] = []
    
    private let baseURL: URL
    
    @Published private var currentManifestMutable: CultureManifest = CultureManifest()
    var currentManifest: AnyPublisher<CultureManifest, Never> { AnyPublisher($currentManifestMutable) }

    @Published private var supportedCulturesMutable: [Culture] = []
    var supportedCultures: AnyPublisher<[Culture], Never> { AnyPublisher($supportedCulturesMutable) }
    
    public init(offlineDataSource: OfflineDataSource, config: RemoteDataSourceConfiguration) {
        self.baseURL = config.endpoint.appendingPathComponent("projects").appendingPathComponent(config.projectId)
        self.offlineDataSource = offlineDataSource
        self.config = config

        DispatchQueue.main.async {
            self.cancellables.append(self.offlineDataSource.supportedCultures.sink { offlineCultures in
                self.supportedCulturesMutable = offlineCultures
            })
            
            // TODO(LH-22): Fast language switch can cause async ordering issues
            self.cancellables.append(self.offlineDataSource.currentManifest.sink { offlineManifest in
                self.currentManifestMutable = offlineManifest
            })
        }
    }
    
    deinit {
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    func loadCultures() throws {
        self.offlineDataSource.loadCultures()

        let url = baseURL
            .appendingPathComponent("deployments")
            .appendingPathComponent(self.config.deploymentTag)
            .appendingPathComponent("cultures")
        Task {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(config.apiKey, forHTTPHeaderField: "LH-API-Key")

            do {
                let result = try await doGetRequest(request, type: GetCulturesResponse.self)
                DispatchQueue.main.async {
                    self.supportedCulturesMutable = result.cultures
                }
            } catch {
                LocaleHubLogger.dataSource.error("An error occured while loading the supported cultures: \(error)")
            }
        }
    }

    func loadManifest(preferredCultures cultures: [Culture]) throws {
        try? self.offlineDataSource.loadManifest(preferredCultures: cultures)
        
        let url = baseURL
            .appendingPathComponent("deployments")
            .appendingPathComponent(self.config.deploymentTag)
            .appendingPathComponent("manifest")
            .appending(queryItems: [ URLQueryItem(name: "cultures", value: cultures.map { $0.code }.joined(separator: ",")) ])

        Task {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("gzip, deflate", forHTTPHeaderField: "Accept-Encoding")
            request.addValue(config.apiKey, forHTTPHeaderField: "LH-API-Key")

            do {
                let result = try await doGetRequest(request, type: CultureManifest.self)
                DispatchQueue.main.async {
                    self.currentManifestMutable = result
                }
            } catch {
                LocaleHubLogger.dataSource.error("An error occured while loading the translation manifest: \(error)")
            }
        }
    }
    
    private func doGetRequest<T: Decodable>(_ request: URLRequest, type: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.isSuccessful else {
            throw RemoteDataSourceError.invalidResponse(response)
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw RemoteDataSourceError.invalidData(data)
        }
    }
    
}
