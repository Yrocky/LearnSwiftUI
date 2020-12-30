//
//  DoBackgroundAndOverlay.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/18.
//

import SwiftUI

struct DoBackgroundAndOverlay: View {
    
    var body: some View {
        ExampleContainterView("Background&Overlay"){
            
            doBackcgroundBasic
            
            doBackcgroundAlignmentBasic
            
            doOverlayBasic
            
        }
    }
    
    var doBackcgroundBasic: some View {
        /*:
         swiftUI为我们提供了两种方式来设置View的背景和前景：background、overlay。
         
         `.background`这个modifer接收任意的View，
         平常我们会用Color的实例来为背景填充纯色，当然也可以使用诸如Gradient、Rectangle等等。
         */
        VStack(){
            
            VExampleView("使用 Color 作为 background") {
            
                Text("Use Color as background")
                    .background(Color.orange)
            }
            
            VExampleView("使用 Gradient 作为 background") {
                Text("Use LinearGradient as background")
                    .background(linearGradient)
            }
            
            VExampleView("使用 Rectangle 作为 background") {
                
                Text("Use Rectangle as background")
                    .background(rectangle)
            }
            
            VExampleView("使用 Image 作为 background", height: 80) {
                Text("Use Image as background")
                    .frame(height: 80)
                    .background(image)
                    .clipped()
            }
        }
    }
    
    var linearGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.red, Color.blue]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    var rectangle: some View {
        Rectangle()
            .fill(Color.red)
    }
    
    var image: some View {
        Image("the_Great_Wall")
    }
    
    var doBackcgroundAlignmentBasic: some View {
        
        HScrollExampleView("background 中的 alignment") {
            
            Group{
                
                /*:
                 在设置background的时候还可以设置`alignment`，用来指明背景要如何对齐。
                 但貌似没有什么作用
                 */
                Text("setup background with alignment")
                    .background(linearGradient, alignment: .center)
                
                Text("setup background with alignment")
                    .background(linearGradient, alignment: .topLeading)
                
                Text("setup background with aignment")
                    .background(Image(systemName: "car.2").foregroundColor(.orange),
                                alignment: .leading)
                
                Text("setup background with aignment")
                    .background(Image(systemName: "car.2").foregroundColor(.orange),
                                alignment: .topLeading)
            }
            .frame(height: 80)
            .border(Color.gray)
            .padding()
            .border(Color.green)
        }
    }
    
    @State private var overlayProgress: CGFloat = 0.0
    
    var doOverlayBasic: some View {
        
        VExampleView("overlay") {
            /*:
             和background相反，`overlay`是为View添加一个前置视图，它并不会
             */
            Text("you can change slider value")
                .overlay(overlay)
            
            Slider(value: $overlayProgress, in: 0...1)
                .accentColor(.orange)
        }
        .padding()
    }
    
    var overlay: some View {
        GeometryReader{ proxy in
            Rectangle()
                .fill(linearGradient)
                .frame(width: proxy.size.width * overlayProgress,
                       height: proxy.size.height,
                       alignment: .center)
                .cornerRadius(3.0)
        }
    }
}

struct DoBackgroundAndOverlay_Previews: PreviewProvider {
    static var previews: some View {
        DoBackgroundAndOverlay()
    }
}
