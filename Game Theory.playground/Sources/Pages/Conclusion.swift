import UIKit

public class Conclusion: Page {
    
    public static var page: UIView?
    public static var close: IconEffectButton?
    
    private static let background: UIImageView = UIImageView()
    private static let divider: UIView = UIView()
    private static let container: UIVisualEffectView = UIVisualEffectView()
    private static let title: UILabel = UILabel()
    private static let summary: UIImageView = UIImageView()
    private static let takeAway: UILabel = UILabel()
    private static let thankYou: UILabel = UILabel()
    
    public class func setup(in screen: UIView) {
        Conclusion.page = UIView(frame: screen.bounds)
        Conclusion.close = IconEffectButton(frame: .zero)
        
        Conclusion.background.frame = Conclusion.page!.bounds
        Conclusion.background.image = UIImage.image(neon: "WWDCBackground")
        Conclusion.background.contentMode = .scaleAspectFit
        Conclusion.background.correctBackground(at: .zero)
        Conclusion.background.fade(type: .Out)
        Conclusion.page!.addSubview(Conclusion.background)
        
        Conclusion.divider.frame = CGRect(x: 0, y: 425, width: 550, height: 300)
        Conclusion.divider.backgroundColor = Conclusion.background.image?.getPixelColor(pos: CGPoint(x: 0, y: 458))
        Conclusion.divider.fade(type: .Out)
        Conclusion.page!.addSubview(Conclusion.divider)
        
        Conclusion.container.frame = CGRect(x: 20, y: 20, width: 510, height: 510)
        Conclusion.container.effect = UIBlurEffect(style: .dark)
        Conclusion.container.setCornerRadius(with: 10)
        Conclusion.container.animate(by: .init(scaleX: 0, scaleY: 0))
        Conclusion.page!.addSubview(Conclusion.container)
        
        Conclusion.title.frame = CGRect(x: 20, y: 50, width: 470, height: 30)
        Conclusion.title.font = UIFont.systemFont(ofSize: 28, weight: .black)
        Conclusion.title.text = "Thank You For Playing!"
        Conclusion.title.textAlignment = .center
        Conclusion.title.textColor = .white
        Conclusion.title.fade(type: .Out)
        Conclusion.container.contentView.addSubview(Conclusion.title)
        
        Conclusion.summary.frame = CGRect(x: 20, y: 120, width: 200, height: 200)
        Conclusion.summary.image = UIImage.image(named: "GameTheorySummary")
        Conclusion.summary.contentMode = .scaleAspectFit
        Conclusion.summary.fade(type: .Out)
        Conclusion.summary.frame.origin.y += 50
        Conclusion.container.contentView.addSubview(Conclusion.summary)
        
        Conclusion.takeAway.frame = CGRect(x: 230, y: 120, width: 280, height: 150)
        Conclusion.takeAway.font = UIFont.systemFont(ofSize: 15, weight: .black)
        Conclusion.takeAway.text = "I hope you enjoyed this little interactive introduction to Game Theory. There was a lot of sweat, love, and creativity put into this project. Beware, this is just the tip of the iceberg for Game Theory and there is much more to learn if your interested."
        Conclusion.takeAway.textColor = .white
        Conclusion.takeAway.fade(type: .Out)
        Conclusion.takeAway.frame.origin.y -= 50
        Conclusion.takeAway.numberOfLines = 25
        Conclusion.container.contentView.addSubview(Conclusion.takeAway)
        
        Conclusion.thankYou.frame = CGRect(x: 20, y: 350, width: 470, height: 150)
        Conclusion.thankYou.font = UIFont.systemFont(ofSize: 25, weight: .black)
        Conclusion.thankYou.text = "I really hope that you found this WWDC project entertaining and creative. I can't wait to be there!"
        Conclusion.thankYou.textColor = .white
        Conclusion.thankYou.textAlignment = .center
        Conclusion.thankYou.fade(type: .Out)
        Conclusion.thankYou.numberOfLines = 3
        Conclusion.container.contentView.addSubview(Conclusion.thankYou)
        
        screen.addSubview(Conclusion.page!)
    }
    
    public class func present() {
        Conclusion.background.fade(type: .In)
        Conclusion.divider.fade(type: .In)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            Conclusion.container.animate(by: .init(scaleX: 1, scaleY: 1)) { _ in
                Conclusion.title.fade(type: .In)
                
                Conclusion.summary.fade(type: .In)
                Conclusion.summary.animate(to: CGPoint(x: 20, y: 120))
                
                Conclusion.takeAway.fade(type: .In)
                Conclusion.takeAway.animate(to: CGPoint(x: 230, y: 130))
                
                Conclusion.thankYou.fade(type: .In)
            }
        }
    }
    
    public class func dismiss(_ sender: UIButton!) {
        
    }
}
