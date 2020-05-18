import UIKit

public class Quiz: UIView {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public struct Information {
        public var question: String
        public var options: [OptionInformation]
        
        public init(question: String, options: [OptionInformation]) {
            self.question = question
            self.options = options
        }
    }
    
    public struct OptionInformation {
        public var title: String
        public var scenarios: [String]
        
        public init(title: String, scenarios: [String]) {
            self.title = title
            self.scenarios = scenarios
        }
    }
    
    private var information : Information?
    
    private var title : Question!
    private var options : OptionContainer!
    
    public init() {
        super.init(frame: .zero)
    }
    
    public init(information: Information) {
        self.information = information
        
        super.init(frame: .zero)
    }
    
    public func setFrame(frame: CGRect) {
        self.frame = frame
        
        self.title = Question(frame: CGRect(x: -30, y: 0, width: self.frame.size.width - 60, height: 75))
        self.title.createText(style: .light, with: self.information!.question)
        self.addSubview(self.title)
        
        self.options = OptionContainer(frame: CGRect(x: 0, y: 25, width: self.frame.size.width, height: self.frame.size.height - 45))
        self.options.setup(with: self.information!.options)
        self.addSubview(self.options)

        Scenario.main = Scenario(frame: self.bounds)
        self.information!.options.forEach {
            Scenario.main!.addScenario(scenario: $0.scenarios)
        }
        self.addSubview(Scenario.main!)
    }
    
    public func setCorrectAnswer(at index: Int) {
        self.options.setCorrectAnswer(at: index)
    }
    
    public func setCallback(closure: @escaping () -> ()) {
        Scenario.main!.callback(with: closure)
    }
    
    public func present() {
        self.title.fade(type: .In)
        self.title.animate(to: CGPoint(x: 30, y: 50))
        self.title.animate(change: CGSize(width: self.frame.size.width - 60, height: self.frame.size.height - 175), after: 0.25)
        
        self.options.present()
    }
}
