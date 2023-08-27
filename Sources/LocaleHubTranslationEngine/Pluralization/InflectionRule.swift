protocol InflectionRule {
    func apply(value: String) -> String?
}

struct RegexInflectionRule<T: RegexComponent>: InflectionRule {
    public let match: T
    public let replace: (T.RegexOutput) -> String
    
    func apply(value: String) -> String? {
        guard let _ = value.firstMatch(of: match) else {
            return nil
        }
        
        return value.replacing(self.match, maxReplacements: 1) { m in
            return self.replace(m.output)
        }
    }
}
