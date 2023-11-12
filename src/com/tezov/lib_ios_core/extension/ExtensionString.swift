import Foundation

public extension String {
    var isOnlyDigits: Bool { !self.isEmpty && self.allSatisfy { $0.isNumber } }

    var boolean: Bool? {
        let l = self.lowercased()
        if l == "true" || l == "1" || l == "yes" {
            return true
        }
        if l == "false" || l == "0" || l == "no" {
            return true
        }
        return nil
    }

    func boolean(fallback: Bool) -> Bool { self.boolean ?? fallback }

    var character: Character { Character(self) }

    var double: Double? { Double(self) }
    func double(fallback: Double) -> Double { self.double ?? fallback }

    var float: Float? { Float(self) }
    func float(fallback: Float) -> Float { self.float ?? fallback }

    var integer: Int? { Int(self) }
    func integer(fallback: Int) -> Int { self.integer ?? fallback }
}

public extension String {
    var hexToInt: Int? { Int(self, radix: 16) }
    func hexToInt(fallback: Int) -> Int { self.hexToInt ?? fallback }
    var binaryToInt: Int? { Int(self, radix: 2) }
    func binaryToInt(fallback: Int) -> Int { self.binaryToInt ?? fallback }

    var hexToFloat: Float? {
        if self.count > UInt32.byteWidth { return nil }
        let value = self.count == UInt32.byteWidth ? self : {
            let padding = String(repeating: "0", count: max(0, UInt32.byteWidth - self.count))
            return padding + self
        }()
        if let bitPattern = UInt32(value, radix: 16) {
            return Float(bitPattern: bitPattern)
        }
        return nil
    }

    func hexToFloat(fallback: Float) -> Float { self.hexToFloat ?? fallback }
    var binaryToFloat: Float? {
        let value = self.count == UInt32.byteWidth ? self : {
            let padding = String(repeating: "0", count: max(0, UInt32.bitWidth - self.count))
            return padding + self
        }()
        if let bitPattern = UInt32(value, radix: 2) {
            return Float(bitPattern: bitPattern)
        }
        return nil
    }

    func binaryToFloat(fallback: Float) -> Float { self.binaryToFloat ?? fallback }

    var hexToDouble: Double? {
        let value = self.count == UInt64.byteWidth ? self : {
            let padding = String(repeating: "0", count: max(0, UInt64.byteWidth - self.count))
            return padding + self
        }()
        if let bitPattern = UInt64(value, radix: 16) {
            return Double(bitPattern: bitPattern)
        }
        return nil
    }

    func hexToDouble(fallback: Double) -> Double { self.hexToDouble ?? fallback }
    var binaryToDouble: Double? {
        let value = self.count == UInt64.byteWidth ? self : {
            let padding = String(repeating: "0", count: max(0, UInt32.bitWidth - self.count))
            return padding + self
        }()
        if let bitPattern = UInt64(value, radix: 2) {
            return Double(bitPattern: bitPattern)
        }
        return nil
    }

    func binaryToDouble(fallback: Double) -> Double { self.binaryToDouble ?? fallback }
}

public extension String {
    subscript(_ index: Int) -> Character {
        get { self[self.index(of: index)] }
        set {
            let i = self.index(of: index)
            self.remove(at: i)
            self.insert(newValue, at: i)
        }
    }

    subscript(insertAt index: Int) -> String {
        get { fatalError("there is no getter") }
        set { self.insert(contentsOf: newValue, at: self.index(of: index)) }
    }

    func getOrNil(at index: Int) -> Character? {
        if index >= intIndex(of: startIndex), index < intIndex(of: endIndex) {
            return self[index]
        }
        return nil
    }
}

public extension String {
    var range: Range<String.Index> {
        startIndex ..< endIndex
    }

    var nsRange: NSRange {
        NSRange(startIndex ..< endIndex, in: self)
    }

    subscript(_ range: NSRange) -> String {
        String(self[Range(range, in: self)!])
    }

    mutating func replaceSubrange(_ range: NSRange, with subString: String) {
        replaceSubrange(Range(range, in: self)!, with: subString)
    }
}

extension String {

    func split(_ separator: String = " ") -> [String] {
        self.components(separatedBy: separator)
    }
}

public extension Character {
    var string: String { String(self) }
    var integer: Int? { self.string.integer }
    func integer(fallback: Int) -> Int { self.integer ?? fallback }
}

public extension Array where Self.Element == String {
    func join(_separator _: String = " ") -> String {
        self.joined(separator: " ")
    }
}
