import UIKit
import StoreKit


public class BaseKitTools {
    
    /// set custom font on UIButton
    @MainActor public static func setAttributedTitleForButton(button: UIButton, title: String, font: UIFont, color: UIColor, alignment: NSTextAlignment) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
    }

    /// show update popup if available
    @MainActor public static func showUpdatePopup(_ vc: UIViewController, apple_ID: String) {
        let alertController = UIAlertController(title: "Update Available",
                                                message: "A new version of the app is available. Please update to enjoy the latest features and improvements.",
                                                preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "Update", style: .default) { _ in
            if let url = URL(string: "itms-apps://itunes.apple.com/app/\(apple_ID)") {
                UIApplication.shared.open(url)
            }
        }
        alertController.addAction(updateAction)
        
        let cancelAction = UIAlertAction(title: "Later", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        vc.present(alertController, animated: true, completion: nil)
    }

    ///Help you to get URL of UIImage
    public static func saveImageToTemporaryDirectory(_ image: UIImage) -> URL? {
        let tempDirectory = FileManager.default.temporaryDirectory
        let imageName = UUID().uuidString + ".jpg"  // Unique file name
        let imageUrl = tempDirectory.appendingPathComponent(imageName)
        
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            do {
                try imageData.write(to: imageUrl)
                return imageUrl
            }
            catch {
                print("Failed to save image:", error)
            }
        }
        return nil
    }

    /// Re-direct url into safari
    @MainActor public static func gotoLink(str: String) {
        guard let url = URL(string: str) else { return }
        UIApplication.shared.open(url)
    }

    /// show rating pop up
    @MainActor public static func rateApp(apple_ID: String) {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        }
        else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + apple_ID) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    ///restart app
    @MainActor public static func restartApp() {
        guard let window = UIApplication.shared.windows.first else {
            return
        }
        
        // Navigate to the initial view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateInitialViewController()
        window.rootViewController = initialViewController
        window.makeKeyAndVisible()
        
        // Add a fade animation to the transition
        UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: nil, completion: nil)
    }

    ///share Application
    public static func shareApp(_ vc: UIViewController, apple_ID: String) {
        DispatchQueue.main.async {
            let appURL = URL(string: "https://apps.apple.com/gb/app/iptv-live-tv/id\(apple_ID)")!
            
            let activityViewController = UIActivityViewController(activityItems: [appURL], applicationActivities: nil)
            vc.present(activityViewController, animated: true)
            
        }
    }
    
    ///Convert date into Desired formate
    public static func formatDate(_ date: Date, toFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
}
