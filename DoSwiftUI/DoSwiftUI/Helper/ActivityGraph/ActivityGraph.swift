//
//  ActivityGraph.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/20.
//

import SwiftUI

struct ActivityGraph: View {
    
    private var logs: [ActivityLog]
    @Binding private var selectedIndex: Int
    
    init(logs: [ActivityLog], selectedIndex: Binding<Int>) {
        self._selectedIndex = selectedIndex
        let current = Date()
        let sortedLogs = logs.sorted { $0.date > $1.date }
        
        var margedLogs: [ActivityLog] = []
        for i in 0..<12 {
            var weekLog: ActivityLog = ActivityLog(distance: 0, duration: 0, elevation: 0, date: Date())
            for log in sortedLogs {
                weekLog.distance += log.distance
                weekLog.duration += log.duration
                weekLog.elevation += log.elevation
            }
            margedLogs.insert(weekLog, at: 0)
        }
        self.logs = margedLogs
    }
    
    var body: some View {
        drawGrid()
    }
    
    func drawGrid() -> some View {
        VStack(spacing: 0) {
            Color.black.frame(height: 1, alignment: .center)
            HStack(spacing: 0) {
                Color.clear
                    .frame(width: 8, height: 100)
                ForEach(0..<11) { i in
                    Color.black.frame(width: 1, height: 100, alignment: .center)
                    Spacer()

                }
                Color.black.frame(width: 1, height: 100, alignment: .center)
                Color.clear
                    .frame(width: 8, height: 100)
            }
            Color.black.frame(height: 1, alignment: .center)
        }
    }
}

//struct ActivityGraph_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityGraph()
//    }
//}
