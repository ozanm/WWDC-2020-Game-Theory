import UIKit

public class AnswerView: UIView {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var answerType: Scenario.CallbackType!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 0
    }
    
    public func create(for type: Scenario.CallbackType) {
        self.answerType = type
        let confettiView = SAConfettiView(frame: self.bounds)
        confettiView.intensity = 1
        self.addSubview(confettiView)
        let explanation = UILabel(frame: CGRect(x: 20, y: 80, width: self.frame.size.width - 40, height: 80))
        explanation.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        explanation.textColor = .white
        explanation.textAlignment = .center
        explanation.numberOfLines = 2
        self.addSubview(explanation)
        let thumbsIcon = UIImageView()
        thumbsIcon.frame.size = CGSize(width: 250, height: 250)
        self.addSubview(thumbsIcon)
        thumbsIcon.centerInView(with: .both)
        switch type {
        case .success:
            thumbsIcon.image = UIImage.image(named: "ThumbsUpEmoji")
            explanation.text = "Correct! Let's find out why."
        case .fail:
            thumbsIcon.image = UIImage.image(named: "ThumbsDownEmoji")
            explanation.text = "Sorry wrong answer! Let's find out why."
        case .finalSuccess:
            thumbsIcon.image = UIImage.image(named: "ThumbsUpEmoji")
            explanation.text = "Correct!"
        case .finalFail:
            thumbsIcon.image = UIImage.image(named: "ThumbsDownEmoji")
            explanation.text = "Sorry wrong answer!"
        }
        
        self.fade(type: .Out)
    }
    
    public func present() {
        self.fade(type: .In)
        (self.subviews[0] as! SAConfettiView).startConfetti()
    }
    
    public func dismiss() {
        self.fade(type: .Out)
        self.removeFromSuperview()
    }
}

public class Scenario: UIView {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static var main : Scenario?
    
    private var scenarios : [[String]]?
    private var successView : AnswerView?
    private var failView : AnswerView?
    private var closure : (() -> ())?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.scenarios = []
        
        let background = UIVisualEffectView(frame: self.bounds)
        background.effect = UIBlurEffect(style: .systemChromeMaterialDark)
        self.addSubview(background)
        
        let title = UILabel(frame: CGRect(x: 40, y: 75, width: self.frame.size.width - 80, height: 100))
        title.font = UIFont.systemFont(ofSize: 45, weight: .semibold)
        title.text = "With this option..."
        title.textAlignment = .center
        title.textColor = .white
        title.numberOfLines = 2
        self.addSubview(title)
        
        let container = UIVisualEffectView(frame: CGRect(x: 60, y: (self.frame.size.height / 2) - 50, width: self.frame.size.width - 120, height: 100))
        container.effect = UIBlurEffect(style: .light)
        container.setCornerRadius(with: 10)
        self.addSubview(container)
        container.centerInView(with: .vertically)
        
        let positive = UILabel(frame: CGRect(x: 0, y: (container.frame.size.height / 2) - 40, width: container.frame.size.width, height: 50))
        positive.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        positive.textAlignment = .center
        positive.textColor = .white
        
        let negative = UILabel(frame: CGRect(x: 0, y: (container.frame.size.height / 2), width: container.frame.size.width, height: 50))
        negative.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        negative.textAlignment = .center
        negative.textColor = .white
        
        container.contentView.addSubview(positive)
        container.contentView.addSubview(negative)
        
        let accept = IconEffectButton(frame: CGRect(x: 80, y: (self.frame.size.height / 2) + 100, width: 100, height: 100))
        accept.apply(background: .light)
        accept.apply(icon: "Checkmark")
        accept.setCornerRadius(with: 10)
        
        let reject = IconEffectButton(frame: accept.frame)
        reject.frame.origin.x = self.frame.size.width - 180
        reject.apply(background: .light)
        reject.apply(icon: "Close")
        reject.setCornerRadius(with: 10)
        reject.target = { self.dismiss($0) }
        
        self.addSubview(IconEffectButton.applyTitle(title: "I choose this", on: accept))
        self.addSubview(IconEffectButton.applyTitle(title: "I don't choose this", on: reject))
        
        self.successView = AnswerView(frame: self.bounds)
        self.failView = AnswerView(frame: self.bounds)
        
        self.successView!.create(for: .success)
        self.failView!.create(for: .fail)
        
        self.addSubview(successView!)
        self.addSubview(failView!)
        
        self.dismiss(reject.base())
    }
    
    public func set(to scenario: Int) {
        ((self.subviews[2] as? UIVisualEffectView)!.contentView.subviews[0] as! UILabel).text = self.scenarios![scenario][0]
        ((self.subviews[2] as? UIVisualEffectView)!.contentView.subviews[1] as! UILabel).text = self.scenarios![scenario][1]
    }
    
    public enum CallbackType {
        case success, fail, finalSuccess, finalFail
    }
    
    public func callback(with target: @escaping () -> ()) {
        self.closure = target
    }
    
    public func addScenario(scenario: [String]) {
        self.scenarios!.append(scenario)
    }
    
    public func present(_ isCorrectAnswer: Bool) {
        self.fade(type: .In)
        
        (self.subviews[3].subviews[0] as! IconEffectButton).target = { _ in self.decided(got: isCorrectAnswer) }
        
        self.subviews[4].animate(by: .init(scaleX: 1, scaleY: 1), after: 0.25)
        self.subviews[5].animate(by: .init(scaleX: 1, scaleY: 1), after: 0.25)
    }
    
    @objc private func dismiss(_ sender: UIButton!) {
        self.fade(type: .Out)
        
        self.subviews[4].animate(by: .init(scaleX: 0, scaleY: 0), after: 0.25)
        self.subviews[5].animate(by: .init(scaleX: 0, scaleY: 0), after: 0.25)
    }
    
    @objc private func decided(got answer: Bool) {
        for i in 1..<5 {
            self.subviews[i].fade(type: .Out)
        }
        
        if answer {
            self.successView!.present()
        } else {
            self.failView!.present()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.closure!()
        }
    }
}
