import UIKit

public class ExamplesSlides: Page {
    
    public static var page: UIView?
    public static var close: IconEffectButton?
    
    private static let mainImage: UIImageView = UIImageView()
    private static let description : UILabel = UILabel()
    private static let cardsIcon : UIImageView = UIImageView()
    private static let chipsIcon : UIImageView = UIImageView()
    private static let theorm : UILabel = UILabel()
    private static let opponentCards : UILabel = UILabel()
    private static let userCards : UILabel = UILabel()
    private static let pokerQuiz : UIVisualEffectView = UIVisualEffectView()
    private static let dismissNotifier : UILabel = UILabel()
    private static let recognizer : UIButton = UIButton()
    
    private static var buffer : Int = 0
    private static let story : [String] = [
        "That was interesting, right?",
        "Game Theory is also applicable in everyday things,",
        "It's all about using math and logic,",
        "Another way of thinking about it is being rational,",
        "Let's try another way to test our Game Theory skills,",
        "This example is... Poker!",
        "The fundamental theorm of Poker says,",
        "So if your opponent's hand is,",
        "And your hand is,",
        "Keep in mind that,",
        "you are last to act,",
        "and your opponent had just...",
        "bet $20 into a $20 pot on the flop,",
        "and you can also...",
        "SEE YOUR OPONENT'S CARDS,",
        "Then select your best bet,",
    ]
    
    public class func setup(in screen: UIView) {
        ExamplesSlides.page = UIView(frame: screen.bounds)
        ExamplesSlides.close = IconEffectButton(frame: .zero)
        
        ExamplesSlides.mainImage.frame = ExamplesSlides.page!.bounds
        ExamplesSlides.mainImage.image = UIImage.image(neon: "DiceOutline")
        ExamplesSlides.mainImage.contentMode = .scaleAspectFit
        ExamplesSlides.mainImage.fade(type: .Out)
        ExamplesSlides.mainImage.frame.origin.y += 50
        ExamplesSlides.page!.addSubview(ExamplesSlides.mainImage)
        
        ExamplesSlides.chipsIcon.frame = CGRect(x: 275, y: 450, width: 350, height: 350)
        ExamplesSlides.chipsIcon.image = UIImage.image(neon: "PokerChips")
        ExamplesSlides.chipsIcon.fade(type: .Out)
        ExamplesSlides.page!.addSubview(ExamplesSlides.chipsIcon)
        
        ExamplesSlides.cardsIcon.frame = CGRect(x: -300, y: -150, width: 400, height: 400)
        ExamplesSlides.cardsIcon.image = UIImage.image(neon: "PokerCards")
        ExamplesSlides.cardsIcon.fade(type: .Out)
        ExamplesSlides.page!.addSubview(ExamplesSlides.cardsIcon)
        
        ExamplesSlides.theorm.frame = CGRect(x: 60, y: 0, width: 430, height: 370)
        ExamplesSlides.theorm.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        ExamplesSlides.theorm.numberOfLines = 4
        ExamplesSlides.theorm.text = "Every time you play your hand the way you would if you could see your opponents' cards, you gain, and every time your opponents play their cards differently from the way they would play them if they could see your cards, you gain."
        ExamplesSlides.theorm.textColor = .init(red: (66 / 255), green: (244 / 255), blue: (178 / 255), alpha: 1)
        ExamplesSlides.theorm.textAlignment = .center
        ExamplesSlides.theorm.fade(type: .Out)
        ExamplesSlides.page!.addSubview(ExamplesSlides.theorm)
        ExamplesSlides.theorm.centerInView(with: .both)
        
        ExamplesSlides.opponentCards.frame = CGRect(x: 0, y: 0, width: 500, height: 75)
        ExamplesSlides.opponentCards.font = UIFont.systemFont(ofSize: 60, weight: .medium)
        ExamplesSlides.opponentCards.text = "9♠️ 8❤️"
        ExamplesSlides.opponentCards.textAlignment = .center
        ExamplesSlides.opponentCards.textColor = .white
        ExamplesSlides.opponentCards.fade(type: .Out)
        ExamplesSlides.page!.addSubview(ExamplesSlides.opponentCards)
        ExamplesSlides.opponentCards.centerInView(with: .both)
        ExamplesSlides.opponentCards.frame.origin.y += 37.5
        
