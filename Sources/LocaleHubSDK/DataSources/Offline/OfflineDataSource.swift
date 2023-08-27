import Combine
import Foundation

struct OfflineBundleMetadata: Decodable {
    let baseCulture: Culture
}

class OfflineDataSource: DataSource {
    private let manifests: [Culture: CultureManifest]
    private let metadata: OfflineBundleMetadata

    @Published private var currentManifestBackingField: CultureManifest
    var currentManifest: AnyPublisher<CultureManifest, Never> { $currentManifestBackingField.eraseToAnyPublisher() }
    
    @Published private var supportedCulturesBackingField: [Culture] = []
    var supportedCultures: AnyPublisher<[Culture], Never> { $supportedCulturesBackingField.eraseToAnyPublisher() }
    
    init(bundleUrl: URL) throws {
        var manifests : [Culture: CultureManifest] = [:]
        do {
            let metadataContent = try Data(contentsOf: bundleUrl.appendingPathComponent("manifest.json"))
            self.metadata = try JSONDecoder().decode(OfflineBundleMetadata.self, from: metadataContent)
            
            for fileUrl in try FileManager.default.contentsOfDirectory(at: bundleUrl, includingPropertiesForKeys: [.isRegularFileKey]) {
                if fileUrl.lastPathComponent == "manifest.json" { continue }
                let cultureCode = fileUrl.deletingPathExtension().lastPathComponent
                guard let culture = Culture(code: cultureCode) else {
                    LocaleHubLogger.dataSource.warning("Unsupported culture code: '\(cultureCode)'.")
                    continue
                }
                
                let fileContent = try Data(contentsOf: fileUrl)
                let manifest = try JSONDecoder().decode(CultureManifest.self, from: fileContent)
                
                manifests[culture] = manifest
            }
        } catch is DecodingError {
            throw LocaleHubSDKError.invalidManifestData
        } catch {
            throw LocaleHubSDKError.invalidOfflineBundlePath
        }
        
        self.manifests = manifests
        
        self.supportedCulturesBackingField = Array(manifests.keys)
        self.currentManifestBackingField = self.manifests[metadata.baseCulture] ?? CultureManifest()
    }
    
    func loadCultures() {}
    
    func loadManifest(preferredCultures: [Culture]) throws {
        for culture in preferredCultures {
            if let manifest = manifests[culture] {
                currentManifestBackingField = manifest
                return
            }
        }
        
        if let manifest = manifests[metadata.baseCulture] {
            currentManifestBackingField = manifest
            return
        }
        
        fatalError("Offline LocaleHub bundle is corrupted")
    }
}
