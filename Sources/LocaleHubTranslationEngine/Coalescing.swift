import Foundation

func toDouble(_ value: any CustomStringConvertible) -> Double? {
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
