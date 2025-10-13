import UIKit

extension UIButton {
    static func customTitle(
        _ title: String,
        font: UIFont,
        color: UIColor,
        alignment: NSTextAlignment,
        underline: Bool = false
    ) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment

        var attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]

        if underline {
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }

        return NSAttributedString(string: title, attributes: attributes)
    }
}
