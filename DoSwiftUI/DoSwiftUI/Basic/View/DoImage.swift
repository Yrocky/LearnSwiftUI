//
//  DoImage.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/9.
//

import SwiftUI

struct DoImage: View {
    
    var body: some View {
        
        ExampleContainterView("Image") {
            
            doSystemImage
            
            doSetupImageColor
            
            doColorSymbols
            
            doSetupFrame
            
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
            
            Image(systemName: "sun.min")
                .foregroundColor(.red)
            
            Image(systemName: "wind")
                .foregroundColor(.green)
        }
    }
    
    var doColorSymbols: some View{
        
        HExampleView("多彩色的 Symbols，设置不成功") {
            
            Image(systemName: "at.circle.fill")
        
            Image(systemName: "alarm")
            
            Image(systemName: "cloud.sun.rain.fill")
            
            Image(systemName: "thermometer.sun.fill")
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
}

struct DoImage_Previews: PreviewProvider {
    static var previews: some View {
        DoImage()
    }
}
