//
//  DoSection.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/26.
//

import SwiftUI

struct DoSection: View {
    var body: some View {
        ExampleContainterView("Section") {
            
            doBasic
            
            doDynamic
        }
    }
    
    @State var sliderValue = 0.3
    
    var doBasic: some View {
        VExampleView("基础用法") {
            /*:
             在swiftUI中，`Section`被单独抽象出来，
             用来创建具有层次化结构的视图，该层次就类似于UITableView中的一个Section，
             具有头部、尾部以及具体的内容。
             在`Section`中，使用`Parent`、`Footer`以及一个`ViewBuilder`来抽象这三个概念，
             在ViewBuilder中，我们可以编写具体的View来创建一个静态的Section，
             还可以结合ForEach来创建动态的Section。
             */
            
            Section(
                header: HeaderView(),
                footer: FooterView()
            ) {
                ItemView("icon_tecxture_8")
                
                Image(systemName: "bonjour")
                
                ItemView("icon_tecxture_10")
                
                Slider(value: $sliderValue) {
                    Text("Read Progress")
                }
            }
        }
    }
    
    var doDynamic: some View {
        VScrollExampleView("结合 ForEach 使用", height: 150) {
            /*:
             使用`ForEach`我们可以创建一个`动态的Section`，
             但需要注意的是，Section本身是`不具备滚动功能`的，
             因此如果父View的尺寸小于Section内容的尺寸，就会显示异常，
             所以需要将其嵌入到ScrollView中，才可以按照预期的效果显示。
             */
            Section(
                header: HeaderView(),
                footer: FooterView()
            ) {
                ForEach(0..<10) {
                    ItemView("icon_tecxture_\($0)")
                }
            }
            
            Text ("mixed section")
                .foregroundColor(.red)
                .frame(height: 40)
                .background(Color.gray.opacity(0.2))
            
            Section {
                ForEach(0..<6) {
                    ItemView("icon_tecxture_\($0)")
                }
            }
        }
    }
    
    struct HeaderView: View {
        var body: some View {
            HStack {
                
                Image(systemName: "circle.grid.cross.left.fill")
                    .foregroundColor(.orange)
                
                Text("header")
                    .font(.system(size: 18))
                    .foregroundColor(.orange)
                
                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.2))
        }
    }
    
    struct ItemView: View {
        
        let text: String
        
        init(_ text: String) {
            self.text = text
        }
        
        var body: some View {
                
            HStack(alignment: .center, spacing: 10){
                
                Image(text)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .cornerRadius(4)
                
                Text(text)
                    .font(.system(size: 16))
                    .foregroundColor(.green)
                
                    Spacer()
            }
        }
    }
    
    struct FooterView: View {
        var body: some View {
            Text("footer")
        }
    }
}

struct DoSection_Previews: PreviewProvider {
    static var previews: some View {
        DoSection()
    }
}
