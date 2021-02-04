//
//  DoImage.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/9.
//

import SwiftUI

struct DoImage: View {
    
    var body: some View {
        
        ExampleContainerView("Image") {
            
            doSystemImage
            
            doSetupImageColor
            
            doColorSymbols
            
            doImageScale
            
            doSetupFrame
            
            doImageEffect
            
            doResizable
                        
            doUIImage
        }
        /*:
         https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/
         https://zhuanlan.zhihu.com/p/159653303
         https://developer.apple.com/sf-symbols/
         https://developer.apple.com/documentation/uikit/uiimage/creating_custom_symbol_images_for_your_app
         https://sfsymbols.com
         */
    }
    
    var doSystemImage: some View {
        
        /*:
         在swiftUI中，我们可以使用Image来展示一张图片，
         同时系统提供了一套基于SF字体的图片，
         */
        HExampleView("加载 SF-Symbols 提供的图片"){
            
            Image(systemName: "cloud.fog.fill")
            
            Image(systemName: "moon.circle.fill")
            
            Image(systemName: "sun.dust.fill")
        }
    }
    
    var doSetupImageColor: some View {
        
        HExampleView("为 Image 设置颜色") {
            
            Image(systemName: "wind")
                .foregroundColor(.green)
            
            Image(systemName: "wind")
                .colorMultiply(.green)
            
            Image(systemName: "wind")
                .accentColor(.green)
        }
    }
    
    var doImageScale: some View {
        
        HExampleView("Scale") {
            VStack{
                
                Image(systemName: "sun.dust.fill")
                
                Text("default")
            }
            
            ExampleImageScale(scale: .small)
            
            ExampleImageScale(scale: .medium)
            
            ExampleImageScale(scale: .large)
        }
    }
    var doColorSymbols: some View{
        
        HExampleView("multicolor Symbols") {
            
            Image(systemName: "at.circle.fill")
                .renderingMode(.original)
            
            Image(systemName: "at.circle.fill")
                .renderingMode(.original)
                .colorMultiply(.red)
            
            Image(systemName: "at.circle.fill")
                .renderingMode(.original)
                .foregroundColor(.red)
            
            Image(systemName: "at.circle.fill")
                .renderingMode(.original)
                .accentColor(.red)
        
            Divider()
            
            Image(systemName: "alarm")
                .renderingMode(.original)
            
            Image(systemName: "cloud.sun.rain.fill")
                .renderingMode(.original)
            
            Image(systemName: "thermometer.sun.fill")
                .renderingMode(.original)
            
            Image(systemName: "folder.badge.plus")
                .renderingMode(.original)
            
            Image(systemName: "leaf.fill")
                .renderingMode(.original)
        }
    }
    
    var doSetupFrame: some View {
        
        HScrollExampleView("为 Image 设置 frame "){
            
            Image("the_Great_Wall")
                .resizable()
                .frame(width: 50, height: 100)
            
            Image("icon_map_location",
                  label: Text("原始尺寸"))
            
            Image("icon_map_location")
                //: 不使用`resizable`不可以修改尺寸
                .frame(width: 100, height: 100)
            
            Image("icon_map_location")
                .resizable()
                .frame(width: 100, height: 100)
        }
    }
    
    var doResizable: some View {
        
        HScrollExampleView("使用 resizable 拉伸图片"){

            Group{
                Image("op_sdyn_bubble_user_01")
                    .resizable(resizingMode: .stretch)
                
                Image("live_bubble_user_121")
                    .resizable(resizingMode: .stretch)
                
                Image("live_bubble_user_121")
                    .resizable(resizingMode: .tile)
            }
            .frame(width: 100, height: 100)
            .border(Color.green)
        }
    }
    
    var doImageEffect: some View {
        HExampleView("effect") {
            
            ExampleImageEffect(text: "default")
            
            ExampleImageEffect(text: "colorMultiply")
                .colorMultiply(.red)
            
            ExampleImageEffect(text: "saturation")
                .saturation(0.3)
            
            ExampleImageEffect(text: "contrast")
                .contrast(0.7)
        }
    }
    
    var doUIImage: some View {
        
        /*:
         Image除了可以加载bundle、SF中的图片，
         就还可以加载CGImage、UIImage
         */
        HExampleView("UIImage"){
            
            Group{
                if let uiImage = UIImage(named: "the_Great_Wall") {
                    
                    Image.init(uiImage: uiImage)
                        .resizable()
                        .frame(width: 80, height: 80)
                    
                    Image(uiImage: uiImage)
                        .renderingMode(.none)
                        .resizable()
                        .frame(width: 80, height: 80)
                }
            }
        }
    }
    
    struct ExampleImageScale: View {
        
        var scale: Image.Scale
        
        var body: some View {
            VStack{
                
                Image(systemName: "sun.dust.fill")
                    .imageScale(scale)
                
                Text(scale.text())
            }
        }
    }
    struct ExampleImageEffect: View {
        
        var text: String
        
        var body: some View {
            VStack{
                
                Image("icon_map_location")
                
                Text(text)
            }
        }
    }
}

extension Image.Scale {
    
    func text() -> String {
        switch self {
        case .small: return "small"
        case .medium: return "medium"
        case .large: return "large"
        @unknown default:
            return "default"
        }
    }
}

struct DoImage_Previews: PreviewProvider {
    static var previews: some View {
        DoImage()
    }
}
