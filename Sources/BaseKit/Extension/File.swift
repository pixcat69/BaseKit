import UIKit


extension UILabel {
    func setHTMLFromString(_ htmlText: String) {
        guard let data = htmlText.data(using: .utf8) else { return }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            self.attributedText = attributedString
        }
    }
}
