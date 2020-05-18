import UIKit

public class PrisonStory: Page {
    
    public static var page : UIView?
    public static var close : IconEffectButton?
    
    private static var story : VideoPlayer = VideoPlayer()
    private static var header : UILabel = UILabel()
    private static var soundNotifier : Popup = Popup()
    private static var replay : IconEffectButton = IconEffectButton()
    private static var confirmationView : UIVisualEffectView = UIVisualEffectView()
    
    public class func setup(in screen: UIView) {
        PrisonStory.page = UIView(frame: screen.bounds)
        
        PrisonStory.story.frame = PrisonStory.page!.bounds
        PrisonStory.story.setupVideo(with: VideoData(name: "PrisonerDilemaScenario"))
        PrisonStory.story.fade(type: .Out)
        PrisonStory.story.completion = { PrisonStory.confirmation() }
        PrisonStory.page!.addSubview(PrisonStory.story)
        
        PrisonStory.confirmationView.effect = UIBlurEffect(style: .dark)
        PrisonStory.confirmationView.frame = PrisonStory.page!.bounds
        PrisonStory.confirmationView.fade(type: .Out)

        PrisonStory.close = IconEffectButton(frame: CGRect(x: 0, y: (PrisonStory.page!.frame.size.height / 2) - 50, width: 100, height: 100))
        PrisonStory.close!.center.x = PrisonStory.page!.frame.size.width * (2 / 3)
        PrisonStory.close!.target = { PrisonStory.dismiss($0) }
        PrisonStory.close!.apply(background: .light)
        PrisonStory.close!.apply(icon: "Checkmark")
        PrisonStory.close!.setCornerRadius(with: 15)

        PrisonStory.replay = IconEffectButton(frame: CGRect(x: 0, y: (PrisonStory.page!.frame.size.height / 2) - 50, width: 100, height: 100))
        PrisonStory.replay.center.x = PrisonStory.page!.frame.size.width * (1 / 3)
        PrisonStory.replay.target = { PrisonStory.resetPage($0) }
        PrisonStory.replay.apply(background: .light)
        PrisonStory.replay.apply(icon: "Replay")
        PrisonStory.replay.setCornerRadius(with: 15)

        PrisonStory.confirmationView.contentView.addSubview(IconEffectButton.applyTitle(title: "Yep, got it!", on: PrisonStory.close!))
        PrisonStory.confirmationView.contentView.addSubview(IconEffectButton.applyTitle(title: "Nope, watch it again!", on: PrisonStory.replay))

        PrisonStory.page!.addSubview(PrisonStory.confirmationView)
        
        PrisonStory.header.frame = CGRect(x: 100, y: 40, width: screen.frame.size.width - 30, height: 80)
        PrisonStory.header.font = UIFont.boldSystemFont(ofSize: 45)
        PrisonStory.header.text = "Let's suppose..."
        PrisonStory.header.fade(type: .Out)
        PrisonStory.page!.addSubview(PrisonStory.header)
        
        PrisonStory.soundNotifier = Popup(in: PrisonStory.page!.bounds, with: "Volume", and: "Make sure to raise the volume to listen to the video!") {
            PrisonStory.header.fade(type: .In)
            PrisonStory.header.animate(to: CGPoint(x: 30, y: 50))
            
            PrisonStory.story.start(debugging: true)
            
            PrisonStory.soundNotifier.removeFromSuperview()
        }
        PrisonStory.page!.addSubview(PrisonStory.soundNotifier)
        
        screen.addSubview(PrisonStory.page!)
    }
    
    private class func confirmation() {
        PrisonStory.confirmationView.fade(type: .In)
        
        PrisonStory.header.animate(paint: .white)
        PrisonStory.header.animate(change: CGSize(width: PrisonStory.page!.frame.size.width, height: 65))
        PrisonStory.header.animate(to: CGPoint(x: 0, y: 50))
        PrisonStory.header.animate(for: .center)
        PrisonStory.header.animate(text: "Did you get that?")
    }
    
    public class func present() {
        PrisonStory.story.activated = true
        PrisonStory.story.fade(type: .In)
        PrisonStory.soundNotifier.display()
    }
    
    public class func dismiss(_ sender: UIButton!) {
        PrisonStory.story.activated = false
        PrisonStory.dismissConfirmation()
        
        PrisonStory.header.fade(type: .Out)
        PrisonStory.header.animate(to: CGPoint(x: -30, y: 50))
        
        UIView.fade(type: .Out, these: [PrisonStory.story, PrisonStory.page!]) { _ in
            PrisonStory.page!.removeFromSuperview()
            QuizPage.present()
        }
    }
    
    private class func resetPage(_ sender: UIButton!) {
        PrisonStory.dismissConfirmation()
        PrisonStory.story.start(debugging: false)
    }
    
    private class func dismissConfirmation() {
        PrisonStory.confirmationView.fade(type: .Out)
        PrisonStory.header.animate(paint: .black)
        PrisonStory.header.animate(change: CGSize(width: PrisonStory.page!.frame.size.width - 30, height: 45))
        PrisonStory.header.animate(to: CGPoint(x: 30, y: 50))
        PrisonStory.header.animate(for: .natural)
        PrisonStory.header.animate(text: "Let's suppose...")
    }
}
