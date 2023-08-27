extension Language {
    public var nativeDescription: String {
        switch self {
        case .de: return "Deutsch"
        case .fr: return "Français"
        case .es: return "Español"
        case .it: return "Italiano"
        case .nb: return "Norsk bokmål"
        case .no: return "Norsk"
        case .pt: return "Português"
        default: return self.englishDescription
        }
    }
}
