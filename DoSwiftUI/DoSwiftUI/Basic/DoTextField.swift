//
//  DoTextField.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/15.
//

import SwiftUI

struct DoTextField: View {
    
    @State var name: String = ""
    @State var password: String = ""
    var body: some View {
        VStack{
            HStack{
                /*:
                 `TextField`类似于UIKit中的`UITextField`控件，
                 在最新版的TextField中，简化了设置`placehold`，
                 可以直接使用第一个参数来设置placehold。
                 */
                Text("登录名：")
                TextField("your login name", text: $name)
            }
            .padding()
            HStack {
                /*:
                 TextField还提供了输入框内容修改以及点击完成的事件回调。
                 */
                Text("登录名：")
                TextField("User name", text: $name) { (changed) in
                    print("user name did changed:\(changed)")
                } onCommit: {
                    print("commit")
                }
            }
            .padding()
            
            VStack{
                /*:
                 我们可以使用`TextFieldStyle`来为TextField设置样式，
                 TextFieldStyle是一个协议，目前siwftUI提供的样式有：
                 * DefaultTextFieldStyle
                 * PlainTextFieldStyle
                 * RoundedBorderTextFieldStyle
                 * SquareBorderTextFieldStyle(只支持macOS)
                 三种。
                 */
                TextField("DefaultTextFieldStyle", text: $password)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .padding()
                TextField("DefaultTextFieldStyle", text: $password)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding()
                TextField("DefaultTextFieldStyle", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField("SquareBorderTextFieldStyle", text: $password)
                    .textFieldStyle(LeftAndRightViewTextFieldStyle())
                    .padding()
            }
            /*:
             不过遗憾的是，swiftUI并没有为我们提供leftView、rightView、clearView等功能视图，
             我们可以使用已有的内容来模拟出来对应的效果。
             */
            
            MyTextField("placehold")
            
        }
    }
}

/*:
 不过又遗憾的是，swiftUI并没有为`TextFieldStyle`提供更多的信息，这就给我们自定义样式照成了一些阻碍。
 但是通过遵守`TextFieldStyle`协议，我们看到了编译器提示我们必须实现一个私有的实现：
 ```swift

 func _body(configuration: TextField<_Label>) -> some View {
     Text("")
 }
 ```
 
 发生这种情况的原因，一个是官方还没有一个正式的方案来实现该功能，目前处于一个临时草案阶段；
 另一个是系统并不希望用户使用TextFieldStyle来做更多的事情。
 先不管这些，我们根据这个实现来实现一个自定义的样式，通过返回的View，
 我们包裹上对应的leftView和rightView，用来实现类似于UITextField中的效果。
 */
struct LeftAndRightViewTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<_Label>) -> some View {
        
        HStack{
            Image(systemName: "airplane.circle")
                .accentColor(.gray)
            configuration
                .padding()
                .background(LinearGradient(
                                gradient: Gradient(colors: [Color.red, Color.blue]),
                                startPoint: .leading,
                                endPoint: .trailing)
                )
                .cornerRadius(20)
                .accentColor(.white)
            Button(action: {
            }, label: {
                Image(systemName: "clear.fill")
                    .accentColor(.green)
            })
        }
    }
    
    init() {
        
    }
}
/*:
 除了上面的方式，我们还可以直接自定义一个`MyTextField`来实现对应的效果，
 虽然两者都可以实现对应的效果，但是使用`TextFieldStyle`来实现会更加swifter。
 */
struct MyTextField: View {
    
    @State var text: String = ""
    private var placehold: String
    
    init(_ placehold: String) {
        self.placehold = placehold
    }
    
    var body: some View{
        HStack{
            //: leftImage
            Image(systemName: "headphones.circle")
            HStack {
                TextField(placehold, text:$text) { (changed) in
                    print("user name did changed:\(changed)")
                } onCommit: {
                    print("commit")
                }
                //: clear
                Image(systemName: "clear.fill")
            }
            //: rightImage
            Image(systemName: "headphones.circle.fill")
        }
    }
}

struct DoTextField_Previews: PreviewProvider {
    static var previews: some View {
        DoTextField()
    }
}
