//
//  DiagramSimple.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/21.
//

import SwiftUI

struct DiagramSimple<A: Identifiable, V: View>: View {
    
    let tree: TreeNode<A>
    let node: (A) -> V
    
    var body: some View {
        VStack(alignment: .center) {
            node(tree.value)
            HStack(alignment: .bottom, spacing: 10) {
                ForEach(tree.children, id: \.value.id) { child in
                    DiagramSimple(tree: child, node: self.node)
                }
            }
        }
    }
}
struct CollectDict<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key:Value] { [:] }
    static func reduce(value: inout [Key:Value], nextValue: () -> [Key:Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

struct Diagram<A: Identifiable, V: View>: View {
    
    let tree: TreeNode<A>
    let node: (A) -> V
    
    typealias Key = CollectDict<A.ID, Anchor<CGPoint>>
    
    var body: some View {
        VStack(alignment: .center) {
            
            node(tree.value)
                .anchorPreference(key: Key.self, value: .center) {
                    [self.tree.value.id: $0]
                }
            
            HStack(alignment: .bottom, spacing: 10) {
                ForEach(tree.children, id: \.value.id) { child in
                    DiagramSimple(tree: child, node: self.node)
                }
                if tree.children.count == 1 {
                    // add emptyView
                }
            }
        }
    }
}

class Unique<A>: Identifiable {
    let value: A
    init(_ value: A) {
        self.value = value
    }
}

extension TreeNode {
    func map<B>(_ transform: (A) -> B)-> TreeNode<B> {
        TreeNode<B>(transform(value), children: children.map { $0.map(transform)})
    }
}

let binaryTree = TreeNode<Int>(50, children: [
    TreeNode(17, children: [
        TreeNode(12),
        TreeNode(23)
    ]),
    TreeNode(72, children: [
        TreeNode(54),
        TreeNode(79)
    ])
])

let uniqueTree: TreeNode<Unique<Int>> = binaryTree.map(Unique.init)

struct TreeExample: View {
    
    @State var tree = uniqueTree
    var body: some View {
        DiagramSimple(tree: tree) {
            Text("\($0.value)")
                .modifier(TreeNodeRoundCircleStyle())
        }
    }
}

struct TreeNodeRoundCircleStyle: ViewModifier {
    var fill: some View {
        Circle()
            .stroke(Color.orange)
            .background(Circle().fill(Color.white))
    }
    func body(content: Content) -> some View {
        content
            .frame(width: 50, height: 50)
            .background(fill)
            .foregroundColor(.orange)
//            .padding()
    }
}
