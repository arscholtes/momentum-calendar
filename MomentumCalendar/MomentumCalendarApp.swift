//
//  MomentumCalendarApp.swift
//  MomentumCalendar
//
//  Main app entry point - Agent-driven calendar for AuDHD productivity
//  Created by Alex Scholtes on 11/2/25.
//

import SwiftUI

@main
struct MomentumCalendarApp: App {
    var body: some Scene {
        WindowGroup {
            WeekView()
        }
        .windowStyle(.hiddenTitleBar)
        .commands {
            // Add menu commands
            CommandGroup(replacing: .newItem) {}
        }
    }
}
