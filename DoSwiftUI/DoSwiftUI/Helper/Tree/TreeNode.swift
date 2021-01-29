//
//  TreeNode.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/21.
//

import Foundation

struct TreeNode<A> {
    var value: A
    var children: [TreeNode<A>] = []
    
    init(_ value: A, children: [TreeNode<A>] = []) {
        self.value = value
        self.children = children
    }
}
