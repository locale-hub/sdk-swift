import Combine

class NullDataSource: DataSource {
    @Published private var currentManifestMutable: CultureManifest = CultureManifest()
    var currentManifest: AnyPublisher<CultureManifest, Never> { AnyPublisher($currentManifestMutable) }
    
    
    @Published private var supportedCulturesMutable: [Culture] = []
    var supportedCultures: AnyPublisher<[Culture], Never> { AnyPublisher($supportedCulturesMutable) }
    
    func loadCultures() {}

    func loadManifest(preferredCultures: [Culture]) {}
}
