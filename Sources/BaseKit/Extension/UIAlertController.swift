import UIKit


//MARK: - UIAlert Controller
@available(iOS 13.0, *)
public extension UIAlertController {
    
    /// Setup custom fonts for title, message, and actions
    func applyCustomFont(titleFont: UIFont? = nil,
                         messageFont: UIFont? = nil,
                         titleColor: UIColor? = nil,
                         messageColor: UIColor? = nil,
                         actions: [(UIAlertAction.Style, String, UIFont?, UIColor?)] = []) {
        
        // Title
        if let title = self.title, let font = titleFont {
            let attrTitle = NSAttributedString(
                string: title,
                attributes: [
                    .font: font,
                    .foregroundColor: titleColor ?? UIColor.label
                ]
            )
            self.setValue(attrTitle, forKey: "attributedTitle")
        }
        
        // Message
        if let message = self.message, let font = messageFont {
            let attrMessage = NSAttributedString(
                string: message,
                attributes: [
                    .font: font,
                    .foregroundColor: messageColor ?? UIColor.label
                ]
            )
            self.setValue(attrMessage, forKey: "attributedMessage")
        }
        
        // Add actions
        for (style, title, font, color) in actions {
            let action = UIAlertAction(title: title, style: style)
            if let font = font {
                action.setValue(NSAttributedString(string: title, attributes: [
                    .font: font,
                    .foregroundColor: color ?? (style == .destructive ? UIColor.red : UIColor.label)
                ]), forKey: "attributedTitle")
            }
            self.addAction(action)
        }
    }
}
