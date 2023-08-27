import LocaleHubTranslationModel

// https://cldr.unicode.org/index/cldr-spec/plural-rules
// https://www.unicode.org/cldr/charts/43/supplemental/language_plural_rules.html

enum PluralCategory {
    case zero
    case one
    case two
    case few
    case many
    case other
}

enum PluralType {
    case cardinal
    case ordinal
}

extension Language {
    func pluralCategory(for amount: Double, type: PluralType = .cardinal) -> PluralCategory? {
        switch (self, type) {
        case (.en, .cardinal):
            if amount.i == 1 {
                // TODO: condition should include amount.v == 0 as well
                return .one
            }
            return .other
        case (.fr, .cardinal):
            // TODO: this is not based on Unicode plural rules, it's a quick&dirty™️ implementation
            if amount.i == 0 || amount.i == 1 {
                return .one
            }
            return .other
            
        default:
            return nil
        }
    }
}

fileprivate extension Double {
    // http://unicode.org/reports/tr35/tr35-numbers.html#Language_Plural_Rules
    
    var n: Double {
        self.magnitude
    }
    
    var i: Int64 {
        Int64(self)
    }
}
