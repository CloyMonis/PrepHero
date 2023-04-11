//
//  UIImage_Gif_Extension.swift
//  PrepHero
//
//  Created by Admin_Vserv on 10/04/23.
//

import UIKit

extension UIImage {
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }
        return UIImage.animatedImageWithSource(source)
    }
    public class func gifImageWithURL(_ gifUrl: String) -> UIImage? {
        guard let bundleURL = URL(string: gifUrl) else {
            print("image named \"\(gifUrl)\" doesn't exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        return gifImageWithData(imageData)
    }
    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main.url(forResource: name, withExtension: "gif") else {
            print("This image named \"\(name)\" does not exist")
            return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        return gifImageWithData(imageData)
    }
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        delay = delayObject as? Double ?? 0
        if delay < 0.1 {
            delay = 0.1
        }
        return delay
    }
    class func gcdForPair(_ pair1: Int?, _ pair2: Int?) -> Int {
        var pair1 = pair1
        var pair2 = pair2
        if pair2 == nil || pair1 == nil {
            if pair2 != nil {
                return pair2!
            } else if pair1 != nil {
                return pair1!
            } else {
                return 0
            }
        }
        if pair1 ?? 0 < pair2 ?? 0 {
            let pair3 = pair1
            pair1 = pair2
            pair2 = pair3
        }
        var rest: Int
        while true {
            rest = pair1! % pair2!
            if rest == 0 {
                return pair2!
            } else {
                pair1 = pair2
                pair2 = rest
            }
        }
    }
    class func gcdForArray(_ array: [Int]) -> Int {
        if array.isEmpty {
            return 1
        }
        var gcd = array[0]
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        return gcd
    }
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        for index in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
                images.append(image)
            }
            let delaySeconds = UIImage.delayForImageAtIndex(Int(index),
                source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        let duration: Int = {
            var sum = 0
            for val: Int in delays {
                sum += val
            }
            return sum
        }()
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        var frame: UIImage
        var frameCount: Int
        for index in 0..<count {
            frame = UIImage(cgImage: images[Int(index)])
            frameCount = Int(delays[Int(index)] / gcd)
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        let animation = UIImage.animatedImage(with: frames,
            duration: Double(duration) / 1000.0)
        return animation
    }
}

extension String {
    public func isGif() -> Bool {
        let imageFormats = ["gif"]
        if let ext = self.getExtension() {
            return imageFormats.contains(ext)
        }
        return false
    }
    func getExtension() -> String? {
       let ext = (self as NSString).pathExtension

       if ext.isEmpty {
           return nil
       }

       return ext
    }
}
