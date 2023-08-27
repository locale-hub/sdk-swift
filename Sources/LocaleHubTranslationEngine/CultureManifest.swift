import LocaleHubTranslationModel

extension CultureManifest {
    public func callAsFunction(_ translationKey: String, _ variables: [String: any CustomStringConvertible] = [:]) -> String {
        if let string = self.strings[translationKey] {
            return string.render(manifest: self, variables: variables)
        } else {
            LocaleHubLogger.translate.error("Unknown translation key in manifest: '\(translationKey)'")
            return translationKey
        }
    }
}
