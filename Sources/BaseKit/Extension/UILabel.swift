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
    
    
    func applyGradient(colors: [UIColor], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 0)) {
        // Make sure label has text
        guard let text = self.text, let font = self.font else { return }
        
        // Clear text color so gradient shows through
        self.textColor = .clear
        
        // Remove any existing gradient layers
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        // Create gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        // Create text mask
        let textMask = CATextLayer()
        textMask.string = text
        textMask.font = font
        textMask.fontSize = font.pointSize
        textMask.alignmentMode = .center
        textMask.frame = self.bounds
        textMask.contentsScale = UIScreen.main.scale
        
        gradientLayer.mask = textMask
        
        // Add gradient layer to label
        self.layer.addSublayer(gradientLayer)
    }
}
