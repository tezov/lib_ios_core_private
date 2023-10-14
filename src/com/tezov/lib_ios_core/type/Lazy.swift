import SwiftUI

private enum UNINITIALIZED { case SELF }

@propertyWrapper public class Lazy<T: Any> {
    private var lazyValue: (() -> T)?
    private var value: Any = UNINITIALIZED.SELF

    public var wrappedValue: T {
        get {
            if value is UNINITIALIZED {
                value = lazyValue!()
                lazyValue = nil
            }
            return value as! T
        }
        set {
            lazyValue = nil
            self.value = newValue
        }
    }

    public init(wrappedValue: @escaping @autoclosure () -> T) {
        self.lazyValue = wrappedValue
    }

    public init(_ value: @escaping @autoclosure () -> T) {
        self.lazyValue = value
    }
}
