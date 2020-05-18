import UIKit

extension UIImageView {
    func update(to name: String) {
        self.fade(type: .Out, with: 0.25) { _ in
            self.image = UIImage.image(named: name)
            self.fade(type: .In, with: 0.25)
        }
    }
    
    func correctBackground(at position: CGPoint) {
        self.backgroundColor = self.image?.getPixelColor(pos: position)
    }
}
