import LocaleHubTranslationModel

extension Culture {
    func pluralize(word: String, amount: Double) -> String {
        return self.language.pluralize(word: word, amount: amount)
    }
    
    func tryPluralize(word: String, amount: Double) -> String? {
        return self.language.tryPluralize(word: word, amount: amount)
    }
}
