public class Klass: Hashable {
    private let identifiable: KlassIdentifiable.Type

    public init(identifiable: KlassIdentifiable.Type) {
        self.identifiable = identifiable
    }

    public func hash(into hasher: inout Hasher) {
        identifiable.klassIdentifiers.forEach { klassIdentifier in
            hasher.combine(klassIdentifier.hashValue)
        }
    }

    public func isInstance(of type: Klass) -> Bool {
        identifiable.klassIdentifiers.last == type.identifiable.klassIdentifiers.last
    }

    public func isSubInstance(of type: Klass) -> Bool {
        let identifier = type.identifiable.klassIdentifiers.last
        for i in 0 ..< (identifiable.klassIdentifiers.count - 1) {
            if identifiable.klassIdentifiers[i] == identifier {
                return true
            }
        }
        return false
    }

    public func isKind(of type: Klass) -> Bool {
        let identifier = type.identifiable.klassIdentifiers.last
        for i in 0 ..< (identifiable.klassIdentifiers.count) {
            if identifiable.klassIdentifiers[i] == identifier {
                return true
            }
        }
        return false
    }

    public static func == (lhs: Klass, rhs: Klass) -> Bool { lhs.hashValue == rhs.hashValue }
}

public protocol KlassIdentifiable {
    static var klassIdentifiers: [ObjectIdentifier] { get }
}

public extension KlassIdentifiable {
    static func klassIdentifierCombine(_ type: KlassIdentifiable.Type) -> [ObjectIdentifier] {
        var mt: [ObjectIdentifier] = []
        self.klassIdentifiers.forEach { mt.append($0) }
        mt.append(ObjectIdentifier(type.self))
        return mt
    }

    static func klass() -> Klass { Klass(identifiable: self) }

    func klass() -> Klass { Klass(identifiable: type(of: self)) }
}
