import UIKit

class UIProgressViewStyling: UIProgressView {
    
    var height:CGFloat = 7.0
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let size:CGSize = CGSize.init(width: self.frame.size.width, height: height)
        return size
    }
}
