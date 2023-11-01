

public extension Optional where Wrapped == Bool {
    var isTrue: Bool { self == true }

    var isTrueOrNull: Bool { isTrue || self == nil }

    var isFalse: Bool { self == false }

    var isFalseOrNull: Bool { isFalse || self == nil }
}
