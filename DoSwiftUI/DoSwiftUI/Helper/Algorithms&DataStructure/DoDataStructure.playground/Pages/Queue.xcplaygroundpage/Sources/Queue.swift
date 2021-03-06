import Foundation

//final class Queue<Element: Comparable> {
//    private var head: Node<Element>?
//    private var tail: Node<Element>?
//    
//    public var isEmpty: Bool {
//        head == nil
//    }
//    
//    public var size: Int {
//        var count = 0
//        var current = head
//        while current != nil {
//            current = current?.next
//            count += 1
//        }
//        return count
//    }
//    
//    // 尾部添加
//    public func enqueue(_ element: Element) {
//        
//        // 只有当前queue没有包含该元素的时候才进行添加，因为后面会有元素之间的比较操作
//        guard contains(element) == false else {
//            return
//        }
//        
//        // 创建新的node
//        let newNode = Node(element)
//        
//        // 为节点设置previous，以及为tail追加节点
//        tail?.next = newNode
//        newNode.previous = tail
//        
//        // 更新tail为新的节点
//        tail = newNode
//        
//        // 如果queue是空的，需要同时设置head
//        if isEmpty {
//            head = tail
//        }
//    }
//    
//    // 从头部移除
//    public func dequeue() -> Element? {
//        
//        // 保存head
//        let headNode = head
//        
//        // 更新最新的head为原来head的next
//        head = headNode?.next
//        
//        // 如果queue是空的，需要将tail置空
//        if isEmpty {
//            tail = nil
//        }
//        
//        return headNode?.value
//    }
//    
//    public func contains(_ element: Element) -> Bool {
//        
//        var current = head
//        
//        // 遍历整个queue
//        while current != nil {
//            
//            // 如果其中一个node的值等于要查询的，则表示包含
//            if current?.value == element {
//                return true
//            }
//            
//            // 从head依次向下遍历节点
//            current = current?.next
//        }
//        
//        return false
//    }
//    
//    public var elements: [Element] {
//        get {
//            var elements: [Element] = []
//            
//            // 依次遍历整个queue
//            var current = head
//            while let node = current {
//                elements.append(node.value)
//                current = node.next
//            }
//            
//            return elements
//        }
//    }
//}
