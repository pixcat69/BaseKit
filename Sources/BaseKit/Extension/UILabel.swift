import UIKit
import SafariServices


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
    
    func enableURLLinks() {
        guard let text = self.text else { return }

        let types: NSTextCheckingResult.CheckingType = .link
        let detector = try? NSDataDetector(types: types.rawValue)
        let matches = detector?.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count)) ?? []

        let attributedText = NSMutableAttributedString(string: text)
        for match in matches {
            guard let url = match.url else { continue }
            attributedText.addAttribute(.link, value: url, range: match.range)
        }

        self.attributedText = attributedText
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openURLFromLabel)))
    }

    @objc private func openURLFromLabel(_ recognizer: UITapGestureRecognizer) {
        guard let text = self.attributedText?.string else { return }
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: self.bounds.size)
        let textStorage = NSTextStorage(attributedString: self.attributedText ?? NSAttributedString())

        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        let location = recognizer.location(in: self)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = self.numberOfLines
        textContainer.lineBreakMode = self.lineBreakMode

        let index = layoutManager.characterIndex(for: location, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

        if index < textStorage.length {
            let attributes = textStorage.attributes(at: index, effectiveRange: nil)
            if let url = attributes[.link] as? URL, let vc = self.findViewController() {
                let safariVC = SFSafariViewController(url: url)
                vc.present(safariVC, animated: true)
            }
        }
    }

    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            if let vc = responder as? UIViewController {
                return vc
            }
            responder = responder?.next
        }
        return nil
    }
}
