import UIKit

public class IconEffectButton: UIView {
    
    public var target: (UIButton) -> () = { _ in }
    
    private let background: UIVisualEffectView = UIVisualEffectView()
    private let icon: UIImageView = UIImageView()
    private let button: UIButton = UIButton()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setLayers()
        self.setFrame()
    }
    
    @objc private func action(_ sender: UIButton!) {
        self.target(sender)
    }
    
    public func setLayers() {
        self.addSubview(background)
        self.addSubview(icon)
        self.addSubview(button)
        
        self.button.addTarget(self, action: #selector(self.action(_:)), for: .touchUpInside)
    }
    
    public func setFrame() {
        self.background.frame = self.bounds
        self.button.frame = self.bounds
        
        let iconSize = self.frame.size.height - 30
        self.icon.frame.size = CGSize(width: iconSize, height: iconSize)
        self.icon.centerInView(with: .both)
    }
    
    public func apply(background effect: UIBlurEffect.Style) {
        self.background.effect = UIBlurEffect(style: effect)
    }
    
    public func apply(icon image: String) {
        self.icon.update(to: image)
    }
    
    public func base() -> UIButton {
        return self.button
    }
    
    public class func applyTitle(title: String, on button: IconEffectButton, with style: String = "dark") -> UIView {
        button.removeFromSuperview()
        
        let titleBtn = UIView(frame: button.frame)
        
        button.frame.origin = .zero
        
        titleBtn.addSubview(button)
        titleBtn.frame.size.height += 40
        
        let titleLbl = UILabel(frame: CGRect(x: 0, y: button.frame.size.height, width: titleBtn.frame.size.width, height: 40))
        titleLbl.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLbl.textColor = style == "dark" ? .lightGray : .darkGray
        titleLbl.textAlignment = .center
        titleLbl.text = title
        titleLbl.numberOfLines = 2
        titleBtn.addSubview(titleLbl)
        
        return titleBtn
    }
}
