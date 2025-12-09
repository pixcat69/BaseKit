import UIKit
import ImageIO


public extension UIImage {
    
    static func gifImageWithName(_ name: String, frameDuration: TimeInterval = 0.1) -> UIImage? {
        guard let bundleURL = Bundle.main.url(forResource: name, withExtension: "gif") else { return nil }
        guard let imageData = try? Data(contentsOf: bundleURL) else { return nil }
        return gifImageWithData(imageData)
    }
    
    
    static func gifImageWithData(_ data: Data, frameDuration: TimeInterval = 0.1) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        let count = CGImageSourceGetCount(source)
        var images = [UIImage]()
        var duration: TimeInterval = 0.0

        for i in 0..<count {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else { continue }

            var frameDuration = frameDuration
            if let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [CFString: Any],
               let gifProperties = properties[kCGImagePropertyGIFDictionary] as? [CFString: Any],
               let delayTime = gifProperties[kCGImagePropertyGIFUnclampedDelayTime] as? NSNumber {
                frameDuration = delayTime.doubleValue
                if frameDuration < 0.02 {
                    frameDuration = 0.1
                }
            }

            duration += frameDuration
            images.append(UIImage(cgImage: cgImage))
        }

        return UIImage.animatedImage(with: images, duration: duration)
    }
    
    
    /// convert char in to UIImage
    static func imageWithFirstLetter(from text: String, size: CGSize = CGSize(width: 100, height: 100), color: UIColor, foregroundColor: UIColor = .white, font: UIFont) -> UIImage? {
        guard let firstLetter = text.getName()?.prefix(1) else { return nil }
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: foregroundColor
            ]
            
            let text = String(firstLetter)
            let textSize = text.size(withAttributes: attributes)
            let textOrigin = CGPoint(x: (size.width - textSize.width) / 2,
                                     y: (size.height - textSize.height) / 2)
            text.draw(at: textOrigin, withAttributes: attributes)
        }
    }
    
    
    /// Save UIImage as PNG or JPEG to temp directory and return file URL
    func getURL(fileName: String = UUID().uuidString + ".png") -> URL? {
        // Convert image to PNG data (you can switch to jpeg if needed)
        guard let data = self.pngData() else { return nil }
        
        // Create a file URL in caches directory
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        
        do {
            try data.write(to: url)
            return url
        }
        catch {
            print("Failed to write image to URL:", error)
            return nil
        }
    }
}
