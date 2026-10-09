//
//  ElapsedTimeView.swift
//  CodeBreaker
//
//  Created by Elliot Hannah III on 10/9/26.
//

import SwiftUI

struct ElapsedTimeView: View {
    let startTime: Date
    let endTime: Date?
    
    var body: some View {
        if let endTime {
            Text(endTime, format: .offset(to: startTime, allowedFields: [.minute, .second]))
        } else {
            Text(TimeDataSource<Date>.currentDate, format: .offset(to: startTime, allowedFields: [.minute, .second]))
        }
        // TimeDataSource<T>.currentDate is a data source for the current time; this is redrawing the Text View every second, not the entire body of ElapsedTimeView
        // Allows the ticking to occur
        
    }
}

//#Preview {
//    ElapsedTimeView()
//}
