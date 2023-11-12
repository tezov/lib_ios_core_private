import Foundation

public let NIL_INDEX = -1

public extension Int {
    
    var isNilIndex:Bool { self == NIL_INDEX }
    
    var isNotNilIndex:Bool { self != NIL_INDEX }
    
}

public extension Collection {
    var lastIndex: Self.Index { index(endIndex, offsetBy: -1) }

    func index(of intIndex: Int) -> Self.Index {
        index(startIndex, offsetBy: intIndex)
    }

    func intIndex(of index: Self.Index) -> Int {
        distance(from: startIndex, to: index)
    }

    func intIndex(of predicate: (Self.Element) -> Bool) -> Int? {
        if let index = self.firstIndex(where: predicate) {
            return self.intIndex(of: index)
        }
        return nil
    }

    func getOrNil(at index: Self.Index) -> Self.Element? {
        if index >= startIndex, index < endIndex {
            return self[index]
        }
        return nil
    }

    func lastOrNil() -> Self.Element? {
        if self.isEmpty { return nil }
        else {
            return self[lastIndex]
        }
    }

    func count(_ predicate: (Self.Element) -> Bool) -> (accepted: Int, refused: Int) {
        let accepted = self.reduce(0) { acc, element in
            predicate(element) ? acc + 1 : acc
        }
        return (accepted, self.count - accepted)
    }

    func partitioned(_ predicate: (Self.Element) -> Bool) -> (accepted: [Self.Element], refused: [Self.Element]) {
        var accepted: [Self.Element] = []
        var refused: [Self.Element] = []
        for element in self {
            predicate(element) ? accepted.append(element) : refused.append(element)
        }
        return (accepted, refused)
    }

    func sliced(of size: Int) -> [SubSequence] { sliced(of: [size]) }

    func sliced(of sizes: [Int], sizeForRemaining: Int? = nil) -> [SubSequence] {
        var result: [SubSequence] = []
        var chunkIndex = 0
        var currentIndex = self.startIndex
        while currentIndex < self.endIndex {
            let chunkSize: Int
            if chunkIndex < sizes.endIndex || sizeForRemaining == nil {
                chunkSize = sizes[chunkIndex % sizes.count]
                chunkIndex += 1
            }
            else {
                chunkSize = sizeForRemaining!
            }
            let endIndex = self.index(currentIndex, offsetBy: chunkSize, limitedBy: self.endIndex) ?? self.endIndex
            result.append(self[currentIndex ..< endIndex])
            currentIndex = endIndex
        }
        return result
    }
    
    func distinctBy<T: Hashable>(_ keyClosure: (Element) -> T) -> [Element] {
        var uniqueKeys = Set<T>()
        return filter { uniqueKeys.insert(keyClosure($0)).inserted }
    }
    
}

public extension Collection where Self.Element: Equatable {
    
    func intIndex(of element: Self.Element) -> Int? {
        if let index = (self.firstIndex { element == $0 }) {
            return self.intIndex(of: index)
        }
        return nil
    }
}

public extension Array where Self.Element: Hashable {
    var toSet: Set<Array.Element> { Set(self) }
    var toSetOrdered: NSOrderedSet { NSOrderedSet(array: Array(self)) }
    
    func intersection(_ other: [Element]) -> [Element] {
        let me = Set(self)
        let other = Set(other)
        return me.intersection(other).toArray
    }
    
    func subtract(_ other: [Element]) -> [Element] {
        self.toSet.subtracting(other.toSet).toArray
    }
}

public extension Set {
    var toArray: Array<Set.Element> { Array(self) }
}

public extension NSOrderedSet {
    var toArray: Array<NSOrderedSet.Element> { Array(self) }
}
