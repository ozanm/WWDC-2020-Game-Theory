import UIKit

public extension UIButton {
    func superview() -> UIView {
        return self.superview!.superview!.superview!
    }
    
    func addImageForCircular(with image: String) -> UIView {
        let container = UIView(frame: self.frame)
        
        self.frame.origin = .zero
        container.addSubview(self)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.image = UIImage(named: image)
        container.addSubview(imageView)
        imageView.centerInView(with: .both)
        
        return container
    }
}