        ExamplesSlides.userCards.frame = CGRect(x: 0, y: 0, width: 500, height: 75)
        ExamplesSlides.userCards.font = UIFont.systemFont(ofSize: 60, weight: .medium)
        ExamplesSlides.userCards.text = "J♣️ J♦️"
        ExamplesSlides.userCards.textAlignment = .center
        ExamplesSlides.userCards.textColor = .white
        ExamplesSlides.userCards.fade(type: .Out)
        ExamplesSlides.page!.addSubview(ExamplesSlides.userCards)
        ExamplesSlides.userCards.centerInView(with: .both)
        ExamplesSlides.userCards.frame.origin.y -= 37.5
        
        ExamplesSlides.pokerQuiz.frame = ExamplesSlides.theorm.frame
        ExamplesSlides.pokerQuiz.frame.size.height -= 50
        ExamplesSlides.pokerQuiz.effect = UIBlurEffect(style: .systemChromeMaterial)
        ExamplesSlides.pokerQuiz.fade(type: .Out)
        ExamplesSlides.pokerQuiz.setCornerRadius(with: 10)
        ExamplesSlides.page!.addSubview(ExamplesSlides.pokerQuiz)
        ExamplesSlides.pokerQuiz.centerInView(with: .both)
        
        let fold = IconEffectButton(frame: CGRect(x: 0, y: 0, width: 92, height: 92))
        fold.center = CGPoint(x: 92, y: 160)
        fold.apply(icon: "Fold")
        fold.apply(background: .dark)
        fold.setCornerRadius(with: 10)
        fold.target = { _ in
            let container = UIVisualEffectView(effect: UIBlurEffect(style: .light))
            container.frame = ExamplesSlides.page!.bounds
            container.fade(type: .Out)
            ExamplesSlides.page!.addSubview(container)
            let failView = AnswerView(frame: ExamplesSlides.page!.bounds)
            failView.create(for: .finalFail)
            container.contentView.addSubview(failView)
            
            container.fade(type: .In)
            failView.present()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                ExamplesSlides.dismiss(ExamplesSlides.close!.base())
            }
        }
        
