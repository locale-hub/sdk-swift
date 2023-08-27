import Foundation

public struct LocaleHubSDKConfiguration {
    let bundleUrl: URL?
    let preferredCultures: [Culture]?
    let remoteDataSource: RemoteDataSourceConfiguration?
    
    public init(
        bundleUrl: URL? = Bundle.main.url(forResource: "Offline", withExtension: "localehub"),
        preferredCultures: [Culture]? = nil
    ) {
        self.bundleUrl = bundleUrl
        self.preferredCultures = preferredCultures
        self.remoteDataSource = nil
    }
    
    public init(
        endpoint: URL,
        projectId: String,
        deploymentTag: String,
        apiKey: String,
        preferredCultures: [Culture]? = nil,
        bundleUrl: URL? = Bundle.main.url(forResource: "Offline", withExtension: "localehub")
    ) {
        self.bundleUrl = bundleUrl
        self.preferredCultures = preferredCultures
        self.remoteDataSource = RemoteDataSourceConfiguration(endpoint: endpoint, projectId: projectId, deploymentTag: deploymentTag, apiKey: apiKey)
    }
}
