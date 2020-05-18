import UIKit
import AVFoundation

public struct VideoData {
    
    public enum State {
        case play, pause
    }
    
    public var currentState: State!
    public var duration: Int!
    
    private var name: String!
    private var buffer: AVURLAsset!
    
    public init(name: String) {
        self.currentState = .pause
        
        self.name = name
        self.buffer = AVURLAsset(url: self.getURL())
        self.duration = Int(CMTimeGetSeconds(AVURLAsset(url: self.getURL()).duration))
    }
    
    public func getURL() -> URL {
        return Bundle.main.url(forResource: self.name, withExtension: "mp4", subdirectory: "Videos")!
    }
    
    public func image(at time: TimeInterval, completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            let image = self.pixels(at: time)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    private func pixels(at time: TimeInterval) -> UIImage? {
        let asset = AVURLAsset(url: self.getURL())

        let assetIG = AVAssetImageGenerator(asset: asset)
        assetIG.appliesPreferredTrackTransform = true
        assetIG.apertureMode = AVAssetImageGenerator.ApertureMode.encodedPixels

        let cmTime = CMTime(seconds: time, preferredTimescale: 60)
        let thumbnailImageRef: CGImage
        do {
            thumbnailImageRef = try assetIG.copyCGImage(at: cmTime, actualTime: nil)
        } catch let error {
            print("Error: \(error)")
            return nil
        }

        return UIImage(cgImage: thumbnailImageRef)
    }
}
