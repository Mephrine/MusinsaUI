//
//  UIView+Ext.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/10.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

@IBDesignable
public extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

extension UIView {
    enum Symbol {
        case equal
        case grater
        case less
    }
    
    var centerX: CGFloat { return self.center.x }
    var centerY: CGFloat { return self.center.y }
    
    /**
    # makeConst
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - top : topAnchor
        - paddingTop : topAnchor 값
        - bottom : bottomAnchor
        - paddingBottom : bottomAnchor 값
        - left : leftAnchor
        - paddingLeft : leftAnchor 값
        - right : rightAnchor
        - paddingRight : rightAnchor 값
        - width : 너비 값
        - height : 높이 값
    - Returns:
    - Note: NSLayoutConstraint 지정
    */
    func makeConst(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat = 0, bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat = 0, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat = 0, right: NSLayoutXAxisAnchor?, paddingRight: CGFloat = 0, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.makeConstTop(top, paddingTop)
        self.makeConstBottom(bottom, paddingBottom)
        self.makeConstLeft(left, paddingLeft)
        self.makeConstRight(right, paddingRight)
        self.makeConstWidth(width)
        self.makeConstHeight(height)
    }
    
    /**
    # makeConstWH
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - width : 너비 값
        - height : 높이 값
    - Returns:
    - Note: NSLayoutConstraint 너비/높이 지정
    */
    func makeConstWH(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        self.makeConstWidth(width)
        self.makeConstHeight(height)
    }
    
    /**
    # makeConstEdgeView
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - target: 대상 뷰
        - top : topAnchor
        - bottom : bottomAnchor
        - left : leftAnchor
        - right : rightAnchor
    - Returns:
    - Note: 대상 뷰를 기준으로 NSLayoutConstraint 지정
    */
    func makeConstEdgeView(target: UIView? = nil, top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) {
        let targetView = target ?? self.superview
        guard let superView = targetView else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.makeConstTop(superView.topAnchor, top)
        self.makeConstBottom(superView.bottomAnchor, bottom)
        self.makeConstLeft(superView.leftAnchor, left)
        self.makeConstRight(superView.rightAnchor, right)
        
    }
    
    /**
    # makeConstSuperView
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - top : topAnchor
        - bottom : bottomAnchor
        - left : leftAnchor
        - right : rightAnchor
    - Returns:
    - Note: 현재 뷰의 superView를 기준으로 NSLayoutConstraint 지정
    */
    func makeConstSuperView(top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) {
        self.makeConstEdgeView(top: top, bottom: bottom, left: left, right: right)
    }
    
    /**
    # makeConstAspectSuperView
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - top : topAnchor 값
        - bottom : bottomAnchor 값
        - left : leftAnchor 값
        - right : rightAnchor 값
        - widthAspect1 : 너비 값1
        - widthAspect2 : 너비 값2
        - heightAspect1 : 높이 값1
        - heightAspect2 : 높이 값2
    - Returns:
    - Note: 너비 1, 2 및 높이 1, 2를 비율로 constraints 지정
    */
    func makeConstAspectSuperView(top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0,  widthAspect1: CGFloat = 0, widthAspect2: CGFloat = 0, heightAspect1: CGFloat = 0, heightAspect2: CGFloat = 0) {
        
        self.makeConstEdgeView(top: top, bottom: bottom, left: left, right: right)
        self.makeConstAspectRatioWidth(widthAspect1, widthAspect2)
        self.makeConstAspectRatioHeight(heightAspect1, heightAspect2)
    }
    
    /**
    # makeConstCenter
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - target : target 뷰
    - Returns:
    - Note: 타겟 뷰를 기준으로 CenterX/Y constraints 지정
    */
    func makeConstCenter(target: UIView? = nil) {
        let targetView = target ?? self.superview
        guard let superView = targetView else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.makeConstCenterX(superView.centerXAnchor)
        self.makeConstCenterY(superView.centerYAnchor)
    }
    
