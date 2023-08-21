
public class ListEntry<KEY: Equatable, VALUE> {
    private var list: [Entry<KEY, VALUE>] = []

    public init() { }

    @discardableResult
    public func add(key: KEY, value: VALUE) -> Bool {
        list.append(Entry(key: key, value: value))
        return true
    }

    @discardableResult
    public func set(key: KEY, value: VALUE) -> Bool {
        if let it = (list.first { p in p.key == key }) {
            it.value = value
            return true
        }
        return false
    }

    @discardableResult
    public func put(key: KEY, value: VALUE) -> Bool {
        if let it = (list.first { p in p.key == key }) {
            it.value = value
            return false
        }
        list.append(Entry(key: key, value: value))
        return true
    }

    public func getValue(_ key: KEY) -> VALUE? {
        list.first { p in p.key == key }?.value
    }

    public func forEach(_ body: (Entry<KEY, VALUE>) -> Void) {
        for i in list.indices { body(list[i]) }
    }

    public func find(_ body: (Entry<KEY, VALUE>) -> Bool) -> Entry<KEY, VALUE>? {
        for i in list.indices {
            let value = list[i]
            if body(value) { return value }
        }
        return nil
    }
}
