import UIKit

extension UIButton {
    /// Applies a simple rounded style; call after layout is finalized.
    func applyRoundedStyle(radius: CGFloat = 8) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}
