//
//  UIImage+XYExtension.swift
//  Arrietty
//
//  Created by mofeini on 16/12/4.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//

import UIKit

extension UIImage {

    /// 根据颜色生成图片
    class func xy_imageWithColor(color: UIColor) -> UIImage {
        
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0.0);
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        // 获取图形上下文
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
        
    }
    
    /// 根据图片生成一张带边框的圆形图片
    class func xy_circleImage(originImage: UIImage, borderColor: UIColor, borderWidth: CGFloat) -> UIImage? {
        
        // 设置边框宽度
        let imageWH = originImage.size.width
        
        // 设置外圆的尺寸
        let ovalWH = imageWH + 2 * borderWidth;
        
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(originImage.size, false, 0)
        
        // 画一个椭圆
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: ovalWH, height: ovalWH))
        borderColor.set()
        path.fill()
        
        // 设置裁剪区域
        let clipPath = UIBezierPath(ovalIn: CGRect(x: borderWidth, y: borderWidth, width: imageWH, height: imageWH))
        clipPath.addClip()
        
        // 绘制图片
        originImage.draw(at: CGPoint(x: borderWidth, y: borderWidth))
        
        // 从上下文中取出图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭图形上下文
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    
    // 处理图片为圆形图片
    func xy_circleImage() -> UIImage? {
        
        // 开启图形上下文,并且上下文的尺寸和图片的大小一样
        // 第三个参数:当前点与像素的比例，传0系统会自动适配
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        
        // 绘制圆形路径
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        
        // 添加到裁剪
        path.addClip()
        
        // 画图
        self.draw(at: .zero)
        
        // 从上下文中取出图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
//        path.close()
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    
    
}
