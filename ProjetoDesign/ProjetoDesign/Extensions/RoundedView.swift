import UIKit

class extensions: UIView {
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                addShadow()
            }
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }

        set {
            layer.cornerRadius = newValue

            if shadow == false {
                layer.masksToBounds = true
            }
        }
    }

    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
