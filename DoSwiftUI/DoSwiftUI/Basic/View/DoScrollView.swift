//
//  DoScrollView.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/17.
//

import SwiftUI

struct DoScrollView: View {
    var body: some View {
//        ExampleContainerView("ScrollView") {
//
//            doVScrollView
//
//            doHScrollView
            
            doStickyHeader
//        }
    }
    
    var doVScrollView: some View {
     
        /*:
         在swiftUI中，我们可以使用`ScrollView`来创建一个可以滑动的视图，
         里面可以放置不限数量的子View。
         
         可以通过ForEeach来构建指定数量的子View
         */
        VExampleView("结合 ForEach，垂直滑动") {
            
            ScrollView{
                ForEach(1..<12) {
                    Text("\($0) Hello, World!")
                        .font(.system(size: 18))
                        .foregroundColor(.orange)
                }
            }
            .border(Color.red ,width: 1)
            .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 80, idealHeight: 100, maxHeight: 150, alignment: .center)
        }
    }
    
    var doHScrollView: some View {
        /*:
         默认在ScrollView中子View是垂直排布的，
         我们可以通过嵌套HStack以及修改ScrollView的axis来达到水平滑动的效果。
         需要注意的是，如果只是修改了axis为`horizontal`，
         并不能达到子View水平布局的效果，比如结合HStack来使用。
         */
        VExampleView("结合HStack、ForEach，水平滚动") {
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(1..<120) { index in
                        /*:
                         在这里我们可以使用任意的View
                         */
                        GroupBox(label: titleLabel) {
                            Text("is \(index) index")
                                .border(Color.gray, width: 1)
                                .padding()
                                .lineLimit(2)
                                .font(.system(size: 18))
                                .foregroundColor(.red)
                                .border(Color.gray, width: 1)
                        }
                    }
                }
            }
            .border(Color.green ,width: 1)
        }
    }
    
    var doStickyHeader: some View {
//        VExampleView("StickyHeader", height: 400) {
            ScrollView(.vertical, showsIndicators: false) {
                StickyHeader(minHeight: 200) {
                    ZStack {
                        Color(red: 35/255, green: 45/255, blue: 50/255)
                        VStack {
                            Text("Learn SwiftUI")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("Step by Step")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                }
                
                VStack{
                    ForEach(0..<20) {
                        Text("NO.\($0)")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                    }
                }
            }
            .background(Color.green)
            .edgesIgnoringSafeArea(.vertical)
//        }
    }
    
    struct StickyHeader<Content: View>: View {
        
        var minHeight: CGFloat
        var content: Content
        
        init(minHeight: CGFloat = 100, @ViewBuilder content: () -> Content) {
            self.minHeight = minHeight
            self.content = content()
        }
        
        var body: some View{
            GeometryReader{ proxy in
                
                let offsetY = proxy.frame(in: .global).minY
                if offsetY <= 0 {
                    content
                        .frame(
                            width: proxy.size.width,
                            height: proxy.size.height
                        )
                } else {
                    content
                        .offset(y: -offsetY)
                        .frame(
                            width: proxy.size.width,
                            height: proxy.size.height + offsetY
                        )
                }
            }
            .frame(minHeight: minHeight)
            .edgesIgnoringSafeArea(.vertical)
        }
    }
    
    var titleLabel: some View {
        Label(
            title: { Text("Hello world~~") },
            icon: { Image(systemName: "36.circle").foregroundColor(.orange) }
        )
        .border(Color.blue, width: 1)
    }
}

struct DoScrollView_Previews: PreviewProvider {
    static var previews: some View {
        DoScrollView()
    }
}
