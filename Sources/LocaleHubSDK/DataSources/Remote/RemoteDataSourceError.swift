import Foundation

enum RemoteDataSourceError: Error {
    case invalidArgument(name: String, reason: String)
    case invalidData(_: Data)
    case invalidResponse(_: URLResponse)
    case invalidURL(_: String)
}
