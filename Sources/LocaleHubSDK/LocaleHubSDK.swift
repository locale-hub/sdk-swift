import Combine
import Foundation

public class LocaleHubSDK {
    static let defaultOfflineBundleUrl = Bundle.main.url(forResource: "Offline", withExtension: "localehub")
    public static let null: LocaleHubSDK = LocaleHubSDK(dataSource: NullDataSource())
    
    private let dataSource: DataSource
    private var manifestSyncCancellable: AnyCancellable? = nil
    
    public var currentManifest: AnyPublisher<CultureManifest, Never> { dataSource.currentManifest }
    public var supportedCultures: AnyPublisher<[Culture], Never> { dataSource.supportedCultures }

    @Published public var preferredCultures: [Culture]
    
    private init(dataSource: DataSource, preferredCultures: [Culture]? = nil) {
        self.dataSource = dataSource
        self.preferredCultures = preferredCultures ?? Locale.preferredLanguages.flatMap { code in
            if let culture = Culture(code: code) {
                return [culture]
            }
            if let language = Language(code: code) {
                return Array(language.culturesFallbackOrder)
            }
            return []
        }

        Task {
            do {
                try dataSource.loadCultures()
            } catch {}
        }
        startManifestSyncFlow()
    }

    public convenience init(config: LocaleHubSDKConfiguration = LocaleHubSDKConfiguration()) throws {
        guard let bundleUrl = config.bundleUrl ?? LocaleHubSDK.defaultOfflineBundleUrl else {
            throw LocaleHubSDKError.invalidOfflineBundlePath
        }
        
        if let remoteConfig = config.remoteDataSource {
            self.init(
                dataSource: RemoteDataSource(
                    offlineDataSource: try OfflineDataSource(bundleUrl: bundleUrl),
                    config: remoteConfig
                ),
                preferredCultures: config.preferredCultures
            )
        } else {
            self.init(
                dataSource: try OfflineDataSource(bundleUrl: bundleUrl),
                preferredCultures: config.preferredCultures
            )
        }
    }
    
    deinit {
        manifestSyncCancellable?.cancel()
    }
    
    private func startManifestSyncFlow() {
        manifestSyncCancellable = self.$preferredCultures
            .sink { cultures in
                do {
                    try self.dataSource.loadManifest(preferredCultures: cultures)
                } catch {
                    LocaleHubLogger.dataSource.error("Failed to load manifest for cultures: '\(cultures)'")
                }
            }
    }
}
