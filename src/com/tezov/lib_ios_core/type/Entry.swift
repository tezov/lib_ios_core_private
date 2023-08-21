public class Entry<KEY, VALUE> {
    public var key: KEY
    public var value: VALUE
    
    public init(key: KEY, value: VALUE) {
        self.key = key
        self.value = value
    }
}
