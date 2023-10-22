import Foundation

@propertyWrapper public class ClassWrapper<T: Any> {
    private var value: T
    public var wrappedValue: T {
        get { value }
        set { value = newValue }
    }

    public init(wrappedValue: T) {
        value = wrappedValue
    }
}
