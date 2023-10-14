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
    func boolean(fallback: Bool) -> Bool { self.boolean ?? fallback}
    
    var character: Character { Character(self) }
    
    var double: Double? { Double(self) }
    func double(fallback: Double) -> Double { self.double ?? fallback}
    
    var float: Float? { Float(self) }
    func float(fallback: Float) -> Float { self.float ?? fallback}
    
    var integer: Int? { Int(self) }
    func integer(fallback: Int) -> Int { self.integer ?? fallback}
}

public extension String {
    private func toDouble(base: Int) -> Double? {
        if let bitPattern = UInt64(self, radix: base), (self.count / 2) == UInt64.byteWidth  {
            return Double(bitPattern: bitPattern)
        }
        return nil
    }
    
    private func toFloat(base: Int) -> Float? {
        if let bitPattern = UInt32(self, radix: base), (self.count / 2) == UInt32.byteWidth {
            return Float(bitPattern: bitPattern)
        }
        return nil
    }
    
    var hexToInt: Int? { Int(self, radix: 16) }
    func hexToInt(fallback: Int) -> Int { self.hexToInt ?? fallback}
    var binaryToInt: Int? { Int(self, radix: 2) }
    func binaryToInt(fallback: Int) -> Int { self.binaryToInt ?? fallback}
    
    var hexToFloat: Float? { toFloat(base: 16) }
    func hexToFloat(fallback: Float) -> Float { self.hexToFloat ?? fallback}
    var binaryToFloat: Float? { toFloat(base: 2) }
    func binaryToFloat(fallback: Float) -> Float { self.binaryToFloat ?? fallback}
    
    var hexToDouble: Double? { toDouble(base: 16) }
    func hexToDouble(fallback: Double) -> Double { self.hexToDouble ?? fallback}
    var binaryToDouble: Double? { toDouble(base: 2) }
    func binaryToDouble(fallback: Double) -> Double { self.binaryToDouble ?? fallback}
}

public extension String {
    func intIndex(of stringIndex: String.Index) -> Int {
        distance(from: startIndex, to: stringIndex)
    }
    
    func stringIndex(of intIndex: Int) -> String.Index {
        index(startIndex, offsetBy: intIndex)
    }
    
    func intIndex(of predicate: (Character) -> Bool) -> Int? {
        if let index = self.firstIndex(where: predicate) {
            return self.intIndex(of: index)
        }
        return nil
    }
    
    func intIndex(of char: Character) -> Int? {
        if let index = (self.firstIndex { char == $0 }) {
            return self.intIndex(of: index)
        }
        return nil
    }
    
    subscript(_ index: Int) -> Character {
        get { self[self.stringIndex(of: index)] }
        set {
            let i = self.stringIndex(of: index)
            self.remove(at: i)
            self.insert(newValue, at: i)
        }
    }
    
    subscript(insertAt index: Int) -> String {
        get { fatalError("use get without label") }
        set {
            let i = self.stringIndex(of: index)
            self.remove(at: i)
            self.insert(contentsOf: newValue, at: i)
        }
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
    var toSet:Set<String.Element> { Set(self) }
    var toSetOrdered:NSOrderedSet { NSOrderedSet(array: Array(self)) }
    
    func split(_ separator:String = " ") -> [String] {
        self.components(separatedBy: separator)
    }
    
    func split(_ separator: Character = " ", every: Int) -> [String] {
        let matches = String("(\\S+(\\s+\\S+){" + String(every - 1) + "})|\\S+").toRegex.matches(self)
        return matches.map { self[$0.range] }
    }
}

public extension Character {
    var string: String { String(self) }
    var integer: Int? { self.string.integer }
    func integer(fallback: Int) -> Int { self.integer ?? fallback}
}
