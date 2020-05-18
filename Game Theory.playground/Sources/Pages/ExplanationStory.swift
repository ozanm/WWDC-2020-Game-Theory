import UIKit

public class ExplanationStory: Page {
    
    public static var page : UIView?
    public static var close : IconEffectButton?
    
    private static var story : VideoPlayer = VideoPlayer()
    private static var header : UILabel = UILabel()
    private static var soundNotifier : Popup = Popup()
    private static var replay : IconEffectButton = IconEffectButton()
    public static var confirmationView : UIVisualEffectView = UIVisualEffectView()
    
    public class func setup(in screen: UIView) {
        ExplanationStory.page = UIView(frame: screen.bounds)
        
        ExplanationStory.story.frame = ExplanationStory.page!.bounds
        ExplanationStory.story.setupVideo(with: VideoData(name: "PrisonerDilemaExplanation"))
        ExplanationStory.story.fade(type: .Out)
        ExplanationStory.story.completion = { ExplanationStory.confirmation() }
        ExplanationStory.page!.addSubview(ExplanationStory.story)
        
        ExplanationStory.confirmationView.effect = UIBlurEffect(style: .dark)
        ExplanationStory.confirmationView.frame = ExplanationStory.page!.bounds
        ExplanationStory.confirmationView.fade(type: .Out)

        ExplanationStory.close = IconEffectButton(frame: CGRect(x: 0, y: (ExplanationStory.page!.frame.size.height / 2) - 50, width: 100, height: 100))
        ExplanationStory.close!.center.x = ExplanationStory.page!.frame.size.width * (2 / 3)
        ExplanationStory.close!.target = { ExplanationStory.dismiss($0) }
        ExplanationStory.close!.apply(background: .light)
        ExplanationStory.close!.apply(icon: "Checkmark")
        ExplanationStory.close!.setCornerRadius(with: 15)

        ExplanationStory.replay = IconEffectButton(frame: CGRect(x: 0, y: (ExplanationStory.page!.frame.size.height / 2) - 50, width: 100, height: 100))
        ExplanationStory.replay.center.x = ExplanationStory.page!.frame.size.width * (1 / 3)
        ExplanationStory.replay.target = { ExplanationStory.resetPage($0) }
        ExplanationStory.replay.apply(background: .light)
        ExplanationStory.replay.apply(icon: "Replay")
        ExplanationStory.replay.setCornerRadius(with: 15)

        ExplanationStory.confirmationView.contentView.addSubview(IconEffectButton.applyTitle(title: "Yep, got it!", on: ExplanationStory.close!))
        ExplanationStory.confirmationView.contentView.addSubview(IconEffectButton.applyTitle(title: "Nope, watch it again!", on: ExplanationStory.replay))

        ExplanationStory.page!.addSubview(ExplanationStory.confirmationView)
        
        ExplanationStory.header.frame = CGRect(x: 100, y: 40, width: screen.frame.size.width - 30, height: 80)
        ExplanationStory.header.font = UIFont.boldSystemFont(ofSize: 45)
        ExplanationStory.header.text = "Here's the logic:"
        ExplanationStory.header.fade(type: .Out)
        ExplanationStory.page!.addSubview(ExplanationStory.header)
        
        ExplanationStory.soundNotifier = Popup(in: ExplanationStory.page!.bounds, with: "Volume", and: "Make sure to raise the volume to listen to the video!") {
            ExplanationStory.header.fade(type: .In)
            ExplanationStory.header.animate(to: CGPoint(x: 30, y: 50))
            
            ExplanationStory.story.start(debugging: true)
            
            ExplanationStory.soundNotifier.removeFromSuperview()
        }
        ExplanationStory.page!.addSubview(ExplanationStory.soundNotifier)
        
        screen.addSubview(ExplanationStory.page!)
    }
    
    private class func confirmation() {
        ExplanationStory.confirmationView.fade(type: .In)
        
        ExplanationStory.header.animate(paint: .white)
        ExplanationStory.header.animate(change: CGSize(width: ExplanationStory.page!.frame.size.width, height: 65))
        ExplanationStory.header.animate(to: CGPoint(x: 0, y: 50))
        ExplanationStory.header.animate(for: .center)
        ExplanationStory.header.animate(text: "Did you get that?")
    }
    
    public class func present() {
        ExplanationStory.story.activated = true
        ExplanationStory.story.fade(type: .In)
        ExplanationStory.soundNotifier.display()
    }
    
    public class func dismiss(_ sender: UIButton!) {
        ExplanationStory.story.activated = false
        ExplanationStory.dismissConfirmation()
        
        ExplanationStory.header.fade(type: .Out)
        ExplanationStory.header.animate(to: CGPoint(x: -30, y: 50))
        
        UIView.fade(type: .Out, these: [ExplanationStory.story, ExplanationStory.page!]) { _ in
            ExplanationStory.page!.removeFromSuperview()
            ExamplesSlides.present()
        }
    }
    
    private class func resetPage(_ sender: UIButton!) {
        ExplanationStory.dismissConfirmation()
        ExplanationStory.story.start(debugging: false)
    }
    
    private class func dismissConfirmation() {
        ExplanationStory.confirmationView.fade(type: .Out)
               
       ExplanationStory.header.animate(paint: .black)
       ExplanationStory.header.animate(change: CGSize(width: ExplanationStory.page!.frame.size.width - 30, height: 45))
       ExplanationStory.header.animate(to: CGPoint(x: 30, y: 50))
       ExplanationStory.header.animate(for: .natural)
       ExplanationStory.header.animate(text: "Here's the logic:")
    }
}