        let call = IconEffectButton(frame: CGRect(x: 0, y: 0, width: 92, height: 92))
        call.center = CGPoint(x: 205, y: 160)
        call.apply(icon: "Call")
        call.apply(background: .dark)
        call.setCornerRadius(with: 10)
        call.target = { _ in
            let container = UIVisualEffectView(effect: UIBlurEffect(style: .light))
            container.frame = ExamplesSlides.page!.bounds
            container.fade(type: .Out)
            ExamplesSlides.page!.addSubview(container)
            let successView = AnswerView(frame: ExamplesSlides.page!.bounds)
            successView.create(for: .finalSuccess)
            container.contentView.addSubview(successView)
            
            container.fade(type: .In)
            successView.present()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                ExamplesSlides.dismiss(ExamplesSlides.close!.base())
            }
        }
        
        let raise = IconEffectButton(frame: CGRect(x: 0, y: 0, width: 92, height: 92))
        raise.center = CGPoint(x: 317, y: 160)
        raise.apply(icon: "Raise")
        raise.apply(background: .dark)
        raise.setCornerRadius(with: 10)
        raise.target = { _ in
            let container = UIVisualEffectView(effect: UIBlurEffect(style: .light))
            container.frame = ExamplesSlides.page!.bounds
            container.fade(type: .Out)
            ExamplesSlides.page!.addSubview(container)
            let failView = AnswerView(frame: ExamplesSlides.page!.bounds)
            failView.create(for: .finalFail)
            container.contentView.addSubview(failView)
            
            container.fade(type: .In)
            failView.present()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                ExamplesSlides.dismiss(ExamplesSlides.close!.base())
            }
        }
        
        ExamplesSlides.pokerQuiz.contentView.addSubview(IconEffectButton.applyTitle(title: "Fold", on: fold, with: "light"))
        ExamplesSlides.pokerQuiz.contentView.addSubview(IconEffectButton.applyTitle(title: "Call", on: call, with: "light"))
        ExamplesSlides.pokerQuiz.contentView.addSubview(IconEffectButton.applyTitle(title: "Raise", on: raise, with: "light"))
        
        ExamplesSlides.description.frame = CGRect(x: 110, y: 30, width: ExamplesSlides.page!.frame.size.width - 60, height: 30)
        ExamplesSlides.description.font = UIFont.systemFont(ofSize: 25, weight: .black)
        ExamplesSlides.description.textColor = .white
        ExamplesSlides.description.text = ExamplesSlides.story[ExamplesSlides.buffer]
        ExamplesSlides.description.fade(type: .Out)
        ExamplesSlides.page!.addSubview(ExamplesSlides.description)
        
        ExamplesSlides.dismissNotifier.frame = CGRect(x: 0, y: screen.frame.size.height - 25, width: screen.frame.size.width, height: 20)
        ExamplesSlides.dismissNotifier.text = "👆 Click Anywhere to Continue!"
        ExamplesSlides.dismissNotifier.textAlignment = NSTextAlignment.center
        ExamplesSlides.dismissNotifier.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        ExamplesSlides.dismissNotifier.textColor = UIColor(red: (66 / 255), green: (244 / 255), blue: (178 / 255), alpha: 1)
        ExamplesSlides.dismissNotifier.fade(type: .Out)
        ExamplesSlides.page!.addSubview(ExamplesSlides.dismissNotifier)
        
        ExamplesSlides.recognizer.frame = ExamplesSlides.page!.bounds
        ExamplesSlides.recognizer.addTarget(self, action: #selector(ExamplesSlides.update(_:)), for: .touchUpInside)
        ExamplesSlides.page!.addSubview(recognizer)
        
        screen.addSubview(ExamplesSlides.page!)
    }
    
    @objc private class func update(_ sender: UIButton!) {
        if ExamplesSlides.buffer < ExamplesSlides.story.count - 1 {
            ExamplesSlides.buffer += 1

            ExamplesSlides.description.fade(type: .Out)
            ExamplesSlides.description.animate(to: CGPoint(x: 0, y: (ExamplesSlides.buffer % 2) == 0 ? 450 : 70)) { _ in
                ExamplesSlides.description.font = UIFont.systemFont(ofSize: 17.5, weight: .black)
                ExamplesSlides.description.text = ExamplesSlides.story[ExamplesSlides.buffer]
                ExamplesSlides.description.frame.origin.y = (ExamplesSlides.buffer % 2) == 0 ? 70 : 450
                ExamplesSlides.description.fade(type: ExamplesSlides.buffer == 16 ? .Out : .In)
                ExamplesSlides.description.animate(to: CGPoint(x: 60, y: (ExamplesSlides.buffer % 2) == 0 ? 70 : 450))
            }
            
            if ExamplesSlides.buffer == 5 {
                ExamplesSlides.mainImage.fade(type: .Out)
                ExamplesSlides.mainImage.animate(to: CGPoint(x: 50, y: 50))
                
                ExamplesSlides.description.fade(type: .Out)
                ExamplesSlides.description.animate(to: CGPoint(x: 60, y: 70))
                
                ExamplesSlides.chipsIcon.fade(type: .In)
                ExamplesSlides.chipsIcon.animate(to: CGPoint(x: 275, y: 285))
                
                ExamplesSlides.cardsIcon.fade(type: .In)
                ExamplesSlides.cardsIcon.animate(to: CGPoint(x: 260, y: -100))
            } else if ExamplesSlides.buffer == 6 {
                ExamplesSlides.theorm.fade(type: .In)
            } else if ExamplesSlides.buffer == 7 {
                ExamplesSlides.theorm.fade(type: .Out)
                ExamplesSlides.opponentCards.fade(type: .In)
            } else if ExamplesSlides.buffer == 8 {
                ExamplesSlides.userCards.fade(type: .In)
            } else if ExamplesSlides.buffer == 15 {
                ExamplesSlides.pokerQuiz.fade(type: .In)
                ExamplesSlides.recognizer.removeFromSuperview()
            }
        } else {
            //
        }
    }
    
    public class func present() {
        ExamplesSlides.dismissNotifier.fade(type: .In)
        ExamplesSlides.dismissNotifier.alert()
        
        ExamplesSlides.mainImage.fade(type: .In)
        ExamplesSlides.mainImage.animate(to: .zero)
        
        ExamplesSlides.description.fade(type: .In)
        ExamplesSlides.description.animate(to: CGPoint(x: 60, y: 70))
    }
    
    public class func dismiss(_ sender: UIButton!) {
        ExamplesSlides.page!.fade(type: .Out) { _ in 
            ExamplesSlides.page!.removeFromSuperview()
            Conclusion.present()
        }
    }
}
