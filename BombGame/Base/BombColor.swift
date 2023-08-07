import UIKit

enum BombColor: UInt {
    case violet = 0x8130A7
    case yellow = 0xFAFF00
    case orange = 0xFF9B05
    
    var color: UIColor {
        return UIColor(rgb: self.rawValue)
    }
}
