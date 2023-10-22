import Foundation

public extension Collection {
    func getOrNil(at index: Self.Index) -> Self.Element? {
        if index >= startIndex, index < endIndex {
            return self[index]
        }
        return nil
    }

    func count(_ predicate: (Self.Element) -> Bool) -> (accepted: Int, refused: Int) {
        let accepted = self.reduce(0) { acc, element in
            predicate(element) ? acc + 1 : acc
        }
        return (accepted, self.count - accepted)
    }

    func partition(_ predicate: (Self.Element) -> Bool) -> (accepted: [Self.Element], refused: [Self.Element]) {
        var accepted: [Self.Element] = []
        var refused: [Self.Element] = []
        for element in self {
            predicate(element) ? accepted.append(element) : refused.append(element)
        }
        return (accepted, refused)
    }

    func slice(of size: Int) -> [SubSequence] { slice(of: [size]) }

    func slice(of sizes: [Int], sizeForRemaining: Int? = nil) -> [SubSequence] {
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
}

public extension Array where Element == String {
    func join(_separator _: String = " ") -> String {
        self.joined(separator: " ")
    }
}
