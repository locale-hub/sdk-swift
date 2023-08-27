import Combine

protocol DataSource {
    var currentManifest: AnyPublisher<CultureManifest, Never> { get }
    var supportedCultures: AnyPublisher<[Culture], Never> { get }

    func loadCultures() throws
    func loadManifest(preferredCultures: [Culture]) throws
}

extension DataSource {
    func loadManifest(preferredCulture: Culture) throws {
        return try loadManifest(preferredCultures: [preferredCulture])
    }
}
