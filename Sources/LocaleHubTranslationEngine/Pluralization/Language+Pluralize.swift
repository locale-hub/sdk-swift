import LocaleHubTranslationModel

extension Language {
    func pluralize(word: String, amount: Double) -> String {
        return tryPluralize(word: word, amount: amount) ?? word
    }
    
    func tryPluralize(word: String, amount: Double) -> String? {
        guard let pluralType = self.pluralCategory(for: amount, type: .cardinal) else {
            return nil
        }
        
        if pluralType == .one {
            return word
        }
        
        guard let rules = self.inflectionRules else {
            return nil
        }
        
        if rules.irregular.keys.contains(word) {
            return rules.irregular[word]
        }
        
        let pluralRules: [InflectionRule]? = switch pluralType {
        case .two: rules.two
        case .few: rules.few
        case .many: rules.many
        case .other: rules.other
        default: nil
        }
        guard let pluralRules else { return nil }
        
        if (pluralRules.count == 0) {
            return word
        }
        
        for rule in pluralRules {
            if let pluralized = rule.apply(value: word) {
                return pluralized
            }
        }
        
        return word
    }
}
