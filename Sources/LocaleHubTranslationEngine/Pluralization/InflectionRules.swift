struct InflectionRules {
    let irregular: [String: String]
    let zero: [InflectionRule]
    let two: [InflectionRule]
    let few: [InflectionRule]
    let many: [InflectionRule]
    let other: [InflectionRule]
    
    init(
        irregular: [String : String] = [:],
        zero: [InflectionRule] = [],
        two: [InflectionRule] = [],
        few: [InflectionRule] = [],
        many: [InflectionRule] = [],
        other: [InflectionRule]) {
        self.irregular = irregular
        self.zero = zero
        self.two = two
        self.few = few
        self.many = many
        self.other = other
    }
}
