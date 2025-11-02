//
//  TimeAxisView.swift
//  MomentumCalendar
//
//  Displays time labels (6am-11pm) on left side of calendar
//

import SwiftUI

struct TimeAxisView: View {
    let startHour = 6    // 6 AM
    let endHour = 23     // 11 PM
    let hourHeight: CGFloat = 60  // Height per hour in points

    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            ForEach(startHour...endHour, id: \.self) { hour in
                Text(formatHour(hour))
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(height: hourHeight, alignment: .top)
                    .padding(.trailing, 8)
            }
        }
        .frame(width: 60)
    }

    private func formatHour(_ hour: Int) -> String {
        let period = hour < 12 ? "AM" : "PM"
        let displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour)
        return "\(displayHour) \(period)"
    }
}

#Preview {
    TimeAxisView()
}
