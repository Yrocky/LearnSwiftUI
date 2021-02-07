//
//  DoAnchor.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/27.
//

import SwiftUI

struct DoAnchor: View {
    var body: some View {
        ExampleContainerView("Anchor") {
            
            doBasic
            
        }
    }
    
    var doBasic: some View {
        VExampleView("基础用法") {
            /*:
             理论上来说，`Anchor<Value>`可以存储任何类型的数据，但是在文档中只为`CGPoint`、`CGRect`这两种类型做了方法拓展。通过其名字我们也可以知道，Anchor是用来表示锚点，比如常用的九个方位：top、center、bottom、topLeading、bottomTraining等等，这些都是在Value为CGPoint的时候能使用的。而如果我们知道了一个CGRect，就可以很容易的知道以上这几个方位，所以Anchor为Value为CGRect类型的时候做了一些关于范围的拓展。在实际开发中，我们也不太可能在以上两种类型以外的地方使用Anchor。
             */
        }
    }
}

struct DoAnchor_Previews: PreviewProvider {
    static var previews: some View {
        DoAnchor()
    }
}
