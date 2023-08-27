public struct CapitalizeTranslationProcessorOptions: Codable {
    public var eachWord: Bool? = nil
}

public struct PluralizeTranslationProcessorOptions: Codable {
    public var nVariableName: String
}

public enum TranslationProcessor: Codable {
    enum CodingKeys: CodingKey {
        case type
    }

    case capitalize(_ options: CapitalizeTranslationProcessorOptions)
    case lowercase
    case pluralize(_ options: PluralizeTranslationProcessorOptions)
    case uppercase
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let processorType = try container.decode(TranslationProcessorType.self, forKey: .type)
        
        switch processorType {
        case .capitalize:
            self = .capitalize(try CapitalizeTranslationProcessorOptions(from: decoder))
        case .lowercase:
            self = .lowercase
        case .pluralize:
            self = .pluralize(try PluralizeTranslationProcessorOptions(from: decoder))
        case .uppercase:
            self = .uppercase
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .capitalize(let options):
            try container.encode(TranslationProcessorType.capitalize, forKey: .type)
            try options.encode(to: encoder)
        case .lowercase:
            try container.encode(TranslationProcessorType.lowercase, forKey: .type)
        case .pluralize(let options):
            try container.encode(TranslationProcessorType.pluralize, forKey: .type)
            try options.encode(to: encoder)
        case .uppercase:
            try container.encode(TranslationProcessorType.uppercase, forKey: .type)
        }
    }
}
