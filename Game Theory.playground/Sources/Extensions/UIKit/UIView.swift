import UIKit

public extension UIView {
    
    struct Transform {
        public var scaleX: CGFloat!
        public var scaleY: CGFloat!
        public var isIdentity: Bool!
        
        public init(scaleX: CGFloat, scaleY: CGFloat) {
            self.scaleX = scaleX
            self.scaleY = scaleY
            self.isIdentity = scaleX == 1 && scaleY == 1
        }
    }
    
    enum FadeType: CGFloat {
        case In = 1
        case Out = 0
    }
    
    func reframe() -> UIView {
        let originalSubviews = self.subviews
        self.subviews.forEach({ $0.removeFromSuperview() })
        
        for i in 0..<originalSubviews.count {
            self.addSubview(originalSubviews[originalSubviews.count - i - 1])
        }
        
        return self
    }
    
    func setCornerRadius(with radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    enum CenterTypes {
        case horizontally, vertically, both
    }
    
    func centerInView(with type: CenterTypes) {
        switch type {
        case .both:
            self.center = CGPoint(x: superview!.frame.size.width / 2, y: superview!.frame.size.height / 2)
        case .horizontally:
            self.center.x = superview!.frame.size.width / 2
        case .vertically:
            self.center.y = superview!.frame.size.height / 2
        }
    }
    
    func animate(to location: CGPoint, with duration: Double = 0.5, after delay: Double = 0, completion: @escaping ((Bool) -> Void) = { _ in }) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.frame.origin = location
        }, completion: completion)
    }
    
    func animate(change size: CGSize, with duration: Double = 0.5, after delay: Double = 0, completion: @escaping ((Bool) -> Void) = { _ in }) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.frame.size = size
        }, completion: completion)
    }
    
    func animate(by scale: Transform, with duration: Double = 0.5, after delay: Double = 0, completion: @escaping ((Bool) -> Void) = { _ in }) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: scale.scaleX, y: scale.scaleY)
        }, completion: completion)
    }
    
    func fade(type: FadeType, with duration: Double = 0.5, after delay: Double = 0, completion: @escaping ((Bool) -> Void) = { _ in }) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = type.rawValue
        }, completion: completion)
    }
    
    static func fade(type: FadeType, these views: [UIView], with duration: Double = 0.5, after delay: Double = 0, completion: @escaping ((Bool) -> Void) = { _ in }) {
        views.forEach({ $0.fade(type: type, with: duration, after: delay) })
        DispatchQueue.main.asyncAfter(deadline: .now() + duration + delay) {
            completion(true)
        }
    }
    
    func setBackground(as image: UIImage) {
        let background = UIImageView(frame: self.bounds)
        background.frame.origin = CGPoint(x: -200, y: -200)
        background.frame.size = CGSize(width: background.frame.size.width + 400, height: background.frame.size.height + 400)
        background.image = image
        background.contentMode = .scaleAspectFill
        
        self.insertSubview(background, at: 0)
    }
    
    func apply(subLayer layer: CALayer) {
        layer.frame = self.bounds
        let view = UIView(frame: self.bounds)
        view.layer.addSublayer(layer)
        
        self.addSubview(view)
    }
    
    func position() -> Int? {
        for i in 0..<self.superview!.subviews.count {
            if self.superview!.subviews[i].isEqual(self) {
                return i
            }
        }
        
        return nil
    }
    
    func nextSubview(for view: UIView) -> UIView? {
        if let offset = view.position() {
            if (offset + 1) != self.subviews.count {
                return self.subviews[offset + 1]
            }
        }
        
        return nil
    }
}
