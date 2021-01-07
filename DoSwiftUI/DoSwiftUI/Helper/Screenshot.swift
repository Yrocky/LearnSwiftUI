//
//  Screenshot.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/5.
//

import Foundation
import SwiftUI

struct ScreenshotModifer: ViewModifier {
    
    func body(content: Content) -> some View {
        
        content
            .onTapGesture(count: 2) {
                if let image = ImageMaker.takeScreenshot(
                    origin: .zero,
                    size: .zero
                ) {
                    ImageSaver()
                        .writeToPhotoAlbum(image: image)
                }
            }
    }
}

extension View {

    func takeScreenhot() -> some View {
        
        ModifiedContent(
            content: self,
            modifier: ScreenshotModifer()
        )
    }
}

struct ImageMaker {
    
    static func takeScreenshot(origin: CGPoint, size: CGSize) -> UIImage?{
        
        guard let window = UIApplication.shared.windows.first else {
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, false, 0.0)
        let renderer = UIGraphicsImageRenderer(bounds: window.bounds, format: UIGraphicsImageRendererFormat())
        let image = renderer.image { (context) in
            window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
        }
        UIGraphicsEndImageContext()
        
        let scale = UIScreen.main.scale
        let rect = CGRect(
            x: origin.x,
            y: origin.y,
            width: size.width,
            height: size.height
        )
        let croppedImage = image.cropped(boundingBox: rect, scale: scale)
        
        return croppedImage
    }
}

class ImageSaver: NSObject {
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

extension UIImage {
  func cropped(boundingBox: CGRect, scale: CGFloat) -> UIImage? {

  /*
  To crop UIImage we must first convert it to a CGImage.
  UIImage uses points, which are independent of pixels.

  Therefore, we need to take the scaling factor of the screen into account
  when cropping.

  For example, if we want to crop a 100x50pt square starting at (75, 90) from a UIImage
  on a device with a 2x scaling factor, we would multiple everything by 2 and crop a
  200x100px square starting at (150, 180).
  */

    let x = boundingBox.origin.x * scale
    let y = boundingBox.origin.y * scale
    let width = boundingBox.width * scale
    let height = boundingBox.height * scale

    let adjustedBoundingBox = CGRect(x: x, y: y, width: width, height: height)

    guard let cgImage = self.cgImage?.cropping(to: adjustedBoundingBox) else {
      print("UIImage.cropped: Couldn't create cropped image")
      return nil
    }

    return UIImage(cgImage: cgImage)
  }
}
