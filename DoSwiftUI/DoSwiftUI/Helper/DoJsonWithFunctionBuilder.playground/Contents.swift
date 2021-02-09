import UIKit

var str = "Hello, playground"

// https://github.com/apple/swift-evolution/blob/main/proposals/0289-result-builders.md

struct JSON {
    let name: String
    let value: Value
    
    init(_ name: String, _ value: Value) {
        self.name = name
        self.value = value
    }
}

extension JSON {
    enum Value {
        case bool(Bool)
        case int(Int)
        case double(Double)
        case string(String)
        case group([JSON])
    }
}

/*:
 {
     "code": 200,
     "message": "success~",
     "data": {
         "name": "rocky",
         "vip": true,
         "level": 233
     }
 }
 
 {
     "code": 200,
     "message": "success~",
     "data": [
         {"name": "rocky"},
         {"name": "洛奇"}
     ]
 }
 */
let json = JSON("result", .group([
    JSON("code", .int(200)),
    JSON("message", .string("success~")),
    JSON("data", .group([
        JSON("name", .string("rocky")),
        JSON("vip", .bool(true)),
        JSON("level", .int(233))
    ]))
]))

@_functionBuilder
struct JSONBuilder {
    
    typealias Expression = JSONConvertible
    
    typealias Component = [JSON]
    
    /*:
     因为我们使用了JSONConvertible协议，并且JSON、JSONGroup都是遵守协议的，所以，这个方法其实是等效于下面两个表达式方法。
     */
    static func buildExpression(_ expression: Expression) -> Component {
        expression.asJSON()
    }
    
    /*:
     理论上，这两个方法是不需要再写的
     */
    static func buildExpression(_ json: JSON) -> Component {
        json.asJSON()
    }
    
    static func buildeExpression(_ jsonGroup: JSONGroup) -> Component {
        jsonGroup.asJSON()
    }

    /*:
     为了这种可以编译正常，使用
     
     ```swift
     let json_3 = makeJSON {
         
         JSON("result", .group([
             JSON("code", .int(200)),
             JSON("message", .string("success~")),
             JSON("data", .group([
                 JSON("name", .string("rocky")),
                 JSON("vip", .bool(true)),
                 JSON("level", .int(233))
             ]))
         ]))
     }
     ```
     */
    static func buildBlock(_ children: Component...) -> Component {
        children.flatMap { $0 }
    }
    
//    static func buildBlock(_ children: JSONConvertible...) -> Component {
//        children.flatMap { $0.asJSON() }
//    }
    
    static func buildBlock(_ jsonGroups: JSONGroup...) -> Component {
        jsonGroups.flatMap{ $0.asJSON() }
    }
    
    static func buildBlock(_ jsons: JSON...) -> Component {
        jsons
    }
    
    /*:
     为了`let json_2 = makeJSON {}` 这种可以正常编译，没有任何表达式，直接返回一个空的数组
     */
    static func buildBlock() -> Component {
        []
    }
}

func makeJSON(@JSONBuilder _ content: () -> [JSON]) -> [JSON] {
    content()
}

let json_2 = makeJSON {}

let json_3 = makeJSON {
    
    JSON("result", .group([
        JSON("code", .int(200)),
        JSON("message", .string("success~")),
        JSON("data", .group([
            JSON("name", .string("rocky")),
            JSON("vip", .bool(true)),
            JSON("level", .int(233))
        ]))
    ]))
}

struct JSONGroup {
    var name: String
    var jsons: [JSON]
    
    // 便利初始化方法
    init(_ name: String, _ jsons: [JSON]) {
        self.name = name
        self.jsons = jsons
    }
    
    init(_ name: String, _ jsons: [JSONConvertible]) {
        self.init(name, jsons.flatMap{ $0.asJSON() })
    }
    
    init(_ name: String, @JSONBuilder builder: () -> [JSONConvertible]) {
        self.init(name, builder())
    }
}

/*:
 我们可以省去逗号，
 
 但是如果编写了如下的代码，会得到一个报错，
 
 ```swift

 let userGroup = JSONGroup("user") {
     JSON("name", .string("rocky"))
     JSON("uid", .int(10086))
     JSON("level", .int(233))
     locationGroup// JSONGroup对象
 }

 ```
 
 原因是我们的JSONBuilder中接受的是一个JSON对象，不允许接受JSONGroup对象
 */

let locationInfo = JSONGroup("location") {
    JSON("coordinate", .group([
        JSON("longitude", .double(31.22)),
        JSON("latitude", .double(121.48))
    ]))
    JSON("detail", .string("China Shanghai huangpuqu R.renmin NO.56"))
    JSON("province", .string("Shanghai"))
    JSON("city", .string("huangpuqu"))
    JSON("country", .string("China"))
    JSON("street", .string("R.renmin NO.56"))
}

let userInfo = JSONGroup("user") {
    JSON("name", .string("rocky"))
    JSON("uid", .int(10086))
    JSON("level", .int(233))
    locationInfo// JSONGroup对象
}

/*:
 这个时候。我们需要使用协议将JSON、JSONGroup取消差异性，创建一个`JSONConvertible`协议，允许具体类型转化出JSON。
 
 然后修改JSONBuilder，使他接受JSONConvertible，而不是JSON，这样也不会限制具体类型，拓展性更高
 */

protocol JSONConvertible {
    func asJSON() -> [JSON]
}

extension JSON: JSONConvertible {
    func asJSON() -> [JSON] { [self] }
}

