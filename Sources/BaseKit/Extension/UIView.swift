import Foundation
import UIKit


public extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async { [self] in
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    func applyShadow(color: UIColor = .black, opacity: Float = 0.5, offset: CGSize = CGSize(width: 0, height: 2), radius: CGFloat = 4) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
    }
    
    func corner_border(corner: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        self.layer.cornerRadius = corner
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    enum UIViewFadeStyle {
        case bottom
        case top
        case left
        case right
        
        case vertical
        case horizontal
    }
    
    func fadeView(style: UIViewFadeStyle = .bottom, percentage: Double = 0.07) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
        
        let startLocation = percentage
        let endLocation = 1 - percentage
        
        switch style {
        case .bottom:
            gradient.startPoint = CGPoint(x: 0.5, y: endLocation)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        case .top:
            gradient.startPoint = CGPoint(x: 0.5, y: startLocation)
            gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        case .vertical:
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
            gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
            gradient.locations = [0.0, startLocation, endLocation, 1.0] as [NSNumber]
            
        case .left:
            gradient.startPoint = CGPoint(x: startLocation, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .right:
            gradient.startPoint = CGPoint(x: endLocation, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        case .horizontal:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
            gradient.locations = [0.0, startLocation, endLocation, 1.0] as [NSNumber]
        }
        
        layer.mask = gradient
    }
    
    enum GradientDirection {
        case vertical
        case horizontal
        case topLeftToBottomRight
        case bottomLeftToTopRight
        case topRightToBottomLeft
        case bottomRightToTopLeft
    }
    
    func setLinerBackground(colorTop: UIColor, colorMiddle: UIColor? = nil, colorBottom: UIColor, direction: GradientDirection) {
        let gradientLayer = CAGradientLayer()
        
        if let middleColor = colorMiddle {
            gradientLayer.colors = [colorTop.cgColor, middleColor.cgColor, colorBottom.cgColor]
            gradientLayer.locations = [0.0, 0.5, 1.0]
        } else {
            gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
            gradientLayer.locations = [0.0, 1.0]
        }
        
        switch direction {
        case .vertical:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        case .horizontal:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .topLeftToBottomRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        case .bottomLeftToTopRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        case .topRightToBottomLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        case .bottomRightToTopLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        }
        
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    enum TransitionAnimation {
        case fade, slideFromLeft, slideFromRight, slideUp, slideDown, scale, flip
    }
    
    func applyTransition(_ animation: TransitionAnimation, duration: TimeInterval = 0.6) {
        switch animation {
        case .fade:
            self.alpha = 0
            UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut]) {
                self.alpha = 1
            }
            
        case .slideFromLeft:
            self.transform = CGAffineTransform(translationX: -self.frame.width, y: 0)
            self.alpha = 0
            UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut]) {
                self.transform = .identity
                self.alpha = 1
            }
            
        case .slideFromRight:
            self.transform = CGAffineTransform(translationX: self.frame.width, y: 0)
            self.alpha = 0
            UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut]) {
                self.transform = .identity
                self.alpha = 1
            }
            
        case .slideUp:
            self.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
            self.alpha = 0
            UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut]) {
                self.transform = .identity
                self.alpha = 1
            }
            
        case .slideDown:
            self.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
            UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut]) {
                self.transform = .identity
                self.alpha = 1
            }
            
        case .scale:
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: [.curveEaseOut]) {
                self.transform = .identity
            }
            
        case .flip:
            var transform = CATransform3DIdentity
            transform.m34 = -1.0 / 500 // Adds a slight 3D effect
            self.layer.transform = CATransform3DRotate(transform, .pi / 2, 0, 1, 0)
            
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [.curveEaseInOut]) {
                self.layer.transform = CATransform3DIdentity
            }
        }
    }
    
    func addTopRoundedCornerToView(targetView:UIView?, desiredCurve:CGFloat?) {
        let offset:CGFloat =  targetView!.frame.width/desiredCurve!
        let bounds: CGRect = targetView!.bounds
        
        //Top side curve
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y+bounds.size.height / 2, width: bounds.size.width, height: bounds.size.height / 2)
        
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        
        //Top side curve
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        // Set the newly created shape layer as the mask for the view's layer
        targetView!.layer.mask = maskLayer
    }
    
    func setTopCurve(){
        let offset = CGFloat(self.frame.size.height/4)
        let bounds = self.bounds
        let rectBounds = CGRect(x: bounds.origin.x, y: bounds.origin.y + bounds.size.height/2  , width:  bounds.size.width, height: bounds.size.height / 2)
        
        let rectPath = UIBezierPath(rect: rectBounds)
        
        let ovalBounds = CGRect(x: bounds.origin.x , y: bounds.origin.y - offset / 2, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        self.layer.mask = maskLayer
    }
    
    func addBottomRoundedCornerToView(targetView:UIView?, desiredCurve:CGFloat?) {
        let offset:CGFloat =  targetView!.frame.width/desiredCurve!
        let bounds: CGRect = targetView!.bounds
        
        //Bottom side curve
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
        
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        
        //Bottom side curve
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        // Set the newly created shape layer as the mask for the view's layer
        targetView!.layer.mask = maskLayer
    }
    
    func setBottomCurve(){
        let offset = CGFloat(self.frame.size.height/4)
        let bounds = self.bounds
        
        let rectBounds = CGRect(x: bounds.origin.x, y: bounds.origin.y  , width:  bounds.size.width, height: bounds.size.height / 2)
        let rectPath = UIBezierPath(rect: rectBounds)
        let ovalBounds = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        
        let ovalPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        self.layer.mask = maskLayer
    }
    
    
    func applyInnerGlow(color: UIColor, radius: CGFloat, opacity: Float = 1.0) {
        layer.masksToBounds = false // Important to allow shadow outside the bounds
        
        // Create a shadow path inset from the view's bounds
        let shadowPath = UIBezierPath(rect: bounds.insetBy(dx: -radius, dy: -radius))
        
        // Create an inner shadow path by subtracting the view's path
        let innerShadowPath = UIBezierPath(rect: bounds)
        shadowPath.append(innerShadowPath.reversing())
        
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = radius
        layer.shadowPath = shadowPath.cgPath
    }
    
    func removeInnerGlow() {
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOpacity = 0
        layer.shadowPath = nil
    }
    
}
