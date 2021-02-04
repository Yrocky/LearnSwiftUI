//
//  DoActionSheetAlert.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/26.
//

import SwiftUI

struct DoActionSheetAlert: View {
    var body: some View {
        ExampleContainerView("ActionSheet & Alert") {
            
            doActionSheet
            
            doActionSheetBindingWithItem
            
            doAlert
            
            doSheet
        }
    }
    
    @State private var isActionSheetPresented = false
    
    var doActionSheet: some View {
        VExampleView("ActionSheet") {
            /*:
             在swiftUI中，`ActionSheet`不是一个单一的View，
             而是需要通过`actionSheet`这个ViewModifer才可以进行展示。
             需要注意的是，ActionSheet的选项只能使用Text来展示，
             ActionSheet的选项事件回调，是在创建每一个Option-Button的时候决定的。
             
             swiftUI中的ActionSheet与UIKit中的UIAlertController一样，
             都没有提供`禁用选项`以及`自定义选项样式`这样的功能，如果要实现这样的功能，只能自定义来实现。
             */
            
            Text("Tap me show ActionSheet")
                .font(.system(size: 20))
                .foregroundColor(.red)
                .onTapGesture {
                    isActionSheetPresented.toggle()
                }
                .actionSheet(isPresented: $isActionSheetPresented) {
                    ActionSheet(title: Text("Which is your"),
                                message: Text("favorite sport"),
                                buttons: [
                                    .default(Text("gymnastics")),
                                    .default(Text("swimming")),
                                    .default(Text("fencing")){
                                        print("you select is fencing")
                                    },
                                    .destructive(Text("<destructive>")),
                                    .default(Text("volleyball")),
                                    .default(Text("basketball")),
                                    .cancel()
                                ]
                    )
                }
            
            Text("Current presented-value is: \(isActionSheetPresented.description)")
        }
    }
    
    
    @State private var actionSheetItem : ActionSheetItem? = nil
    
    var doActionSheetBindingWithItem: some View {
        VExampleView("ActionSheet 的显示与否使用一个 Identifiable 的 Optional") {
            
            /*:
             在前面我们使用的是一个`Bool类型`来控制ActionSheet的显示与否，
             其实我们还可以使用一个遵守`Identifiable`协议的可选型实例来完成显示与否。
             通过示例我们可以发现，ActionSheet的`source of truth`会跟随者显示与否进行改变，
             同时我们只要修改了source，就可以完成ActionSheet的显示与否，
             这一点也可以很好的诠释swiftUI中的source of truth。
             */
            
            Text("Tap me show ActionSheet")
                .font(.system(size: 20))
                .foregroundColor(.green)
                .actionSheet(item: $actionSheetItem) { item in

                    ActionSheet(title: Text("Which is your"),
                                message: Text("favorite sport"),
                                buttons: [
                                    .default(Text("swimming")),
                                    .default(Text("volleyball")),
                                    .default(Text("basketball")),
                                    .cancel()
                                ]
                    )
                }
            
            HStack(spacing: 20) {
                Button("Make it nil") {
                    self.actionSheetItem = nil
                }
                
                Button("Make it value") {
                    self.actionSheetItem = .show
                }
            }
            
            Text("Current item is: \(actionSheetItem.debugDescription)")
        }
    }

    @State private var isAlertPresented = false

    var doAlert: some View {
        VExampleView("Alert") {
            /*:
             `Alert`与ActionSheet的创建类似，它也可以使用Bool、Optional来决定Alert展示与否，
             我们可以使用`alert`来创建一个Alert。
             虽然要求了title、message是一个Text，
             但是通过诸如`fontWeight`、`font`、`strikethrough`、
             `foregroundColor`等ViewModifer创建的Text并不能生效，ActionSheet中也一样。
             */
            Text("Tap me show Alert")
                .font(.system(size: 20))
                .foregroundColor(.orange)
                .onTapGesture {
                    isAlertPresented.toggle()
                }
                .alert(isPresented: $isAlertPresented) {
                    Alert(title: titleText,
                          message: messageText,
                          primaryButton: .destructive(Text("Sure")),
                          secondaryButton: .default(Text("Cancel")))
                }
        }
    }
    
    @State private var isSheetPresented = false
    
    var doSheet: some View {
        VExampleView("sheet") {
            /*:
             在文档中还存在一个`sheet`，通过这个api我们可以展示一个`新的View`，
             在界面上的展示形式就是一个present的视图，同时还提供了View消失的事件回调
             */
            
            Text("Try tap me~")
                .font(.system(size: 20))
                .foregroundColor(.purple)
                .onTapGesture {
                    isSheetPresented.toggle()
                }
                .sheet(isPresented: $isSheetPresented) {
                    print("sheet was dismiss")
                } content: {
                    DoColor()
                }
            
            Text("New page now is:\(isSheetPresented.description)")
        }
    }
    
    var titleText: Text {
        //: Just Text
        Text("Did you Logout?")
            //: 不生效
            .font(.system(size: 18))
            .foregroundColor(.green)
    }
    
    var messageText: Text {
        //: Maybe some View
        Text("If you logout ,you user info will remove.")
            //: 不生效
            .font(.system(size: 20))
            .foregroundColor(.orange)
            //: 我们不可以使用一个非Text作为Alert中的title、message
//            .background(Color.gray.opacity(0.2)) as! Text
    }
    
    
    // mock some Identifiable
    enum ActionSheetItem: String, Identifiable {
        
        case show
            
        var id: String { self.rawValue }
    }
}

struct DoActionSheetAlert_Previews: PreviewProvider {
    static var previews: some View {
        DoActionSheetAlert()
    }
}