extension JSONGroup: JSONConvertible {
    func asJSON() -> [JSON] {
        [JSON(name, .group(jsons))]
    }
}

extension JSONBuilder {
    /*:
     为了让block中不限制JSON、JSONGroup类型而做的拓展，接受`JSONConvertible`类型，然后对其进行转换
     */
    static func buildBlock(_ jsons: JSONConvertible...) -> Component {
        jsons.flatMap{ $0.asJSON() }
    }
}

/*:
 在一些逻辑中，会接入if-else来设置json数据，我们需要实现`buildEither`相关的方法
 */
extension JSONBuilder {
    
    static func buildIf(_ value: JSONConvertible?) -> Component {
        if let value = value {
            return value.asJSON()
        }
        return []
    }
    
    static func buildEither(first: JSONConvertible) -> Component {
        first.asJSON()
    }
    
    static func buildEither(second: JSONConvertible) -> Component {
        second.asJSON()
    }
}

extension Array: JSONConvertible where Element == JSON {
    func asJSON() -> [JSON] {
        self
    }
}

let isVip: Bool = false

let vipInfo = JSONGroup("vipInfo") {
    if isVip {
        JSON("level", .int(3))
        JSON("name", .string("duke"))
        JSON("color", .string("#D4666C"))
    }
}

let json_4 = JSONGroup("result") {
    JSON("code", .int(200))
    JSON("message", .string("success~"))
    JSONGroup("data") {
        vipInfo
        userInfo
        locationInfo
    }
}

protocol JSONStringConvertible {
    func asString() -> String
}

extension JSON: JSONStringConvertible {
    
    func asString() -> String {
        var string = ""
        string.append("\(name): \(value.asString())")
        return string
    }
}

extension JSON.Value: JSONStringConvertible {
    
    func asString() -> String {
        switch self {
        case .bool(let value):
            return "\(value)"
        case .double(let value):
            return "\(value)"
        case .string(let value):
            return value
        case .int(let value):
            return "\(value)"
        case .group(let jsons):
            let result: [String] = jsons.compactMap{ "\t" + $0.asString() }
            return "\n" + result.joined(separator: ",\n")
        }
    }
}

extension JSONGroup: JSONStringConvertible {
    func asString() -> String {
        "\(name):\n" + self.jsons.map{
            "\t\($0.asString())"
        }.joined(separator: ",\n")
    }
}

let jsonGroup = JSONGroup("account") {
    JSON("name", .string("rocky"))
    JSON("age", .int(20))
}

let rockyInfo = JSONGroup("data") {
    jsonGroup
}

print(jsonGroup.asString())

extension Array: JSONStringConvertible where Element == JSON {
    func asString() -> String {
        self.compactMap{ $0.asString() }.joined(separator: ",\n")
    }
}

//print(json)
//print(json.asString())

//print(json_2.asString())
//print(json_3.asString())
//print(json_4.asString())
//


extension JSONBuilder {
    // swift 5.4的新特性
    static func buildArray(_ components: [JSONConvertible]) -> Component {
        components.flatMap{ $0.asJSON() }
    }
}

let array = [1,2,3,4]
let index = 1

let json_5 = JSONGroup("list") {
    
//    for index in array {
        [JSON("name", .string("index.\(index)")),
    JSON("name", .string("index.\(index)"))]
//    }
}

print(json_5.asString())

struct AccountController {
    
    let uid: Int
    init(uid: Int) {
        self.uid = uid
    }
    
    func fetchUserInfo() -> JSONGroup {
        JSONGroup("result") {
            code
            message
            data
        }
    }
}

fileprivate
extension AccountController {
    
    func checkUid() -> Bool {
        uid <= 10000
    }
    
    var code: JSONConvertible {
        JSON("code", .int(checkUid() ? 200 : 1309))// 1309: uis is illegal
    }
    
    var message: JSONConvertible {
        JSON("message", .string(checkUid() ? "success" : "uis is illegal"))
    }
    
    var data: JSONConvertible {
        JSONGroup("data") {
            if checkUid() {
                readAccountFromDatabase()
//                readLocationFromDatabase()
                // mock middle
                readVipInfo(vip: .middle)
            }
        }
    }
    
    func readAccountFromDatabase() -> JSONConvertible {
        // 省略一些逻辑
        JSONGroup("account") {
            JSON("name", .string("rocky"))
            JSON("uid", .int(uid))
            JSON("level", .int(233))
        }
    }
    
    func readLocationFromDatabase() -> JSONConvertible {
        // 省略一些逻辑
        JSONGroup("location") {
            JSON("coordinate", .group([
                JSON("longitude", .double(31.22)),
                JSON("latitude", .double(121.48))
            ]))
            JSON("detail", .string("China Shanghai huangpuqu R.renmin NO.56"))
            JSON("province", .string("Shanghai"))
            JSON("city", .string("huangpuqu"))
            JSON("country", .string("China"))
            JSON("street", .string("R.renmin NO.56"))
        }
    }
    
    func readVipInfo(vip: VIP) -> JSONConvertible {
        JSONGroup("vip") {
            switch vip {
            case .normal:
                JSON("level", .string(vip.rawValue))
            case .middle:
                JSON("level", .string(vip.rawValue))
            case .high:
                JSON("level", .string(vip.rawValue))
            }
        }
    }
    
    enum VIP: String {
        case normal
        case middle
        case high
    }
}

let accountController = AccountController(uid: 233)
print(accountController.fetchUserInfo().asString())

let accountController_2 = AccountController(uid: 10000)
print(accountController_2.fetchUserInfo())

