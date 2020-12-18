//
//  DoLabel.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/17.
//

import SwiftUI

struct DoLabel: View {
    
    @State var showIcon = false
    
    var body: some View {
        
        /*:
         swiftUI在iOS14.0之后提供了一个新的View：Label，
         区别于Text，Label除了可以展示文本，还可以展示图片。
         */
        VStack(alignment: .center, spacing: 10) {
            
            
            doBasic
            
            doSystemLabelStyle
            
            doCustomLabelStyle
            
            doMixture
        }
        .onTapGesture {
            self.showIcon.toggle()
        }
    }
    
    var doBasic: some View {
        /*:
         系统是基于最常见的用户界面推出的这个组件，图片可以是Image，也可以直接使用`SF Symbols`，图片默认居左，文字居右。
         */
        Label("Hello world", systemImage: "lock.fill")
    }
    
    var doSystemLabelStyle: some View {
        /*:
         另外swiftUI还为我们提供了一些style，他们都是遵守`LabelStyle`协议的实例：
         * DefaultLabelStyle，默认的样式，图片居左、文字居右
         * TitleOnlyLabelStyle，只展示文字
         * IconOnlyLabelStyle，只展示图片
         */
        
        VStack{
            
            Label("你好，世界", systemImage: "lock.open")
                .labelStyle(DefaultLabelStyle())
            
            if showIcon {
                Label("请解锁", systemImage: "lock.applewatch")
                    .labelStyle(IconOnlyLabelStyle())
            } else {
                Label("请解锁", systemImage: "lock.applewatch")
                    .labelStyle(TitleOnlyLabelStyle())
            }
        }
    }
    
    var doCustomLabelStyle: some View {
        /*:
         在swiftUI中，如果有style，那么我们就可以自定义style，LabelStyle也不例外。
         */
        VStack{
            Label("欢迎进入中土世界", systemImage: "map.fill")
            Label("欢迎离开中土世界", systemImage: "map")
        }
        .labelStyle(MyLabelStyle())
    }
    
    var doMixture: some View {
        /*:
         同时我们注意到Label的title、icon创建是通过functionBuilder的，
         所以，我们也可以使用一组View，可以是任意的View，
         因此我们可以有下面这样奇怪的组合来组成一个Label。
         */
        Label{
            VStack(alignment: .leading, spacing: 4) {
                Text("魔法世界")
                    .font(.system(size: 18))
                    .foregroundColor(.blue)
                Toggle(isOn: $showIcon) {
                    Text("Entry")
                }
                .labelsHidden()
            }
            .background(Color.pink)
            .cornerRadius(10)
        } icon: {
            HStack{
                Text("leading")
                Circle()
                    .fill(Color.orange)
                    .frame(width: 40, height: 40, alignment: .center)
                Text("training")
            }
            .background(Color.green)
            .cornerRadius(10)
        }
        .padding()
        .border(Color.red, width: 1)
    }
    
    struct MyLabelStyle: LabelStyle {
        func makeBody(configuration: Configuration) -> some View {
            VStack{
                
                configuration.icon
                    .frame(width: 40, height: 40)
                
                configuration.title
                    .font(.system(size: 26))
            }
            .border(Color.gray)
            .foregroundColor(.red)
        }
    }
}

struct DoLabel_Previews: PreviewProvider {
    static var previews: some View {
        DoLabel()
    }
}
