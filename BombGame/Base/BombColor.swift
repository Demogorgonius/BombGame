import UIKit

enum BombColor: UInt {
    case violet = 0x8130A7
    case yellowe = 0xFAFF00
    case orange = 0xF7F80B
    
    var color: UIColor {
        return UIColor(rgb: self.rawValue)
    }
}
