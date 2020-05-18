import UIKit

public class Marker: UILabel {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(mark: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        self.text = "\(mark)."
        self.textAlignment = .center
        self.textColor =  .white
        self.font = UIFont.systemFont(ofSize: 25, weight: .light)
        self.setCornerRadius(with: 25)
    }
}

public class Question: UIVisualEffectView {
    
    public enum Style {
        case light, dark
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(frame: CGRect) {
        super.init(effect: UIBlurEffect(style: .systemThinMaterialLight))
        self.frame = frame
    }
    
    public func createText(style: Style, with text: String) {
        let lbl = UILabel(frame: self.bounds)
        lbl.frame.origin = CGPoint(x: 20, y: 20)
        lbl.frame.size = CGSize(width: lbl.frame.size.width - 40, height: lbl.frame.size.height)
        lbl.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        lbl.text = " \(text)"
        lbl.textColor = style == .light ? .black : .white
        lbl.numberOfLines = 2
        self.contentView.addSubview(lbl)
        self.setCornerRadius(with: 20)
        self.fade(type: .Out)
    }
}
