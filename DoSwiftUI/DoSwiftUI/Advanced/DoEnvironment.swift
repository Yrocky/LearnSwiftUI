//
//  DoEnvironment.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/21.
//

import SwiftUI

struct DoEnvironment: View {
    
    var body: some View {
        /*:
         父View可以通过environment来从上至下的给子View传递数据，
         子View通过访问对应的environment可以得到在视图树中共享的数据。
         
         https://developer.apple.com/documentation/swiftui/environmentvalues
         */
        ExampleContainerView("Environment") {
            
            doInStack
            
            doCustomEnvironmentKey
            
            doWithStruct
        }
    }
    
    @Environment(\.font) var font
    
    var doInStack: some View {
        VExampleView("in Stack") {
            /*:
             
             在SwiftUI中，我们可以有如下的方式来或统一、或单独设置font，如果在父View（VStack）中有设置font，子View会使用父View中的值，如果子View另外单独设置font，则会覆盖父View的值。
             */
            VStack{
                Text("Hello")
                    .foregroundColor(.pink)
                
                Text("Hello")
                    .foregroundColor(.green)
                    .font(.system(size: 18))
                
                Text("Hello")
                    .foregroundColor(.blue)
                    .font(font)
                
                Text("Hello")
                    .foregroundColor(.gray)
                    .environment(\.font, Font.system(size: 18))
            }
            .font(.system(size: 25))
            
            /*:
             这个看起来很平常的一个设置，其实是SwiftUI中`Environment`的应用，除了font，还有很多方法也都是使用了Environment，比如以下这部分（仅仅列出常用的）：
             
             * layoutDirection
             * sizeCategory
             * isEnabled
             * lineLimit
             * lineSpacing
             * textCase
             
             在SwiftUI中，Environment是按照视图层级从上至下来作用到View的，也就是说，每个View都会从父View得到一个Environment，它会存储很多对以`key-value形式`组成的数据。子View如果想要修改某一对数据，可以使用`.environment(keyPath, value)`这个方法，并且针对一些常用的方法，系统有提供View的拓展，比如前面的`.font(Font)`。
             */
        }
    }
    
    @Environment(\.age) var age: Int
    
    var doCustomEnvironmentKey: some View {
        
        VExampleView("custom EnvironmentKey") {
            /*:
             同样的，我们也可以自定义属于自己的环境变量，步骤为：创建相关的key以及默认值，提供对应的value以及对value的读写操作，最后就可以在`.environment(keyPath, value)`中使用了。比如下面，我们提供一个记录age的环境变量。
             
             ```swift
             
             // 提供key、默认值
             struct AgeEnvironmentKey: EnvironmentKey {
                 static var defaultValue: Int = 18
             }
             
             // 实现value的读写操作
             extension EnvironmentValues{
                 var age: Int {
                     get { self[AgeEnvironmentKey.self] }
                     set { self[AgeEnvironmentKey.self] = newValue }
                 }
             }
             ```
             我们也可以像系统那样为View添加一个关于age的拓展，用于便捷修改age：
             
             ```swift
             extension View {
                 func age(_ age: Int) -> some View {
                     self.environment(\.age, age)
                 }
             }
             ```
             
             接着就可以在View中使用了：
             ```swift
             struct UserTopView: View {
                 
                 @Environment(\.age) var age: Int
                 
                 var body: some View{
                     Text("top view \(age)")
                 }
             }
             ```
             以及在父View中的使用：
             ```swift
             struct ContentView: View {
                 
                 @Environment(\.age) var age: Int
             
                 var body: some View{
                     VStack{
                         
                         UserTopView()
                         
                         Text("modif view \(age)")
             
                         UserBottomView()
                             .age(30)
                     }
                     .age(20)
                 }
             }
             ```
             其中UserTopView中显示的age为20，它使用的是父View（VStack）隐式传给它的；Text显示的是18，它直接使用的是祖父View（ContentView）中的数据；最后UserBottomView显示的是30，它使用的是自己显示设置的数据，并且将父View隐式传递给他的（18）覆盖掉了。
             */
            VStack{
                
                UserTopView()
                
                Text("center view \(age)")
                
                UserBottomView()
            }
            .card(.pink)
            
            VStack{
                
                // 他使用的是父View中隐式的age
                UserTopView()
                
                // 他使用的是祖父View中显式的age
                Text("modif view \(age)")
                
                // 他使用的是为自己显式设置的age，优先级比父View中的高
                UserBottomView()
                    .age(30)
            }
            .card(.green)
            .age(20)
        }
    }
    
    @Environment(\.account) var account
    
    var doWithStruct: some View {
        VExampleView("custom EnvironmentKey with Struct") {
            /*:
             除了简单数据类型，还可以使用复杂数据类型作为环境变量，Struct、Enum、Class都可以。不过我们会发现，使用`Environment`标记的变量是read-only的，因为它只能被从父View中获取，这符合设计的初衷，那如果我们需要修改全局环境变量，那要怎么做呢？
             
             这个时候我们可以使用`EnvironmentObject`来标记数据，不过被注入的数据需要准守`ObservableObject`协议，另外是通过`ObservableObject`进行注入，与Environment一样，被EnvironmentObject标记的数据也是从父View按照视图堆栈依次向下传递的。
             
             让我们进入EnvironmentObject中来详细探究。
             */
            VStack{
                Text("name: \(account.name)")
                Text("password: \(account.password)")
            }
            .card(.pink)
            
            AccountView()
                .environment(\.account, Account(name: "rocky", password: "123456"))
        }
    }
}

extension View {
    
    func card(_ color: Color = .pink) -> some View {
        self
            .font(.system(size: 16, weight: .bold, design: .rounded))
            .padding()
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(4)
            .shadow(radius: 3)
    }
}

struct AgeEnvironmentKey: EnvironmentKey {
    static var defaultValue: Int = 18
}

extension EnvironmentValues{
    var age: Int {
        get { self[AgeEnvironmentKey.self] }
        set { self[AgeEnvironmentKey.self] = newValue }
    }
}

extension View {
    func age(_ age: Int) -> some View {
        self.environment(\.age, age)
    }
}

struct UserTopView: View {
    
    @Environment(\.age) var age: Int
    
    var body: some View{
        Text("top view \(age)")
    }
}

struct UserBottomView: View {
    
    @Environment(\.age) var age: Int
    
    var body: some View{
        Text("bottom view \(age)")
    }
}

struct Account {
    var name: String
    var password: String
}

struct AccountEnvironmentKey: EnvironmentKey {
    static var defaultValue: Account = Account(name: "admin", password: "111111")
}

extension EnvironmentValues {

    var account: Account {
        get { self[AccountEnvironmentKey.self] }
        set { self[AccountEnvironmentKey.self] = newValue }
    }
}

struct AccountView: View {
    
    @Environment(\.account) var account
    
    var body: some View{
        VStack{
            Text("name: \(account.name)")
            Text("password:\(account.password)")
        }
        .card(.green)
    }
}

struct DoEnvironment_Previews: PreviewProvider {
    static var previews: some View {
        DoEnvironment()
    }
}
