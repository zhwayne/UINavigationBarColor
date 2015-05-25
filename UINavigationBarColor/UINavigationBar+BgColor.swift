//
//  UINavigationBarGategory.swift
//  UINavigationBarColor
//
//  Created by wayne on 15/4/9.
//  Copyright (c) 2015年 wayne. All rights reserved.
//

import UIKit

private var key = "overlay"
public var bshadowImage:UIImage?

extension UINavigationBar{
    
    public func bgc_setBackground(# bgColor:UIColor, alpha:CGFloat) -> Void{
        if let view = (self.overlay() as? UIView){
            NSLog("已经设置了")
        }
        else{
            // *** 这两段代码可以把导航栏变透明
            self.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            // *** 这个是导航栏底部的黑色线条
            bshadowImage = self.shadowImage
            self.shadowImage = UIImage()
            // ***
            
            // *** 插入一个视图用于显示背景色
            self.setOverlay(UIView(frame: CGRectMake(0, -20, self.frame.size.width, 64)))
            (self.overlay() as! UIView).backgroundColor = bgColor
            (self.overlay() as! UIView).userInteractionEnabled = false
            (self.overlay() as! UIView).alpha = alpha
            
            self.insertSubview((self.overlay() as! UIView), atIndex: 0)
        }
    }
    
    public func bgc_setBackground(# bgColor:UIColor) -> Void{
        self.bgc_setBackground(bgColor: bgColor, alpha: 1.0)
    }
    
    private func setOverlay(view:UIView){
        var ptr = withUnsafePointer(&key, { (ptr: UnsafePointer<String>) -> UnsafePointer<Void> in
            return unsafeBitCast(ptr, UnsafePointer<Void>.self)
        })
        
        objc_setAssociatedObject(self, ptr, view, (objc_AssociationPolicy)(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
    }
    
    private func overlay() -> AnyObject?{
        var ptr = withUnsafePointer(&key, { (ptr: UnsafePointer<String>) -> UnsafePointer<Void> in
            return unsafeBitCast(ptr, UnsafePointer<Void>.self)
        })
        
        return objc_getAssociatedObject(self, ptr)
    }
}
