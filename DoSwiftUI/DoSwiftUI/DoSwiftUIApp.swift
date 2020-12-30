//
//  DoSwiftUIApp.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/9.
//

import SwiftUI

@main
struct DoSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.exampleViewWidth, 350)
        }
    }
}

func makeSnapshot() {
    
    func findTargetView() -> UIView {
        
        return UIView()
    }
    
    func snapshot(for targetView: UIView) {
        
    }
    
    snapshot(for: findTargetView())
}

// HostingScrollView
// - PlatformGroupContainer
// --- CGDrawingView
// --- ...

// onAppear,自动截图，保存到本地

extension UIScrollView {

    var capture: UIImage? {

        var image: UIImage? = nil
        UIGraphicsBeginImageContext(self.contentSize)
        do {
            let savedContentOffset = self.contentOffset
            let savedFrame = self.frame
            self.contentOffset = .zero
            self.frame = CGRect(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height)

            UIGraphicsBeginImageContextWithOptions(CGSize(width: self.contentSize.width, height: self.contentSize.height), false, 0.0)

            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            image = UIGraphicsGetImageFromCurrentImageContext()
            self.contentOffset = savedContentOffset
            self.frame = savedFrame
        }
        UIGraphicsEndImageContext()
        if image != nil {
            return image!
        }
        return nil
    }
}
