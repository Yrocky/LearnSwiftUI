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
            
            DoMap()
//            InfiniteListContainer()
//            DoStateAndBinding()
//            ExampleScreenshot()
//            ContentView()
//                .frame(width: 300, height: 100)
                .environment(\.exampleViewWidth, 350)
        }
    }
}

struct ExampleScreenshot: View {
    
    @State private var image: UIImage? = nil
    
    var body: some View {
        VStack(alignment: .leading){
            
            GeometryReader { geometry in
                
                VStack(alignment: .center) {
                    
                    Text("Hello world")
                        .foregroundColor(.red)
                        .font(.system(size: 30))
                        .padding()
                }
                .onTapGesture(count: 2) {
//                    if let snapshoot = takeScreenshot(
//                        origin: geometry.frame(in: .global).origin,
//                        size: geometry.frame(in: .global).size
//                    ) {
//                        image = snapshoot
//                        save(image: snapshoot)
//                    }
                }
            }
            
            if let image = image {
                Image(uiImage: image)
                    .aspectRatio(contentMode: .fit)
                    .border(Color.gray.opacity(0.2))
                    .animation(.easeInOut)
                    .transition(AnyTransition.opacity.combined(with: AnyTransition.scale(scale: 0.3)))
            }
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
