//
//  DoDisclosureGroup.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/25.
//

import SwiftUI

struct DoDisclosureGroup: View {
    
    var body: some View {
        
        ExampleContainterView("DisclosureGroup") {
            
            doBasic
            
            doCustomLabel
            
            doNest
        }
    }
    
    @State var topExpanded = true
    
    var doBasic: some View {
        
        VExampleView("基础用法") {
        
            /*:
             在前面OutlineGroup的学习中，我们其实是有用到`DisclosureGroup`的，
             DisclosureGroup是一个用来显示或者隐藏`内容视图`的控件，
             主要有三部分构成：`Label`、`Content`、`isExpanded`，
             isExpanded来记录折叠与否，Content是要显示与隐藏的内容。
             
             > A view that shows or hides another content view, based on the state of a disclosure control.
             
             */
            DisclosureGroup("滤镜效果") {
                
                ContentView()
            }
        }
    }
    
    @State var sliderValue = 0.3
    
    var doCustomLabel: some View {
        
        VExampleView("custom label") {
         
            /*:
             我们可以自定义Label，来达到特殊的UI需求，但是，并不可以自定义接收点击操作的视图。
             
             需要注意的一点是，Content虽然定义的是View，但是在这里可以使用多个View作为结果进行返回，
             而没有只能存在一个根View的限制。
             */
            DisclosureGroup(isExpanded: $topExpanded) {
                
                ContentView()
                
                Slider(value: $sliderValue)
                
            } label: {
                HStack{
                    
                    Image(systemName: imageName)
                        .foregroundColor(.orange)
                    
                    Text(title)
                        .fontWeight(.medium)
                        .font(.system(size: 17))
                        .foregroundColor(.orange)
                }
            }
        }
    }
    
    var doNest: some View {
        VExampleView("nest") {
         
            /*:
             由于Content可以是任意的View，我们就可以在Content中使用DisclosureGroup，
             这样就形成了一个嵌套状的结构，也就是我们前面学习的`OutlineGroup`，
             只不过这里我们处于比较低的层级，所以就拥有了更高的自定义能力。
             */
            
            DisclosureGroup("系统权限") {
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("这里是系统权限权限下的内容，当然你也拥有店铺权限")
                    
                    DisclosureGroup("店铺权限") {
                        
                        Text("这里是店铺权限下的内容")
                    }
                }
                .padding()
                .background(Color.red)
            }
        }
    }
        
    var imageName: String {
        topExpanded ? "hand.raised" : "hand.raised.slash"
    }
    
    var title: String {
        topExpanded ? "允许查看" : "不允许查看"
    }
        
    struct ContentView: View {
        
        var body: some View {
            HStack{
                
                Image("icon_tecxture_10")
                    .resizable()
                    .frame(width: 40, height: 40)
                
                Text("甜甜圈效果")
                    .foregroundColor(.green)
                    .font(.system(size: 16))
            }
            .padding()
            .background(Color.gray.opacity(0.2))
        }
    }
}

struct DoDisclosureGroup_Previews: PreviewProvider {
    static var previews: some View {
        DoDisclosureGroup()
    }
}
