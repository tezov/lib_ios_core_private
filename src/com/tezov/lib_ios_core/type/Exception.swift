
fileprivate var _metaIdentifier = [ObjectIdentifier(Exception.self)]

public class Exception: Error, KlassIdentifiable {
    let message: String

    public init(message: String) {
        self.message = message
    }
    
    open class var klassIdentifiers: [ObjectIdentifier] { _metaIdentifier }
}
