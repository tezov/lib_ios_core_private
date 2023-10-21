import SwiftUI

@propertyWrapper public class Lazy<T: Any> {
    private var lazyValue: (() -> T)?
    private var value: T? = .none

    public var wrappedValue: T {
        get {
            value ?? {
                value = lazyValue!()
                lazyValue = .none
                return value!
            }()
        }
        set {
            lazyValue = .none
            self.value = newValue
        }
    }

    public init(wrappedValue: @escaping @autoclosure () -> T) {
        self.lazyValue = wrappedValue
    }

    public init(_ value: @escaping @autoclosure () -> T) {
        self.lazyValue = value
    }
    
    public func exist() -> Bool {
        if case .none = lazyValue {
            return true
        }
        else {
            return false
        }
    }
}
