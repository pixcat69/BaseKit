import Foundation
import UIKit
import SystemConfiguration


//MARK: - Date
public extension Date {
    /// Converts a `Date` to a `String` using the specified format.
    ///
    /// ### Common Date Format Examples:
    ///
    /// - `"yyyy-MM-dd"` → `2025-04-23`
    /// - `"dd/MM/yyyy"` → `23/04/2025`
    /// - `"MMMM d, yyyy"` → `April 23, 2025`
    /// - `"E, d MMM yyyy"` → `Wed, 23 Apr 2025`
    /// - `"h:mm a"` → `5:42 PM`
    /// - `"HH:mm:ss"` → `17:42:00`
    /// - `"yyyy-MM-dd'T'HH:mm:ssZ"` → `2025-04-23T17:42:00+0000`
    /// - `"EEEE, MMM d, yyyy"` → `Wednesday, Apr 23, 2025`
    ///
    /// > Tip: Use `"en_US_POSIX"` locale for consistent results across all regions.
    ///
    /// - Parameter format: The date format string you want to apply.
    /// - Returns: A formatted date string.
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
}


//MARK: - UITableViewCell Animation Extension
public extension UITableViewCell {
    enum AnimationDirection {
        case top, bottom, left, right
    }
    func animateAppearance(at indexPath: IndexPath, direction: AnimationDirection = .bottom, duration: CGFloat = 0.5) {
        self.alpha = 0
        switch direction {
        case .top:
            self.transform = CGAffineTransform(translationX: 0, y: -20)
        case .bottom:
            self.transform = CGAffineTransform(translationX: 0, y: 20)
        case .left:
            self.transform = CGAffineTransform(translationX: -20, y: 0)
        case .right:
            self.transform = CGAffineTransform(translationX: 20, y: 0)
        }
        UIView.animate(withDuration: duration, delay: 0.05 * Double(indexPath.row), options: [.curveEaseInOut], animations: {
            self.alpha = 1
            self.transform = .identity
        }, completion: nil)
    }
}


//MARK: - String
public extension String {
    /// Filters filename to extract the desired name part dynamically
    func getName() -> String? {
        return self.components(separatedBy: " - ").last?.components(separatedBy: ".").first
    }
}


//MARK: - Double
public extension Double {
    /// Rounds the double to 'places' decimal places
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    /// Truncates the double to 'places' decimal places (no rounding)
    func truncated(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Double(Int(self * divisor)) / divisor
    }
}


//MARK: - UIColor
public extension UIColor {
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        // Remove leading "#" if present
        if hexFormatted.hasPrefix("#") {
            hexFormatted.removeFirst()
        }

        // Must be 6 characters now
        guard hexFormatted.count == 6,
              let rgbValue = UInt32(hexFormatted, radix: 16) else {
            return nil
        }

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


//MARK: - String
public extension String {
    /// Checks if string can be formed into a valid URL
    @MainActor var isValidURL: Bool {
        guard let url = URL(string: self) else { return false }
        return UIApplication.shared.canOpenURL(url)
    }
    
    /// Checks specifically for web URLs (http or https)
    var isWebURL: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme == "http" || url.scheme == "https"
    }
}
