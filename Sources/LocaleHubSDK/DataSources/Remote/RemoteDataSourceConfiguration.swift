import Foundation

struct RemoteDataSourceConfiguration {
    let apiKey: String
    let deploymentTag: String
    let endpoint: URL
    let projectId: String
    
    init(endpoint: URL, projectId: String, deploymentTag: String, apiKey: String) {
        self.apiKey = apiKey
        self.deploymentTag = deploymentTag
        self.endpoint = endpoint
        self.projectId = projectId
    }
}
