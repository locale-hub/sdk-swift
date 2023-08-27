public struct TranslationString: Codable {
    public var tokens: [TranslationToken]
    
    public init(_ tokens: [TranslationToken]) {
        self.tokens = tokens
    }
}
