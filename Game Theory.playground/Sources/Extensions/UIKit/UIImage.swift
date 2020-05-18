import UIKit

public extension UIImage {
    static func image(named file: String) -> UIImage {
        do {
            let image = try Data(contentsOf: Bundle.main.url(forResource: "\(file)Icon", withExtension: "png", subdirectory: "Icons")!)
            
            return UIImage(data: image)!
        } catch {
            return UIImage()
        }
    }
    
    static func image(neon file: String) -> UIImage {
        do {
            let image = try Data(contentsOf: Bundle.main.url(forResource: "\(file)Neon", withExtension: "jpg", subdirectory: "Neons")!)
            
            return UIImage(data: image)!
        } catch {
            return UIImage()
        }
    }
    
    func getPixelColor(pos: CGPoint) -> UIColor {

        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4

        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

