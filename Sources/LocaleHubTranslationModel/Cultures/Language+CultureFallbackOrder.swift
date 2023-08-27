import OrderedCollections
import Foundation

extension Language {
    public var culturesFallbackOrder: [Culture] {
        switch self {
        case .en:
            return generateFallbacks(self, [.en_US, .en_GB])
        case .fr:
            return generateFallbacks(self, [.fr_FR, .fr_CA, .fr_BE, .fr_CH])
        default:
            return self.cultures
        }
    }
}

fileprivate func generateFallbacks(_ language: Language, _ fallback: [Culture]) -> [Culture] {
    var f = fallback
    f.append(contentsOf: language.cultures)
    return Array(OrderedSet(f).prefix(5))
}
