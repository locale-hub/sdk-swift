import LocaleHubTranslationModel

extension Language {
    var inflectionRules: InflectionRules? {
        switch self {
        case .en:
            return InflectionRules(
                irregular: [
                    "aircraft": "aircraft",
                    "alias": "aliases",
                    "alumna": "alumnae",
                    "apex": "apexes",
                    "audio": "audio",
                    "bison": "bison",
                    "child": "children",
                    "curriculum": "curricula",
                    "deer": "deer",
                    "equipment": "equipment",
                    "fish": "fish",
                    "foot": "feet",
                    "focus": "foci",
                    "genus": "genera",
                    "goose": "geese",
                    "gold": "gold",
                    "information": "information",
                    "larva": "larvae",
                    "money": "money",
                    "ox": "oxen",
                    "person": "people",
                    "police": "police",
                    "series": "series",
                    "sex": "sexes",
                    "sheep": "sheep",
                    "species": "species",
                    "swine": "swine",
                    "trout": "trout",
                    "tooth": "teeth",
                    "tuna": "tuna",
                    "vita": "vitae",
                ],
                other: [
                    RegexInflectionRule(match: #/(quiz)$/#, replace: { "\($0.1)izes" }),
                    RegexInflectionRule(match: #/([m|l])ouse$/#, replace: { "\($0.1)ice" }),
                    RegexInflectionRule(match: #/(.+)([ei])x$/#, replace: { "\($0.1)ices" }),
                    RegexInflectionRule(match: #/(z|x|ch|ss|sh)$/#, replace: { "\($0.1)es" }),
                    RegexInflectionRule(match: #/([^aeiouy]|qu)y$/#, replace: { "\($0.1)ies" }),
                    RegexInflectionRule(match: #/(hive)$/#, replace: { "\($0.1)s" }),
                    RegexInflectionRule(match: #/(?:([^f])fe|([lr])f)$/#, replace: { "\($0.1 ?? "")\($0.2 ?? "")ves" }),
                    RegexInflectionRule(match: #/(shea|lea|loa|thie)f$/#, replace: { "\($0.1)ves" }),
                    RegexInflectionRule(match: #/sis$/#, replace: { _ in "ses" }),
                    RegexInflectionRule(match: #/([ti])um$/#, replace: { "\($0.1)a" }),
                    RegexInflectionRule(match: #/(tomat|potat|ech|her|vet)o$/#, replace: { "\($0.1)oes" }),
                    RegexInflectionRule(match: #/(bu)s$/#, replace: { "\($0.1)ses" }),
                    RegexInflectionRule(match: #/(octop|vir)us$/#, replace: { "\($0.1)i" }),
                    RegexInflectionRule(match: #/(ax|test)is$/#, replace: { "\($0.1)es" }),
                    RegexInflectionRule(match: #/(us)$/#, replace: { "\($0.1)es" }),
                    
                    // DIRTYFIX: Negative lookbehinds are not supported as of now, so we catch the "human" case before hand
                    // Original rule: RegexInflectionRule(match: #/((.*)(?<!hu))man$/#, replace: { "\($0.1)men" }),
                    RegexInflectionRule(match: #/human$/#, replace: { _ in "human" }),
                    RegexInflectionRule(match: #/(.*)man$/#, replace: { "\($0.1)men" }),
                    // END DIRTYFIX
                    
                    RegexInflectionRule(match: #/s$/#, replace: { _ in "s" }),
                    RegexInflectionRule(match: #/$/#, replace: { _ in "s" }),
                ]
            )
        case .fr:
            return InflectionRules(
                irregular: [:],
                other: [
                    RegexInflectionRule(match: #/al$/#, replace: { _ in "aux" }),
                    RegexInflectionRule(match: #/eau$/#, replace: { _ in "eaux" }),
                    RegexInflectionRule(match: #/s$/#, replace: { _ in "s" }),
                    RegexInflectionRule(match: #/$/#, replace: { _ in "s" }),
                ]
            )
        default:
            return nil
        }
    }
}