    /**
    # setConst
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - identifier : 지정할 identifer
        - anchor : 지정할 anchor
        - padding : 값
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 constraints 적용
    */
    func setConst<T>(_ identifier: String, _ anchor: T , _ padding: CGFloat, _ symbol: Symbol, _ priority: Float? = 1000) {
        if let anchorY = anchor as? NSLayoutYAxisAnchor {
            switch symbol {
            case .equal:
                if identifier.lowercased().contains("top") {
                    topAnchor.constraint(equalTo: anchorY, constant: padding).setPriority(priority).addIdAndActive(identifier)
                } else if identifier.lowercased().contains("bottom") {
                    bottomAnchor.constraint(equalTo: anchorY, constant: padding).setPriority(priority).addIdAndActive(identifier)
                } else {
                    centerYAnchor.constraint(equalTo: anchorY, constant: padding).setPriority(priority).addIdAndActive(identifier)
                }
            case .grater:
                if identifier.lowercased().contains("top") {
                    topAnchor.constraint(greaterThanOrEqualTo: anchorY, constant: padding).setPriority(priority).addIdAndActive(identifier)
                    
                } else if identifier.lowercased().contains("bottom") {
                    bottomAnchor.constraint(greaterThanOrEqualTo: anchorY, constant: padding).setPriority(priority).addIdAndActive(identifier)
                }  else {
                    centerYAnchor.constraint(greaterThanOrEqualTo: anchorY, constant: padding).setPriority(priority).addIdAndActive(identifier)
                }
            case .less:
                if identifier.lowercased().contains("top") {
                    topAnchor.constraint(lessThanOrEqualTo: anchorY, constant: padding).setPriority(priority).addIdAndActive(identifier)
                } else if identifier.lowercased().contains("bottom") {
                    bottomAnchor.constraint(lessThanOrEqualTo: anchorY, constant: padding).setPriority(priority).addIdAndActive(identifier)
                }  else {
                    centerYAnchor.constraint(lessThanOrEqualTo: anchorY, constant: padding).setPriority(priority).addIdAndActive(identifier)
                }
            }
        } else if let anchorX = anchor as? NSLayoutXAxisAnchor {
            switch symbol {
            case .equal:
                if identifier.lowercased().contains("left") {
                    leftAnchor.constraint(equalTo: anchorX, constant: padding).setPriority(priority).addIdAndActive(identifier)
                } else if identifier.lowercased().contains("right") {
                    rightAnchor.constraint(equalTo: anchorX, constant: padding).setPriority(priority).addIdAndActive(identifier)
                }  else {
                    centerXAnchor.constraint(equalTo: anchorX, constant: padding).setPriority(priority).addIdAndActive(identifier)
                }
            case .grater:
                if identifier.lowercased().contains("left") {
                    leftAnchor.constraint(greaterThanOrEqualTo: anchorX, constant: padding).setPriority(priority).addIdAndActive(identifier)
                } else if identifier.lowercased().contains("right") {
                    rightAnchor.constraint(equalTo: anchorX, constant: padding).setPriority(priority).addIdAndActive(identifier)
                }  else {
                    centerXAnchor.constraint(greaterThanOrEqualTo: anchorX, constant: padding).setPriority(priority).addIdAndActive(identifier)
                }
            case .less:
                if identifier.lowercased().contains("left") {
                    leftAnchor.constraint(lessThanOrEqualTo: anchorX, constant: padding).setPriority(priority).addIdAndActive(identifier)
                } else if identifier.lowercased().contains("right") {
                    rightAnchor.constraint(equalTo: anchorX, constant: padding).setPriority(priority).addIdAndActive(identifier)
                }  else {
                    centerXAnchor.constraint(lessThanOrEqualTo: anchorX, constant: padding).setPriority(priority).addIdAndActive(identifier)
                }
            }
        } else if let anchorDimession = anchor as? NSLayoutDimension {
            switch symbol {
            case .equal:
                if identifier.lowercased().contains("Aspect") {
                    if identifier.lowercased().contains("width") {
                        widthAnchor.constraint(equalTo: heightAnchor, multiplier: padding).setPriority(priority) .addIdAndActive(identifier)
                    } else {
                        heightAnchor.constraint(equalTo: widthAnchor, multiplier: padding).setPriority(priority).addIdAndActive(identifier)
                    }
                } else {
                    if identifier.lowercased().contains("width") {
                        widthAnchor.constraint(equalToConstant: padding).setPriority(priority).addIdAndActive(identifier)
                    } else {
                        heightAnchor.constraint(equalToConstant: padding).setPriority(priority).addIdAndActive(identifier)
                    }
                }
            case .grater:
                if identifier.lowercased().contains("Aspect") {
                    if identifier.lowercased().contains("width") {
                        widthAnchor.constraint(greaterThanOrEqualTo: heightAnchor, multiplier: padding).setPriority(priority) .addIdAndActive(identifier)
                    } else {
                        heightAnchor.constraint(greaterThanOrEqualTo: widthAnchor, multiplier: padding).setPriority(priority).addIdAndActive(identifier)
                    }
                } else {
                    if identifier.lowercased().contains("width") {
                        widthAnchor.constraint(greaterThanOrEqualTo: anchorDimession, constant: padding).setPriority(priority).addIdAndActive(identifier)
                    } else {
                        heightAnchor.constraint(greaterThanOrEqualTo: anchorDimession, constant: padding).setPriority(priority).addIdAndActive(identifier)
                    }
                }
            case .less:
                if identifier.lowercased().contains("Aspect") {
                    if identifier.lowercased().contains("width") {
                        widthAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: padding).setPriority(priority) .addIdAndActive(identifier)
                    } else {
                        heightAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: padding).setPriority(priority).addIdAndActive(identifier)
                    }
                } else {
                    if identifier.lowercased().contains("width") {
                        widthAnchor.constraint(lessThanOrEqualTo: anchorDimession, constant: padding).setPriority(priority).addIdAndActive(identifier)
                    } else {
                        heightAnchor.constraint(lessThanOrEqualTo: anchorDimession, constant: padding).setPriority(priority).addIdAndActive(identifier)
                    }
                }
            }
        }
    }
    
    /**
    # makeConstCenterX
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - centerX : centerX anchor
        - padding : 값
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 centerX constraints 적용
    */
    func makeConstCenterX(_ centerX: NSLayoutXAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        if let centerX = centerX {
            setConst("constCenterX", centerX, padding, symbol ?? .equal, priority)
        }
    }
    
    /**
    # makeConstCenterY
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - centerY : centerY anchor
        - padding : 값
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 centerY constraints 적용
    */
    func makeConstCenterY(_ centerY: NSLayoutYAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        if let centerY = centerY {
            setConst("constCenterY", centerY, padding, symbol ?? .equal, priority)
        }
    }
    
    /**
    # makeConstTop
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - top : topAnchor
        - padding : 값
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 top constraints 적용
    */
    func makeConstTop(_ top: NSLayoutYAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        if let top = top {
            setConst("constTop", top, padding, symbol ?? .equal, priority)
        }
    }
    
    /**
    # remakeConstTop
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - top : topAnchor
        - padding : 값
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 top constraints 재적용
    */
    func remakeConstTop(_ top: NSLayoutYAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        self.constraintWithIdentifier("constTop")?.isActive = false
        self.makeConstTop(top, padding, symbol, priority: priority)
    }
    
    /**
    # makeConstBottom
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - bottom : bottomAnchor
        - padding : 값
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 bottom constraints 적용
    */
    func makeConstBottom(_ bottom: NSLayoutYAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal, priority: Float? = nil) {
         if let bottom = bottom {
            setConst("constBottom", bottom, -padding, symbol ?? .equal, priority)
        }
    }
    
    /**
    # makeConstBottom
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - bottom : bottomAnchor
        - padding : 값
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 bottom constraints 재적용
    */
    func remakeConstBottom(_ bottom: NSLayoutYAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        self.constraintWithIdentifier("constBottom")?.isActive = false
        self.makeConstBottom(bottom, padding)
    }
    
    /**
    # makeConstLeft
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - bottom : leftAnchor
        - padding : 값
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 left constraints 적용
    */
    func makeConstLeft(_ left: NSLayoutXAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        if let left = left {
            setConst("constLeft", left, padding, symbol ?? .equal, priority)
        }
    }
    
    /**
    # remakeConstLeft
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - bottom : leftAnchor
        - padding : 값
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 left constraints 재적용
    */
    func remakeConstLeft(_ left: NSLayoutXAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        self.constraintWithIdentifier("constLeft")?.isActive = false
        self.makeConstLeft(left, padding, symbol, priority: priority)
    }
    
    
    /**
    # makeConstRight
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - bottom : rightAnchor
        - padding : 값
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 right constraints 적용
    */
    func makeConstRight(_ right: NSLayoutXAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        if let right = right {
            setConst("constRight", right, -padding, symbol ?? .equal, priority)
        }
    }
    
    /**
    # remakeConstRight
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - bottom : rightAnchor
        - padding : 값
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 right constraints 재적용
    */
    func remakeConstRight(_ right: NSLayoutXAxisAnchor?, _ padding: CGFloat = 0, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        self.constraintWithIdentifier("constRight")?.isActive = false
        self.makeConstRight(right, padding, symbol, priority: priority)
    }
    
    /**
    # makeConstWidth
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - width : 너비 값
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 width constraints 적용
    */
    func makeConstWidth(_ width: CGFloat, _ anchor: NSLayoutDimension? = nil, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        if width != 0 {
            setConst("constWidth", widthAnchor, width, symbol ?? .equal, priority)
        }
    }
    
    /**
    # remakeConstWidth
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - width : 너비 값
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 width constraints 재적용
    */
    func remakeConstWidth(_ width: CGFloat, _ anchor: NSLayoutDimension? = nil, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        self.constraintWithIdentifier("constWidth")?.isActive = false
        self.makeConstWidth(width, anchor, symbol, priority: priority)
    }
    
    /**
    # makeConstHeight
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - height : 높이 값
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 height constraints 적용
    */
    func makeConstHeight(_ height: CGFloat, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        if height != 0 {
            setConst("constHeight", heightAnchor, height, symbol ?? .equal, priority)
        }
    }
    
    /**
    # remakeConstHeight
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - height : 높이 값
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 height constraints 재적용
    */
    func remakeConstHeight(_ height: CGFloat, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        self.constraintWithIdentifier("constHeight")?.isActive = false
        self.makeConstHeight(height, symbol, priority: priority)
    }
    
    /**
    # makeConstAspectRatioWidth
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - aspect1 : width 값 1
        - aspect2 : width 값 2
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 width1, width2 비율로 constraints 적용
    */
    func makeConstAspectRatioWidth(_ aspect1: CGFloat, _ aspect2: CGFloat, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        if aspect1 != 0, aspect2 != 0 {
            setConst("constAspectWidth", widthAnchor, aspect1 / aspect2, symbol ?? .equal, priority)
        }
    }
    
    /**
       # remakeConstAspectRatioWidth
       - Author: Mephrine
       - Date: 20.06.10
       - Parameters:
           - aspect1 : width 값 1
           - aspect2 : width 값 2
           - symbol : symbol
           - priority : 우선순위
       - Returns:
       - Note: 파라미터값들로 width1, width2 비율로 constraints 재적용
       */
    func remakeConstAspectRatioWidth(_ aspect1: CGFloat, _ aspect2: CGFloat, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        self.constraintWithIdentifier("constAspectWidth")?.isActive = false
        self.makeConstAspectRatioWidth(aspect1, aspect2, symbol, priority: priority)
    }
    
    /**
    # makeConstAspectRatioHeight
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - aspect1 : height 값 1
        - aspect2 : height 값 2
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 height1, height2 비율로 constraints 적용
    */
    func makeConstAspectRatioHeight(_ aspect1: CGFloat, _ aspect2: CGFloat, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        if aspect1 != 0, aspect2 != 0 {
            setConst("constAspectHeight", heightAnchor, aspect1 / aspect2, symbol ?? .equal, priority)
        }
    }
    
    /**
    # remakeConstAspectRatioHeight
    - Author: Mephrine
    - Date: 20.06.10
    - Parameters:
        - aspect1 : height 값 1
        - aspect2 : height 값 2
        - symbol : symbol
        - priority : 우선순위
    - Returns:
    - Note: 파라미터값들로 height1, height2 비율로 constraints 재적용
    */
    func remakeConstAspectRatioHeight(_ aspect1: CGFloat, _ aspect2: CGFloat, _ symbol: Symbol? = .equal, priority: Float? = nil) {
        self.constraintWithIdentifier("constAspectHeight")?.isActive = false
        self.makeConstAspectRatioHeight(aspect1, aspect2, symbol, priority: priority)
    }
    
    /**
     # constraintWithIdentifier
     - Author: Mephrine
     - Date: 20.02.07
     - Parameters:
         - identifier: 뷰의 identifier
     - Returns: NSLayoutConstraint?
     - Note: 현재 뷰의 적용된 constraint를 identifier값으로 찾아서 반환
    */
    func constraintWithIdentifier(_ identifier: String) -> NSLayoutConstraint? {
        var searchView: UIView? = self
        while searchView != nil {
            for constraint in searchView!.constraints as [NSLayoutConstraint] {
                if constraint.identifier == identifier {
                    return constraint
                }
            }
            searchView = searchView!.superview
        }
        return nil
    }
}

