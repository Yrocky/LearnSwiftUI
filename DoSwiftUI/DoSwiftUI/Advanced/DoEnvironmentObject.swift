//
//  DoEnvironmentObject.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/27.
//

import SwiftUI

struct DoEnvironmentObject: View {
    
    var body: some View {
        
        ExampleContainerView("EnvironmentObject") {
            /*:
             在SwiftUI中使用不可变的结构体来描述界面，所以每个具体的View都是不可变的，
             
             我们可以使用`EnvironmentObject`来在视图堆栈中共享可能会变化的数据，比如整个App中都会共用一个用户信息，由于用户信息有可能会在某个模块展示，而在另一个模块中会被修改，为了保证数据的一致，我们可以我App注入一个全局的用户信息，这样在整个App内部就会共享用户信息，并且信息都是同步的。
             
             前面也说了，Environment在全局注入的数据发生变化只会引起子View中的变化，这也是EnvironmentObject与它的不同。
             */
            
            doBasic
            
            doStateObject
            
            doObservedObject
            
            doNonexistentEnvironmentObject
        }
    }
    
    var doBasic: some View {
        VExampleView("basic") {
            
            // 展示对象的数据
            VideoDetailView()
            
            // 以下两个都会修改变量
            ModifVideoNameView()
            
            ModifVideoLengthView()
        }
        .environmentObject(Video(name: "唐人街探案 2", length: 120))
    }
    
    /*:
     除了可以使用`.environmentObject`直接注入一个实例，SwiftUI会在内部管理它所涉及的View，
     同时还可以使用`@StateObject`、`@ObservedObject`标记的实例。
     */
    @StateObject var video: Video = Video(name: "你好，李焕英", length: 200)

    var doStateObject: some View {
        
        VExampleView("StateObject") {
            
            VideoDetailView()
            
            ModifVideoNameView()
            
            Text("《\(video.name)》")
        }
        .environmentObject(video)
    }
    
    @ObservedObject var video2: Video = Video(name: "你好，李焕英", length: 200)

    var doObservedObject: some View {
        
        VExampleView("ObservedObject") {
            VideoDetailView()
            
            ModifVideoLengthView()
            
            Text("\(video2.length)")
        }
        .environmentObject(video2)
    }
    
    var doNonexistentEnvironmentObject: some View {
        VExampleView("当没有任何地方设置environmentObject的时候，还去获取，会导致Crash") {
            
            /*:
             父View中没有任何一个通过`.environmentObject`设置了EnvironmentObject，这时候子View如果还去获取，将会导致崩溃，会收到以下报错信息：
             
             > Thread 1: Fatal error: No ObservableObject of type `Video` found. A View.environmentObject(_:) for `Video` may be missing as an ancestor of this view.
             */
            VideoDetailView()
            
            ModifVideoNameView()
        }
        .environmentObject(Video(name: "唐人街探案 2", length: 120))
    }
    
    struct VideoDetailView: View {

        @EnvironmentObject private var video: Video
        
        var body: some View{
            HStack{
                
                Text("《\(video.name)》")
                
                Text("\(video.length) min")
            }
            .card(.pink)
        }
    }

    struct ModifVideoNameView: View {
        
        @EnvironmentObject private var video: Video
        
        var body: some View{
            
            VStack(alignment: .leading){
                
                TextField("modif video name", text: $video.name)
                    .padding()
                    .border(Color.gray, width: 1)
            }
        }
    }

    struct ModifVideoLengthView: View {
        
        @EnvironmentObject private var video: Video
        
        var body: some View{
            Stepper("change length", value: $video.length)
        }
    }
    
    class Video: ObservableObject {
        
        @Published var name: String
        @Published var length: Int
        
        init(name: String = "", length: Int = 0) {
            self.name = name
            self.length = length
        }
    }

}

struct DoEnvironmentObject_Previews: PreviewProvider {
    static var previews: some View {
        DoEnvironmentObject()
    }
}
