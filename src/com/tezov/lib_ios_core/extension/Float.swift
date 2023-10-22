import Foundation

public extension Float {
    var binary: String {
        let value = String(self.bitPattern, radix: 2)
        let padding = String(repeating: "0", count: Swift.max(0, UInt32.bitWidth - value.count))
        return padding + value
    }

    var hex: String {
        let value = String(self.bitPattern, radix: 16, uppercase: true)
        let padding = String(repeating: "0", count: Swift.max(0, UInt32.byteWidth - value.count))
        return padding + value
    }

    var string: String { String(self) }
    var double: Double { Double(self) }
}
