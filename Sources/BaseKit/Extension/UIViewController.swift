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
    
    func setTitle(_ title: String, alignment: NSTextAlignment, font: UIFont) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = .label
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
}
