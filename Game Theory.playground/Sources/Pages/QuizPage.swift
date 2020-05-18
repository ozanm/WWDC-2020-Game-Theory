import UIKit

public class QuizPage: Page {
    
    public static var page: UIView?
    public static var close: IconEffectButton?
    
    private static var quiz : Quiz = Quiz()
    
    public class func setup(in screen: UIView) {
        QuizPage.page = UIView(frame: screen.bounds)
        QuizPage.close = IconEffectButton(frame: .zero)
        
        QuizPage.quiz = Quiz(information:
            .init(question: "What will you do?", options: [
                .init(title: "Confess to the police", scenarios: [
                    "You will either not go to prison,",
                    "Or go for 2 years."
                ]),
                .init(title: "Hold out from the police", scenarios: [
                    "You will either go to prison for 1 year,",
                    "Or go for 4 years."
                ])
            ])
        )
        QuizPage.quiz.setFrame(frame: QuizPage.page!.bounds)
        QuizPage.quiz.setCorrectAnswer(at: 0)
        QuizPage.quiz.setCallback {
            QuizPage.dismiss(QuizPage.close!.base())
        }
        QuizPage.page!.addSubview(QuizPage.quiz)
        
        screen.addSubview(QuizPage.page!)
    }
    
    public class func present() {
        QuizPage.quiz.present()
    }
    
    public class func dismiss(_ sender: UIButton!) {
        QuizPage.page!.fade(type: .Out) { _ in
            QuizPage.page!.removeFromSuperview()
            ExplanationStory.present()
        }
    }
}
