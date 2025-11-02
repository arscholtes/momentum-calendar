//
//  WeekViewModel.swift
//  MomentumCalendar
//
//  Manages state and business logic for the calendar
//

import Foundation
import SwiftUI
import Combine

/// Main view model for the calendar - connects Services to Views
@MainActor
class WeekViewModel: ObservableObject {
    // MARK: - Published State (Views observe these)
    @Published var currentWeek: Week?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var lastUpdated: Date?

    // MARK: - Services
    private let fileManager = ScheduleFileManager.self
    private let alarmClient = AlarmAPIClient()
    private var fileWatcher: FileWatcher?

    // MARK: - Configuration
    private let scheduleFilePath = ScheduleFileManager.defaultSchedulePath

    // MARK: - Initialization
    init() {
        setupFileWatcher()
        loadSchedule()
    }

    // MARK: - File Watching
    private func setupFileWatcher() {
        fileWatcher = FileWatcher(fileURL: scheduleFilePath) { [weak self] in
            Task { @MainActor in
                print("📁 Schedule file changed - reloading...")
                self?.loadSchedule()
            }
        }
        fileWatcher?.startWatching()
    }

    // MARK: - Schedule Loading
    func loadSchedule() {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                // Load schedule from file
                let week = try fileManager.loadSchedule(from: scheduleFilePath)

                // Update state
                self.currentWeek = week
                self.lastUpdated = Date()
                self.errorMessage = nil

                print("✅ Loaded schedule with \(week.events.count) events")
                print("📅 Week: \(week.weekStartDate) to \(week.weekEndDate)")

                // Sync alarms in background
                Task {
                    do {
                        try await alarmClient.syncAlarms(for: week.events)
                    } catch {
                        print("⚠️ Alarm sync failed: \(error.localizedDescription)")
                        // Don't show error to user - alarms are secondary
                    }
                }

            } catch {
                self.errorMessage = error.localizedDescription
                print("❌ Load failed: \(error.localizedDescription)")
            }

            self.isLoading = false
        }
    }

    // MARK: - Manual Refresh
    func refresh() {
        print("🔄 Manual refresh triggered")
        loadSchedule()
    }

    // MARK: - Helper Methods
    func events(for day: Date) -> [Event] {
        guard let week = currentWeek else { return [] }

        let calendar = Calendar.current
        let dayStart = calendar.startOfDay(for: day)

        return week.events.filter { event in
            calendar.isDate(event.startTime, inSameDayAs: dayStart)
        }.sorted { $0.startTime < $1.startTime }
    }
}
