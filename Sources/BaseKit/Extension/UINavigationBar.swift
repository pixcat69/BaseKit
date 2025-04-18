import UIKit




@available(iOS 13.0, *)
public extension UINavigationBar {
    
    func setTitleFont(_ font: UIFont, color: UIColor = .label) {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .font: font,
            .foregroundColor: color
        ]
        
        self.standardAppearance = appearance
        self.scrollEdgeAppearance = appearance
        self.compactAppearance = appearance
    }
    
    
    func setCustomBackButton(imageName: String = "chevron.backward.circle.fill", tintColor: UIColor = .label) {
        let backImage = UIImage(systemName: imageName)
        let appearance = self.standardAppearance
        
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        
        // Remove the back button title
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.backButtonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        self.standardAppearance = appearance
        self.scrollEdgeAppearance = appearance
        self.compactAppearance = appearance
        
        self.tintColor = tintColor
    }
}
