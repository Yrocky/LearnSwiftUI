//
//  DoSecureField.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/26.
//

import SwiftUI

struct DoSecureField: View {
    var body: some View {
        
        ExampleContainterView("SecureField") {
            
            doBasic
            
            doSecureChangeToText
        }
    }
    
    @State private var password: String = ""
    
    var doBasic: some View {
        VExampleView("基础用法") {
         
            /*:
             在swiftUI中，密码输入框没有与TextField一样，
             而是使用一个单独的控件：SecureField，
             但这样一来就没有办法在私密和公开中进行切换了。
             */
            HStack{
    
                Image(systemName: "eye.slash")
                    .foregroundColor(.pink)
                
                SecureField("请输入密码", text: $password)
            }
        }
    }
    
    @State private var isSecure = true
    
    var doSecureChangeToText: some View {
        
        VExampleView("私密和公开之间切换") {
            
            HStack{
    
                /*:
                 如果要实现两种状态之间切换
                 */
                Image(systemName: isSecure ? "eye.slash" : "eye")
                    .foregroundColor(.green)
                    .onTapGesture {
                        withAnimation {
                            isSecure.toggle()
                        }
                    }

                Group {
                    if isSecure {
                        SecureField("请输入密码", text: $password)
                    } else {
                        TextField("输入密码", text: $password)
                    }
                }
                .frame(height: 30)
                .font(.system(.body))
                .foregroundColor(.orange)
                .border(Color.gray.opacity(0.2))
                
                if password.count > 0 {
                
                    Image(systemName: "xmark.circle")
                }
            }
        }
    }
}

struct DoSecureField_Previews: PreviewProvider {
    static var previews: some View {
        DoSecureField()
    }
}
