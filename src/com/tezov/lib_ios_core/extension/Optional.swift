
public protocol Flattenable {
    func flatten() -> Any?
}

extension Optional: Flattenable {
    public func flatten() -> Any? {
        switch self {
        case let .some(x as Flattenable): return x.flatten()
        case let .some(x): return x
        case .none: return nil
        }
    }
}

public extension Optional {
    func isNil() -> Bool { flatten() == nil }

    func isNotNil() -> Bool { flatten() != nil }
}
