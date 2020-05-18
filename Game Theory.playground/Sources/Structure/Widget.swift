import UIKit

public protocol Page {
    static var page : UIView? { get }
    static var close : IconEffectButton? { get }
    
    static func setup(in screen: UIView)
    static func present()
    static func dismiss(_ sender: UIButton!)
}
