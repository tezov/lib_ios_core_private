import Foundation


public extension String {
   
    @available(iOS 4.0, *)
    var toRegex: NSRegularExpression {
        try! NSRegularExpression(pattern: self, options: [])
    }
}

public extension NSRegularExpression {
    func matches(_ input: String) -> [NSTextCheckingResult] {
        matches(in: input, options: [], range: input.nsRange)
    }
}
