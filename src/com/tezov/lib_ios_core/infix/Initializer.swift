infix operator ?!: DefaultPrecedence
public func ?! <T>(
    value: T?,
    initializer: () -> Void
) { let _:Any = value ?? initializer() }
