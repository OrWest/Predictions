import Foundation

extension Int {

    static func random(max uniform: Int? = nil) -> Int {

        if let uniform = uniform {
            return Int(arc4random_uniform(UInt32(uniform)))
        } else {
            return Int(arc4random())
        }

    }

}