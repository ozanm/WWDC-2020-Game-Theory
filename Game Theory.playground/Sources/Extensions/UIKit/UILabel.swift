import UIKit

public extension UILabel {
    func alert() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat,.autoreverse], animations: {
            self.alpha = 0
        }, completion: nil)
    }
    
    func animate(paint color: UIColor, with duration: Double = 0.5, after delay: Double = 0, completion: @escaping ((Bool) -> Void) = { _ in }) {
        UIView.transition(with: self, duration: duration, options: .curveEaseIn, animations: {
            self.textColor = color
        }, completion: completion)
    }
    
    func animate(for alignment: NSTextAlignment, with duration: Double = 0.5, after delay: Double = 0, completion: @escaping ((Bool) -> Void) = { _ in }) {
        UIView.transition(with: self, duration: duration, options: .curveEaseIn, animations: {
            self.textAlignment = alignment
        }, completion: completion)
    }
    
    func animate(text string: String, with duration: Double = 0.5, after delay: Double = 0, completion: @escaping ((Bool) -> Void) = { _ in }) {
        self.fade(type: .Out, with: 0.25) { _ in
            self.text = string
            self.fade(type: .In, with: 0.25)
        }
    }
}
