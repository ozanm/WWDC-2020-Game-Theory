import UIKit

public class Option: UIView {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var information: Quiz.OptionInformation?
    private var indexHandler : Int?
    private var isCorrectAnswer: Bool?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func setup(with information: Quiz.OptionInformation, at index: Int) {
        self.information = information
        self.indexHandler = index
        self.isCorrectAnswer = false
        
        let marker = Marker(mark: index.alphabetize()!)
        marker.center.x = 25
        self.addSubview(marker)
        marker.centerInView(with: .vertically)
        
        let title = UILabel(frame: CGRect(x: 80, y: 0, width: self.frame.size.width - 80, height: self.frame.size.height))
        title.text = self.information?.title
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        title.numberOfLines = 1
        self.addSubview(title)
        
        let activator = UIButton(frame: self.bounds)
        activator.addTarget(self, action: #selector(self.presentScenarios(_:)), for: .touchUpInside)
        self.addSubview(activator)
    }
    
    public func setCorrectAnswer() {
        self.isCorrectAnswer = true
    }
    
    public func present(timed after: Double) {
        self.animate(to: CGPoint(x: (superview!.frame.size.width / 2) - (self.frame.size.width / 2), y: self.frame.origin.y), after: after)
    }
    
    @objc private func presentScenarios(_ sender: UIButton!) {
        self.animate(by: .init(scaleX: 1.1, scaleY: 1.1), with: 0.25) { _ in
            self.animate(by: .init(scaleX: 1, scaleY: 1), with: 0.25)
        }
        
        Scenario.main!.set(to: self.indexHandler!)
        Scenario.main!.present(self.isCorrectAnswer!)
    }
}

public class OptionContainer: UIView {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var information: [Quiz.OptionInformation]?
    private var options: [Option]?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func setup(with information: [Quiz.OptionInformation]) {
        self.information = information
        self.options = []
        
        for i in 0..<self.information!.count {
            let option = Option(frame: CGRect(x: 550, y: 130 + (100 * i), width: Int(self.frame.size.width - 150), height: 75))
            option.setup(with: self.information![i], at: i)
            self.addSubview(option)
            self.options!.append(option)
        }
        
        self.fade(type: .Out)
    }
    
    public func setCorrectAnswer(at index: Int) {
        self.options![index].setCorrectAnswer()
    }
    
    public func present() {
        self.fade(type: .In)
        
        for i in 0..<self.options!.count {
            self.options![i].present(timed: Double(i) - 0.75)
        }
    }
}
