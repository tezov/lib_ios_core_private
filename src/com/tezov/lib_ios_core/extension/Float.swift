import Foundation


public extension Float {
    var binary: String { String(self.bitPattern, radix: 2) }
    var hex: String { String(self.bitPattern, radix: 16, uppercase: true) }
    var string: String { String(self) }
}
