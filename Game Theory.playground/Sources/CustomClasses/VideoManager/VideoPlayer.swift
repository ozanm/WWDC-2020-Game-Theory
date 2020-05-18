import UIKit
import AVFoundation

public class VideoPlayer: UIView {
    
    public var completion: () -> ()
    public var activated: Bool
    
    private var timeChecker: UILabel!
    private var updateBtn: IconEffectButton!
    private var video: AVPlayerLayer!
    private var playing: Timer!
    private var data: VideoData!
    
    override public init(frame: CGRect) {
        self.completion = {}
        self.activated = false
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupVideo(with data: VideoData) {
        self.data = data
        
        let playerItem = AVPlayerItem(url: self.data.getURL())
        let player = AVPlayer(playerItem: playerItem)
        self.video = AVPlayerLayer(player: player)
        
        self.apply(subLayer: self.video)
        
        self.data.image(at: 0) {
            self.setBackground(as: $0!)
        }
        
        self.createControls()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    public func start(debugging mode: Bool) {
        self.video.player!.seek(to: CMTime.zero)
        self.play()
        self.updateBtn.fade(type: .In)
        self.timeChecker.fade(type: .In)
    }
    
    private func update(_ sender: UIButton!) {
        switch self.data.currentState {
        case .play:
            self.pause()
        case .pause:
            self.play()
        case .none:
            return
        }
    }
    
    private func play() {
        self.data.currentState = .play
        self.video.player!.play()
        self.updateBtn.apply(icon: "Pause")
        self.timeChecker.text = self.playing != nil ? self.timeChecker.text! : "\(data.duration < 10 ? "0\(data.duration!)" : "\(data.duration!)")s left"
        self.playing = self.playing != nil && self.playing.isValid ? self.playing : Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            let newTime = Int(String((self.timeChecker.text?.prefix(2))!))! - 1
            self.timeChecker.text = "\(newTime > -1 ? (newTime < 10 ? "0\(newTime)" : "\(newTime)") : "\(newTime + 1)")s left"
        }
    }
    
    private func pause() {
        self.data.currentState = .pause
        self.video.player!.pause()
        self.updateBtn.apply(icon: "Play")
        self.stopTimer()
    }
    
    private func createControls() {
        self.updateBtn = IconEffectButton(frame: CGRect(x: 0, y: self.frame.size.height - 100, width: 75, height: 75))
        self.updateBtn.center.x = self.frame.size.width / 2
        self.updateBtn.setCornerRadius(with: 20)
        self.updateBtn.target = { self.update($0) }
        self.updateBtn.apply(background: .dark)
        self.updateBtn.apply(icon: "Pause")
        self.updateBtn.fade(type: .Out)
        self.addSubview(self.updateBtn)
        
        self.timeChecker = UILabel(frame: CGRect(x: 40, y: self.frame.size.height - 100, width: 160, height: 75))
        self.timeChecker.font = UIFont.systemFont(ofSize: 50, weight: .thin)
        self.timeChecker.fade(type: .Out)
        self.addSubview(self.timeChecker)
    }
    
    private func stopTimer() {
        if (self.playing != nil && self.playing.isValid) {
            self.playing.invalidate()
        }
    }
    
    @objc private func playerDidFinishPlaying(note: NSNotification) {
        if activated {
            self.updateBtn.fade(type: .Out)
            self.stopTimer()
            self.completion()
        }
    }
}
