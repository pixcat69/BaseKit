import Foundation


//MARK: Date 
extension Date {
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
