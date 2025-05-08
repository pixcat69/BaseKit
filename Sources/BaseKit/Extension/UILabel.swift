import UIKit


public extension UILabel {
    func setHTMLFromString(_ htmlText: String, textColor: UIColor? = nil) {
        guard let data = htmlText.data(using: .utf8) else { return }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        if let attributedString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) {
            if let color = textColor {
                attributedString.addAttribute(.foregroundColor, value: color, range: NSRange(location: 0, length: attributedString.length))
            }
            self.attributedText = attributedString
        }
    }
}
