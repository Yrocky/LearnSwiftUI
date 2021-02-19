//
//  DoStateObject.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/27.
//

import SwiftUI

struct DoStateObject: View {
    var body: some View {
        
        ExampleContainerView("StateObject") {
            /*:
             通过StateObject标记的对象会被SwiftUI所存储，不需要我们手动的来管理创建以及销毁，一般会在一个容器中使用，比如一个存储所有Todo-Item的对象会在列表中创建，并且会被在各个子View中分享。SwiftUI只会创建一次，他也是需要使用`environmentObject`来注入数据的。
             */
        }
    }
}

struct DoStateObject_Previews: PreviewProvider {
    static var previews: some View {
        DoStateObject()
    }
}
