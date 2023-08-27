public struct CultureString: Codable {
    public let culture: Culture
    public let tokens: [TranslationToken]

    public init(culture: Culture, tokens: [TranslationToken]) {
        self.culture = culture
        self.tokens = tokens
    }
}
