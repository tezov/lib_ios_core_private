
public protocol Flattenable {
    var flatten: Any? { get }
}

extension Optional: Flattenable {
    public var flatten: Any? {
        switch self {
        case let .some(x as Flattenable): return x.flatten
        case let .some(x): return x
        case .none: return nil
        }
    }
}

public extension Optional {
    var isNil: Bool { flatten == nil }

    var isNotNil: Bool { flatten != nil }

    var isInitialized: Bool {
        if case .none = self {
            return true
        }
        else {
            return false
        }
    }
}
