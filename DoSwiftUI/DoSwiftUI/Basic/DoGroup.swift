//
//  DoGroup.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/18.
//

import SwiftUI

struct DoGroup: View {
    var body: some View {
        
        doBasic
        
        doDiffWithStack
    }
    
    var doBasic: some View {
        VStack{
            /*:
             使用Group可以将View分成组，但是他有最大15个的限制，
             和各种Stack不同，Group并没有特殊的显示逻辑，仅仅是将View成组。
             */
            Group{
                Text("Hello, World!")
                Text("Hello, World!")
            }
            .font(.system(size: 19))
            .foregroundColor(.blue)
            .border(Color.orange, width: 1)
            .padding()
            .border(Color.gray, width: 1)
            
            /*:
             任意类型的View都可以被添加到Group中
             */
            Group{
                Text("Hello, World!")
                Label(
                    title: { Text("This is a circle icon loaded by sf-symbols") },
                    icon: { Image(systemName: "42.circle").foregroundColor(.green) })
            }
            .font(.system(size: 29))
            .foregroundColor(.red)
            .border(Color.gray, width: 1)
        }
    }
    
    var doDiffWithStack: some View {
        
        VStack{
            /*:
             作用在Group上的modifer会依次作用到内部的View，
             并且在视图层次结构中也并不会存在Group所对应的视图。
             */
            Group{
                Text("Use")
                Text("Group")
                    .foregroundColor(.red)
                Text("to")
                Text("preview")
            }
            .foregroundColor(.blue)
            .font(.system(size: 19))
            .border(Color.green)
            .background(Color.orange)
            
            Divider()
            
            /*:
             `*Stack`类型的控件也不会在视图层级中有对应的视图，
             但是其添加的modifer也仅仅是作用在当前的Stack上，
             并不会依次作用到内部的View上。
             */
            VStack{
                Text("Use")
                Text("VStack")
                    .foregroundColor(.red)
                Text("to")
                Text("preview")
            }
            //: 但是某些modifer还是会作用到子View，比如这个`foregroundColor`
            .foregroundColor(.blue)
            .font(.system(size: 19))
            .border(Color.green)
            .background(Color.orange)
        }
    }
}

struct DoGroup_Previews: PreviewProvider {
    static var previews: some View {
        DoGroup()
    }
}
