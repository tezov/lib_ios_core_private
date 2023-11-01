import Foundation

public extension Int {
    var binary: String { String(self, radix: 2) }
    func binary(bitWidth: Int) -> String? {
        let value = self.binary
        let paddingCount = bitWidth - value.count
        if paddingCount >= 0 {
            return String(repeating: "0", count: Swift.max(0, paddingCount)) + value
        }
        return nil
    }

    func binary(bitWidth: Int, fallback: String) -> String { self.binary(bitWidth: bitWidth) ?? fallback }

    func binary(byteWidth: Int) -> String? {
        binary(bitWidth: byteWidth * UInt8.bitWidth)
    }

    func binary(byteWidth: Int, fallback: String) -> String { self.binary(byteWidth: byteWidth) ?? fallback }

    var hex: String { String(self, radix: 16, uppercase: true) }
    func hex(byteWidth: Int) -> String? {
        let value = self.hex
        let paddingCount = byteWidth - value.count
        if paddingCount >= 0 {
            return String(repeating: "0", count: Swift.max(0, paddingCount)) + value
        }
        return nil
    }

    func hex(byteWidth: Int, fallback: String) -> String { self.hex(byteWidth: byteWidth) ?? fallback }

    var string: String { String(self) }
    var double: Double { Double(self) }
    var float: Float { Float(self) }
}

public extension UInt8 {
    static var byteWidth = 1
}

public extension UInt32 {
    static var byteWidth = UInt32.bitWidth / UInt8.bitWidth
}

public extension UInt16 {
    static var byteWidth = UInt16.bitWidth / UInt8.bitWidth
}

public extension UInt64 {
    static var byteWidth = UInt64.bitWidth / UInt8.bitWidth
}
