//
//  RecordDetail.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/9.
//

import SwiftUI

private struct RecordRowHeightKey: EnvironmentKey {
    static let defaultValue: CGFloat = 40
}
extension EnvironmentValues {
    var recordRowHeight: CGFloat {
        get { self[RecordRowHeightKey.self] }
        set { self[RecordRowHeightKey.self] = newValue }
    }
}

enum RemindType: Int, Identifiable, CaseIterable {
    
    case beforeThreeDay = 0
    case thePreviousDay = 1
    case theDay = 2

    var id: Int { self.rawValue }
    
    var text: String {
        switch self {
        case .beforeThreeDay:
            return "Before three day"
        case .thePreviousDay:
            return "The previous day"
        case .theDay:
            return "The day"
        }
    }
}
struct RecordDetail: View {
    
    @State private var name: String = ""
    @State private var billDate: Int = 2
    @State private var dueDate: Int = 20
    @State private var needRemind: Bool = false
    @State private var remindType: RemindType = .theDay
    
    @Environment(\.recordRowHeight) private var rowHeight: CGFloat

    var body: some View {
        
        NavigationView{
            
            Form{
                
                basicSection
                
                remindSection
                
                confirmButton
            }
            .navigationTitle(name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var basicSection: some View {
        Section{

            RecordInputTextView(
                "Name",
                placehold: "Input your record name",
                text: $name
            )
            .frame(height: rowHeight)
            
            RecordDatePickerView(
                text: "Bill date",
                selected: $billDate
            )
            
            RecordDatePickerView(
                text: "Due date",
                selected: $dueDate
            )
        }
    }
    
    private var remindSection: some View {
        Section{
            
            Group{
            
                Toggle(isOn: $needRemind) {
                    Text("Remind")
                }

                Picker(
                    "Type",
                    selection: $remindType
                ) {
                    ForEach(RemindType.allCases) {
                        Text("\($0.text)")
                            .tag($0)
                    }
                }
                .isVisible(needRemind)
            }
            .frame(height: rowHeight)
        }
    }
    
    private var confirmButton: some View {
        
        GeometryReader{ proxy in
            
            Button("Confirm", action: onConfirm)
                .foregroundColor(.red)
                .frame(width: proxy.size.width, height: proxy.size.height)
                .listRowInsets(.none)
        }
    }
    
    private func onConfirm() {
        print("name:\(name),bill date:\(billDate),due date:\(dueDate),needRemind:\(needRemind),remindType:\(remindType)")
    }
}

struct RecordDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecordDetail()
    }
}

extension View {
    
    func isVisible(_ visible: Bool) -> AnyView {
        if visible {
            return AnyView(self)
        }
        return AnyView(EmptyView())
    }
}

