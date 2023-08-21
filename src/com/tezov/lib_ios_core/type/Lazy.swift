private enum UNINITIALIZED { case SELF }

@propertyWrapper public class Lazy<T: Any> {
    private var lazyValue: (() -> T)?
    private var _value: Any = UNINITIALIZED.SELF

    public var wrappedValue: T {
        get {
            if _value is UNINITIALIZED {
                _value = lazyValue!()
                lazyValue = nil
            }
            return _value as! T
        }
        set {
            lazyValue = nil
            self._value = newValue
        }
    }

    public init(wrappedValue: @escaping @autoclosure () -> T) {
        self.lazyValue = wrappedValue
    }

    public init(_ value: @escaping @autoclosure () -> T) {
        self.lazyValue = value
    }
}
