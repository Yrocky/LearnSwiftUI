//
//  DoSafeArea.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/23.
//

import SwiftUI

struct DoSafeArea: View {
    
    @State var currentEdge = 0
    
    var body: some View {
        
//        doBasic
        
        doIgnoresSafeArea
    }
    
    var doBasic: some View {
        /*:
         swiftUI默认情况下会将我们的View在Safe Area内进行布局，
         比如通过下面的代码，在iPhone XS Max上我们将看到Text保留了顶部和底部区域，
         也就是我们所说的在安全区域内。并且旋转屏幕，底部以及左右两边也都保留了部分区域。
         */
        Text("Hello, World!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.2))
    }
    
    var doIgnoresSafeArea: some View {
        
        /*:
         通过使用`ignoresSafeArea`我们可以忽略安全区域，
         这个modifer有两个参数，第一个是`SafeAreaRegions`的实例，第二个为`Edge.Set`枚举类型。
         
         通过SafeAreaRegions我们可以决定在何种情况下忽略安全区域，
         系统为我们提供了`container`、`keyboard`、`all`三种场景。
         
         通过设置对应的Edge.Set枚举可以决定在某个方向或者位置忽略安全区域。
         */
        
        ZStack(alignment: .top) {
    
            MySegmentControl(
                titles: ["top","l","t","b","h","v","a"],
                currentPage: $currentEdge
            ).zIndex(2)
            
            Text(text)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.red.opacity(0.2))
                .cornerRadius(60)// 为了查看View的边距
                .ignoresSafeArea(edges:edges)
                .animation(.easeInOut)
        }
    }
    
    var edges: Edge.Set {
        
        if currentEdge == 0 { return .top }
        else if currentEdge == 1 { return .leading }
        else if currentEdge == 2 { return .trailing }
        else if currentEdge == 3 { return .bottom }
        else if currentEdge == 4 { return .horizontal }
        else if currentEdge == 5 { return .vertical }
        else if currentEdge == 6 { return .all }
        
        return .all
    }
    
    var text: String {
        if currentEdge == 0 { return "忽略顶部，请竖屏查看" }
        else if currentEdge == 1 { return "忽略左边，请横屏查看" }
        else if currentEdge == 2 { return "忽略右边，请横屏查看" }
        else if currentEdge == 3 { return "忽略左边，竖屏、横屏都可以查看" }
        else if currentEdge == 4 { return "忽略水平方向，请横屏查看" }
        else if currentEdge == 5 { return "忽略垂直方向，竖屏、横屏都可以查看" }
        else if currentEdge == 6 { return "忽略所有方向、位置，竖屏、横屏都可以查看" }
        
        return "Hello world!"
    }
    
    
}

struct DoSafeArea_Previews: PreviewProvider {
    static var previews: some View {
        DoSafeArea()
    }
}
