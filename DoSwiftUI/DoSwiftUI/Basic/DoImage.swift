//
//  DoImage.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/9.
//

import SwiftUI

struct DoImage: View {
    var body: some View {
        VStack {
            /*:
             在swiftUI中，我们可以使用Image来展示一张图片，
             同时系统提供了一套基于SF字体的图片，
             */
            Image(systemName: "sun.min")
            
            Image("the_Great_Wall")
                .resizable()
                .frame(width: 100, height: 200)
            
            /*:
             Image除了可以加载bundle、SF中的图片，
             就还可以加载CGImage、UIImage
             */
            Image("icon_map_location")
                .resizable()
                .frame(width: 400, height: 200)
        }
        /*:
         
         https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/
         https://zhuanlan.zhihu.com/p/159653303
         https://developer.apple.com/sf-symbols/
         https://developer.apple.com/documentation/uikit/uiimage/creating_custom_symbol_images_for_your_app
         https://sfsymbols.com
         */
    }
}

struct DoImage_Previews: PreviewProvider {
    static var previews: some View {
        DoImage()
    }
}
