import Foundation

public extension Int {
    var binary: String { String(self, radix: 2) }
    var hex: String { String(self, radix: 16, uppercase: true) }
    var string: String { String(self) }
}

public extension UInt8 {
    static var byteWidth = 1
}

public extension UInt32 {
    static var byteWidth = UInt64.bitWidth / UInt8.bitWidth
}

public extension UInt64 {
    static var byteWidth = UInt64.bitWidth / UInt8.bitWidth
}
