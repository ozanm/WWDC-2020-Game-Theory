import UIKit

public class TitleScreen: Page {
    
    public static var page : UIView?
    public static var close : IconEffectButton?
    
    private static let title : UILabel = UILabel()
    private static let format : UILabel = UILabel()
    private static let subtitle : UILabel = UILabel()
    private static let dismissNotifier : UILabel = UILabel()
    private static let explanation : UILabel = UILabel()
    
    public class func setup(in screen: UIView) {
        TitleScreen.page = UIView(frame: screen.bounds)
        
        TitleScreen.close = IconEffectButton(frame: TitleScreen.page!.bounds)
        TitleScreen.close!.target = { TitleScreen.dismiss($0) }
        TitleScreen.page!.addSubview(TitleScreen.close!)
        
        TitleScreen.title.frame = CGRect(x: -screen.frame.size.width, y: 0, width: screen.frame.size.width, height: 80)
        TitleScreen.title.text = "Game The·o·ry"
        TitleScreen.title.font = UIFont.boldSystemFont(ofSize: 75)
        TitleScreen.title.textColor = UIColor.white.withAlphaComponent(0.3)
        TitleScreen.title.alpha = 0
        TitleScreen.page!.addSubview(TitleScreen.title)
        
        TitleScreen.format.frame = CGRect(x: -screen.frame.size.width, y: 0, width: screen.frame.size.width, height: 35)
        TitleScreen.format.text = "| ˈɡeɪm ˌθɪəri |"
        TitleScreen.format.font = UIFont.boldSystemFont(ofSize: 25)
        TitleScreen.format.textColor = UIColor.white.withAlphaComponent(0.6)
        TitleScreen.format.alpha = 0
        TitleScreen.page!.addSubview(TitleScreen.format)
        
        TitleScreen.subtitle.frame = CGRect(x: -screen.frame.size.width, y: 0, width: screen.frame.size.width + 250, height: 250)
        TitleScreen.subtitle.text = "& Strategic Desicion Making"
        TitleScreen.subtitle.font = UIFont.boldSystemFont(ofSize: 80)
        TitleScreen.subtitle.textColor = UIColor.white.withAlphaComponent(0.15)
        TitleScreen.subtitle.numberOfLines = 2
        TitleScreen.subtitle.alpha = 0
        TitleScreen.page!.addSubview(TitleScreen.subtitle)
        
        TitleScreen.dismissNotifier.frame = CGRect(x: 0, y: screen.frame.size.height - 25, width: screen.frame.size.width, height: 20)
        TitleScreen.dismissNotifier.text = "👆 Click Anywhere to Begin!"
        TitleScreen.dismissNotifier.textAlignment = NSTextAlignment.center
        TitleScreen.dismissNotifier.font = UIFont.boldSystemFont(ofSize: 15)
        TitleScreen.dismissNotifier.textColor = UIColor(red: (66 / 255), green: (244 / 255), blue: (178 / 255), alpha: 1)
        TitleScreen.dismissNotifier.alert()
        TitleScreen.page!.addSubview(TitleScreen.dismissNotifier)
        
        TitleScreen.explanation.frame = CGRect(x: screen.frame.size.width, y: screen.frame.size.height, width: screen.frame.size.width - 80, height: 200)
        TitleScreen.explanation.text = "noun\n\nthe branch of mathematics concerned with the analysis of strategies for dealing with competitive situations where the outcome of a participant's choice of action depends critically on the actions of other participants. Game theory has been applied to contexts in war, business, and biology."
        TitleScreen.explanation.numberOfLines = 10
        TitleScreen.explanation.font = UIFont.systemFont(ofSize: 15)
        TitleScreen.explanation.textColor = UIColor.white
        TitleScreen.explanation.alpha = 0
        TitleScreen.page!.addSubview(TitleScreen.explanation)
        
        TitleScreen.present()
        
        screen.addSubview(TitleScreen.page!)
    }
    
    public class func present() {
        TitleScreen.title.animate(to: CGPoint(x: 20, y: 120))
        TitleScreen.format.animate(to: CGPoint(x: 100, y: 210))
        TitleScreen.subtitle.animate(to: CGPoint(x: -10, y: 280))
        TitleScreen.explanation.animate(to: CGPoint(x: 60, y: 180))
        
        UIView.fade(type: .In, these: [TitleScreen.title, TitleScreen.format, TitleScreen.subtitle, TitleScreen.explanation])
    }
    
    public class func dismiss(_ sender: UIButton!) {
        TitleScreen.title.animate(to: CGPoint(x: -sender.superview!.frame.size.width, y: 0))
        TitleScreen.explanation.animate(to: CGPoint(x: sender.superview().frame.size.width, y: sender.superview().frame.size.height))
        
        UIView.fade(type: .Out, these: [TitleScreen.title, TitleScreen.explanation, TitleScreen.page!]) { _ in
            TitleScreen.page!.removeFromSuperview()
            PrisonStory.present()
        }
    }
}
