import UIKit


@available(iOS 13.0, *)
public extension UIViewController {
    func errorAlert(message: String) -> UIAlertController {
        let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return errorAlert
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setTitle(_ title: String, alignment: NSTextAlignment, font: UIFont, textColor: UIColor = .label) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.textAlignment = alignment
        
        titleLabel.sizeToFit()
        
        let barButtonItem = UIBarButtonItem(customView: titleLabel)
        
        switch alignment {
        case .left:
            self.navigationItem.leftBarButtonItem = barButtonItem
            self.navigationItem.rightBarButtonItem = nil
        case .center:
            self.navigationItem.titleView = titleLabel
        case .right:
            self.navigationItem.rightBarButtonItem = barButtonItem
            self.navigationItem.leftBarButtonItem = nil
        default:
            self.navigationItem.titleView = titleLabel
        }
    }
    
    
    /// Present alert with custom font and tow actions
    func alert(title: String, message: String, style: UIAlertAction.Style, fontName: String, handler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)

        // Create attributed title
        let titleAttr = NSAttributedString(
            string: title,
            attributes: [
                .font: UIFont.init(name: fontName, size: 18)!,
                .foregroundColor: UIColor.label
            ]
        )

        // Create attributed message
        let messageAttr = NSAttributedString(
            string: message,
            attributes: [
                .font: UIFont.init(name: fontName, size: 15)!,
                .foregroundColor: UIColor.label
            ]
        )

        alert.setValue(titleAttr, forKey: "attributedTitle")
        alert.setValue(messageAttr, forKey: "attributedMessage")

        let ok = UIAlertAction(title: "Yes", style: style) { _ in
            handler()
        }
        alert.addAction(ok)

        let no = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(no)
        
        present(alert, animated: true)
    }


    /// Present alert with custom font and only one action
    func alert(on vc: UIViewController, title: String, message: String, fontName: String) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)

        // Create attributed title
        let titleAttr = NSAttributedString(
            string: title,
            attributes: [
                .font: UIFont.init(name: fontName, size: 18)!,
                .foregroundColor: UIColor.label
            ]
        )

        // Create attributed message
        let messageAttr = NSAttributedString(
            string: message,
            attributes: [
                .font: UIFont.init(name: fontName, size: 15)!,
                .foregroundColor: UIColor.secondaryLabel
            ]
        )

        alert.setValue(titleAttr, forKey: "attributedTitle")
        alert.setValue(messageAttr, forKey: "attributedMessage")

        let no = UIAlertAction(title: "Okay", style: .cancel)
        alert.addAction(no)
        
        vc.present(alert, animated: true)
    }
}
