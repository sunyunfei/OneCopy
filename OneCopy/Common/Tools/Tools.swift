//
//  Tools.swift
//  OneCopy
//
//  Created by Mac on 16/10/8.
//  Copyright © 2016年 DJY. All rights reserved.
//

import UIKit

class Tools: AnyObject {

    /**
     *  获取字符串的宽度和高度
     *
     *  @param text:NSString
     *  @param font:UIFont
     *  @param size:不确定高度的话，可以传CGSize(width,maxFloat) 宽度同理
     *
     *  @return CGRect
     */
    class func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect;
    }
    
    
    
}
