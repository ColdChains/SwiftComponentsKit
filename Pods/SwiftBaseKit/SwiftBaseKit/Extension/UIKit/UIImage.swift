//
//  UIImage.swift
//  SwiftBaseKit
//
//  Created by lax on 2022/9/28.
//

import UIKit

public extension UIImage {
    
    static func image(color: UIColor, rect: CGRect = CGRect(x: 0, y: 0, width: 10, height: 10)) -> UIImage? {
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func toData(quality: CGFloat = 1) -> Data? {
        return jpegData(compressionQuality: quality)
    }
    
    /// 返回一个指定大小的图片
    func resizeImage(image: UIImage, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// 指定图片大小压缩图片
    func compress(size: CGSize) -> UIImage? {
        return resizeImage(image: self, size: size)
    }
    
    /// 指定内存大小压缩图片 maxSize KB
    func compress(maxSize: Int, fixedSize: Bool = false) -> UIImage? {
        var image: UIImage? = self
        if let data = compressData(maxSize: maxSize, fixedSize: fixedSize) {
            image = UIImage(data: data, scale: 1)
        }
        return image
    }
    
    func compressData(maxSize: Int, fixedSize: Bool = false) -> Data? {
        
        var data = toData()
        var image: UIImage? = self
        
        if fixedSize {
            
            let max = size.width > size.height ? size.width : size.height
            image = compress(maxLength: max * CGFloat(maxSize * 1000) / CGFloat(data?.count ?? 1))
            data = image?.toData()
            
        } else {

            var quality: CGFloat = 1
            if let count = data?.count, count > maxSize * 1000 {
                quality = CGFloat(maxSize * 1000) / CGFloat(count)
                data = toData(quality: quality)
                if let newData = data {
                    image = UIImage(data: newData, scale: 1)
                }
                print("压缩前图片:\(toData()?.fileSize ?? ""), 大小超过了\(maxSize)KB, 压缩质量:\(quality), 压缩后data:\(data?.fileSize ?? ""), 转图片后\(image?.toData()?.fileSize ?? "")")
            }
            
        }
        
        return data
    }
    
    /// 指定图片最长边压缩图片
    func compress(maxLength: CGFloat) -> UIImage? {

        let width = size.width
        let height = size.height

        if width > maxLength || height > maxLength {
            var newSize = size
            if width > height {
                newSize = CGSize(width: maxLength, height: maxLength * height / width)
            } else if height > width {
                newSize = CGSize(width: maxLength * width / height, height: maxLength)
            } else {
                newSize = CGSize(width: maxLength, height: maxLength)
            }
            return resizeImage(image: self, size: newSize)
        } else {
            return self
        }
        
    }
    
}

public extension Data {
    
    func toImage() -> UIImage? {
        return UIImage(data: self)
    }
    
    var fileSize: String {
        var n = count
        let arr = ["B", "KB", "MB", "GB", "TB", "PB",  "EB", "ZB", "YB"];
        var index = 0
        while n > 1000, index < arr.count {
            n /= 1000
            index += 1
        }
        return "\(n)\(arr[index])"
    }
    
}
