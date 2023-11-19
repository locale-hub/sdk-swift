
public class CultureManifest: Codable {
    public let strings: [String: CultureString]
    
    public init() {
        self.strings = [:]
    }
    
    public init(strings: [String: CultureString]) {
        self.strings = strings
    }
}
