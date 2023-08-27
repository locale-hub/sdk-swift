import LocaleHubTranslationModel

public extension CultureString {
    func render(manifest: CultureManifest, variables: [String: any CustomStringConvertible]) -> String {
        return self.tokens
            .map { tokenType in
                switch tokenType {
                case .text(let token, let processors):
                    return postProcess(token.literal, processors, variables)
                case .variable(let token, let processors):
                    return postProcess(variables[token.variableName]?.description ?? token.variableName, processors, variables)
                case .reference(let token, let processors):
                    return postProcess(manifest(token.key, variables), processors, variables)
                case .variableReference(let token, let processors):
                    return postProcess(manifest(manifest(token.variableName, variables), variables), processors, variables)
                }
            }
            .joined()
    }
    
    private func postProcess(_ text: String, _ processors: [TranslationProcessor]?, _ variables: [String: any CustomStringConvertible]) -> String {
        guard let processors else { return text }
        
        return processors.reduce(text, { previous, processor in
            switch processor {
            case .capitalize(let options):
                if options.eachWord == true {
                    return text.capitalized
                } else {
                    if text.isEmpty {
                        return ""
                    } else if text.count == 1 {
                        return text.uppercased()
                    }
                    
                    let firstLetter = text.prefix(1).capitalized
                    let remainingLetters = text.dropFirst().lowercased()
                    return firstLetter + remainingLetters
                }
            case .lowercase:
                return text.lowercased()
            case .uppercase:
                return text.uppercased()
            case .pluralize(let options):
                guard let amountVariable = variables[options.nVariableName] else { return text }
                guard let amount = toDouble(amountVariable) else { return text }
                return self.culture.pluralize(word: text, amount: amount)
            }
        })
    }
}


/*
 @@ -1,44 +0,0 @@
 import Foundation

 fileprivate func toDouble(_ value: any CustomStringConvertible) -> Double? {
     switch value {
     case let bi as any BinaryInteger:
         if let doubleAmount = Double(exactly: bi) {
             return doubleAmount
         }
         return nil
     case let f as Float:
         return Double(f)
     case let d as Double:
         return d
     default:
         if let doubleAmount = NumberFormatter().number(from: value.description)?.doubleValue {
             return doubleAmount
         }
         return nil
     }
 }

 struct CultureString: Codable {
     public let culture: Culture
     public let tokens: [TranslationToken]
     
     func render(manifest: CultureManifest, variables: [String: any CustomStringConvertible]) -> String {
         return self.tokens
             .map { token in
                 switch token {
                 case .constant(let token):
                     return token.value
                 case .variable(let token):
                     return variables[token.name]?.description ?? token.name
                 case .ref(let token):
                     return manifest(token.ref, variables)
                 case .plural(let token):
                     guard let amountVariable = variables[token.varName] else { return token.word }
                     guard let amount = toDouble(amountVariable) else { return token.word }
                     return self.culture.pluralize(word: token.word, amount: amount)
                 }
             }
             .joined()
     }
 }

 */
