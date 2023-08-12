import UIKit

extension UIFont {
    
    class var regular16: UIFont {
        return UIFont(name: "DelaGothicOne-Regular", size: 16) ??  UIFont.systemFont(ofSize: 16, weight: .bold)
        
    }
    
    class var regular24: UIFont {
        return UIFont(name: "DelaGothicOne-Regular", size: 22) ??  UIFont.systemFont(ofSize: 22, weight: .bold)
        
    }
    
    class var bold32: UIFont {
        return UIFont(name: "DelaGothicOne-Regular", size: 32) ??  UIFont.systemFont(ofSize: 32, weight: .bold)
    }
    
    class var bold48: UIFont {
        return UIFont(name: "DelaGothicOne-Regular", size: 48) ?? UIFont.systemFont(ofSize: 48, weight: .bold)
    }
}
