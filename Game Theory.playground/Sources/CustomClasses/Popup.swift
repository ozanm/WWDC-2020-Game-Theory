import UIKit

public class Popup: UIView {
    
    public var completion: () -> ()
    
    public init() {
        self.completion = {}
        super.init(frame: .zero)
    }
    
    public init(in frame: CGRect, with icon: String, and text: String, completion: @escaping () -> ()) {
        self.completion = completion
        super.init(frame: frame)
        
        self.fade(type: .Out)
        
        let background = UIVisualEffectView(frame: self.bounds)
        background.effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        
        let content = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 200))
        
        let iconSection = IconEffectButton(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
        iconSection.center.x = content.frame.size.width / 2
        iconSection.apply(background: .systemChromeMaterialDark)
        iconSection.apply(icon: icon)
        iconSection.setCornerRadius(with: iconSection.frame.size.width / 2)
        
        let lblSection = UIView(frame: CGRect(x: 0, y: 75, width: 250, height: 100))
        lblSection.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        lblSection.setCornerRadius(with: 15)
        lblSection.addSubview(UILabel(frame: CGRect(x: 20, y: 0, width: 210, height: 100)))
        (lblSection.subviews[0] as! UILabel).text = text
        (lblSection.subviews[0] as! UILabel).textColor = .white
        (lblSection.subviews[0] as! UILabel).textAlignment = NSTextAlignment.center
        (lblSection.subviews[0] as! UILabel).font = UIFont.systemFont(ofSize: 15, weight: .bold)
        (lblSection.subviews[0] as! UILabel).numberOfLines = 3
        
        let dismissIcon = IconEffectButton(frame: CGRect(x: 0, y: (self.frame.size.height / 2) + 75, width: 250, height: 50))
        dismissIcon.center.x = self.frame.size.width / 2
        dismissIcon.apply(background: .light)
        dismissIcon.apply(icon: "Close")
        dismissIcon.setCornerRadius(with: 15)
        dismissIcon.animate(by: UIView.Transform(scaleX: 0, scaleY: 0))
        dismissIcon.target = { self.dismiss($0) }
        
        content.addSubview(iconSection)
        content.addSubview(lblSection)
        
        self.addSubview(background)
        self.addSubview(content)
        self.addSubview(dismissIcon)
        
        content.centerInView(with: .both)
        content.frame.origin.y += 50
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func display() {
        self.subviews[1].animate(to: CGPoint(x: self.subviews[1].frame.origin.x, y: self.subviews[1].frame.origin.y - 50))
        self.subviews[2].animate(by: UIView.Transform(scaleX: 1, scaleY: 1))
        self.fade(type: .In)
    }
    
    @objc private func dismiss(_ sender: UIButton!) {
        self.subviews[1].animate(to: CGPoint(x: self.subviews[1].frame.origin.x, y: self.subviews[1].frame.origin.y + 50))
        self.subviews[2].animate(by: UIView.Transform(scaleX: 0, scaleY: 0))
        self.fade(type: .Out)
        self.completion()
    }
}
