import Foundation

extension HTTPURLResponse {
    var isSuccessful: Bool {
        self.statusCode >= 200 && self.statusCode < 300
    }
}
