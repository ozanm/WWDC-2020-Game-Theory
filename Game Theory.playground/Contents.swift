import UIKit
import PlaygroundSupport

func main() -> UIView {
    let mainScreen = UIView(frame: CGRect(x: 0, y: 0, width: 550, height: 550))
    
    // Setup widgets and pages inside screen.
    TitleScreen.setup(in: mainScreen)
    PrisonStory.setup(in: mainScreen)
    QuizPage.setup(in: mainScreen)
    ExplanationStory.setup(in: mainScreen)
    ExamplesSlides.setup(in: mainScreen)
    Conclusion.setup(in: mainScreen)
    
    // Returns created screen for the playground and realigns the views to be ordered correctly
    return mainScreen.reframe()
}

PlaygroundPage.current.setLiveView(main())
