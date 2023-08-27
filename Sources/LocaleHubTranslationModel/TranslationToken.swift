public struct TextTranslationTokenOptions: Codable {
    public var literal: String
    
    public init(literal: String) {
        self.literal = literal
    }
}

public struct VariableTranslationTokenOptions: Codable {
    public var variableName: String
    
    public init(variableName: String) {
        self.variableName = variableName
    }
}

public struct ReferenceTranslationTokenOptions: Codable {
    public var key: String
    
    public init(key: String) {
        self.key = key
    }
}

public struct VariableReferenceTranslationTokenOptions: Codable {
    public var variableName: String
    
    public init(variableName: String) {
        self.variableName = variableName
    }
}

public enum TranslationToken: Codable {
    enum CodingKeys: CodingKey {
        case processors
        case type
    }
    
    case text(token: TextTranslationTokenOptions, processors: [TranslationProcessor]? = nil)
    case variable(token: VariableTranslationTokenOptions, processors: [TranslationProcessor]? = nil)
    case reference(token: ReferenceTranslationTokenOptions, processors: [TranslationProcessor]? = nil)
    case variableReference(token: VariableReferenceTranslationTokenOptions, processors: [TranslationProcessor]? = nil)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let tokenType = try container.decode(TranslationTokenType.self, forKey: .type)
        let processors = try container.decodeIfPresent([TranslationProcessor].self, forKey: .processors)
        
        switch tokenType {
        case .text:
            self = .text(token: try TextTranslationTokenOptions(from: decoder), processors: processors)
        case .variable:
            self = .variable(token: try VariableTranslationTokenOptions(from: decoder), processors: processors)
        case .reference:
            if let refToken = try? ReferenceTranslationTokenOptions(from: decoder) {
                self = .reference(token: refToken, processors: processors)
            } else if let varRefToken = try? VariableReferenceTranslationTokenOptions(from: decoder) {
                self = .variableReference(token: varRefToken, processors: processors)
            } else {
                throw DecodingError.dataCorrupted(DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unable to decode translation token of type `reference`"
                ))
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .text(let token, let processors):
            try container.encode(TranslationTokenType.text, forKey: .type)
            try container.encodeIfPresent(processors, forKey: .processors)
            try token.encode(to: encoder)
        case .variable(let token, let processors):
            try container.encode(TranslationTokenType.variable, forKey: .type)
            try container.encodeIfPresent(processors, forKey: .processors)
            try token.encode(to: encoder)
        case .reference(let token, let processors):
            try container.encode(TranslationTokenType.reference, forKey: .type)
            try container.encodeIfPresent(processors, forKey: .processors)
            try token.encode(to: encoder)
        case .variableReference(let token, let processors):
            try container.encode(TranslationTokenType.reference, forKey: .type)
            try container.encodeIfPresent(processors, forKey: .processors)
            try token.encode(to: encoder)
        }
    }
}
