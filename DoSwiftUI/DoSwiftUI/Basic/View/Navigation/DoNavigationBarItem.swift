//
//  DoNavigationBarItem.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/27.
//

import SwiftUI

struct DoNavigationBarItem: View {
    var body: some View {
        ExampleContainterView("NavigationBarItem") {
         
            doBasic
        }
    }
    
    @State private var showed = false
    
    var doBasic: some View {
        
        VExampleView("navigationBarTitleDisplayMode") {
            
            /*:
             在swiftUI中，并没有提供一个专门对导航栏的抽象，比如NavigationBar，
             但是其提供了一个`NavigationBarItem`，用来对导航栏上的显示做控制，
             比如在UIKit中的BackBarItem、TitleView、RightBarItem。
             我们可以通过`.navigationBarTitleDisplayMode`，来设置当前导航栏的标题是何种显示形式，
             即是否使用`largeTitle`。
             本来还提供了`.navigationBarItems`这个api来自定义左、右两个BarItem，
             但是在iOS14.0之后，就改为使用`Toolbar`来设置了，这部分会在Toolbar中进行学习了解。
             可以使用`.navigationTitle`来设置当前界面的导航栏标题内容。
             为`.navigationBarBackButtonHidden`传递一个bool值，可以隐藏当前界面的导航栏的返回按钮。
             如果我们想隐藏当前界面的导航栏，可以使用`.navigationBarHidden`，
             不过在iOS中，如果一个处于导航堆栈中的界面隐藏了导航栏，那么就没有了返回手势功能。
             
             与NavigationLink一样，NavigationBarItem相关的设置必须要在有导航堆栈的情况下才会生效。
             */
            
            Text("Tap me")
                .onTapGesture {
                    showed.toggle()
                }
                .sheet(
                    isPresented: $showed
                ){
                    NavigationView{
                        List(0..<20) {
                            Text("bazinga \($0)")
                        }
                        .navigationTitle("Detail")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
        }
    }
}

struct DoNavigationBarItem_Previews: PreviewProvider {
    static var previews: some View {
        DoNavigationBarItem()
    }
}
