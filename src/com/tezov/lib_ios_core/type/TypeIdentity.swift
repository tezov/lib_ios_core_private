import Foundation

@propertyWrapper public class TypeIdentity: Hashable {
    public private(set) var value: Any!
    private var _id: ObjectIdentifier!
    public var id: Int { _id.hashValue }

    public var wrappedValue: Any {
        get { return value! }
        set {
            setValue(wrappedValue: newValue)
        }
    }

    private func setValue(wrappedValue: Any) {
        self.value = wrappedValue
        switch wrappedValue {
        case is Any.Type:
            self._id = ObjectIdentifier(wrappedValue as! Any.Type)
        default:
            self._id = ObjectIdentifier(type(of: wrappedValue))
        }
    }

    public init(wrappedValue: Any) {
        setValue(wrappedValue: wrappedValue)
    }

    public convenience init(_ value: Any) {
        self.init(wrappedValue: value)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(_id.hashValue)
    }

    public static func == (lhs: TypeIdentity, rhs: TypeIdentity) -> Bool { lhs._id == rhs._id }
}
