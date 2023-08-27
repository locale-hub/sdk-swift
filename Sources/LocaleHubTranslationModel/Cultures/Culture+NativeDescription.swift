public extension Culture {
    var nativeDescription: String {
        switch self {
        case .de_DE: return "Deutsch (Deutschland)"
        case .fr_BE: return "Français (Belge)"
        case .fr_CA: return "Français (Canadien)"
        case .fr_FR: return "Français (France)"
        case .es_AR: return "Español (Argentina)"
        case .es_BO: return "Español (Bolivia)"
        case .es_ES: return "Español (España)"
        case .es_MX: return "Español (Mexico)"
        case .es_PE: return "Español (Peru)"
        case .nb_NO: return "Norsk bokmål (Norway)"
        case .nn_NO: return "Norsk nynorsk (Norway)"
        case .no_NO: return "Norsk (Norway)"
        case .pt_BR: return "Português (Brasil)"
        case .pt_PT: return "Português (Portugal)"
        default: return self.englishDescription
        }
    }
}
