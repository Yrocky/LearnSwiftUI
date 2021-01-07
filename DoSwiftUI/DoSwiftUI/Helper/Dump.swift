//
//  Dump.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/5.
//

import Foundation
import SwiftUI

extension View {
    
    func dump() -> Self {
        print(Mirror(reflecting: self))
        return self
    }
}
