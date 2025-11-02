//
//  AlarmAPIClient.swift
//  MomentumCalendar
//
//  Communicates with the alarm app API to set notifications
//

import Foundation

enum AlarmAPIError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case serverError(Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid alarm API endpoint"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from alarm API"
        case .serverError(let code):
            return "Server error: HTTP \(code)"
        }
    }
}

/// Client for syncing alarms with the alarm app
class AlarmAPIClient {
    // TODO: Update this URL to your actual alarm API endpoint
    private let baseURL = "http://localhost:3000/api/alarms"

    /// Syncs all alarms for the given events
    func syncAlarms(for events: [Event]) async throws {
        print("🔔 AlarmAPIClient: Syncing \(events.count) events...")

        // Filter events that have alarm settings
        let eventsWithAlarms = events.filter { $0.alarmSettings != nil }

        print("🔔 Found \(eventsWithAlarms.count) events with alarms")

        // TODO: Implement actual API calls
        // For now, just log what would be sent
        for event in eventsWithAlarms {
            guard let alarmSettings = event.alarmSettings else { continue }

            let triggerTime = Calendar.current.date(
                byAdding: .minute,
                value: -alarmSettings.triggerMinutesBefore,
                to: event.startTime
            )

            print("""
                  📱 Would set alarm:
                     Title: \(event.title)
                     Trigger: \(triggerTime?.description ?? "unknown")
                     Type: \(alarmSettings.notificationType)
                  """)
        }

        // Simulate network delay
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds

        print("✅ AlarmAPIClient: Sync complete")
    }

    /// Clears all alarms (useful when loading new schedule)
    func clearAllAlarms() async throws {
        print("🗑️ AlarmAPIClient: Clearing all alarms...")

        // TODO: Implement actual API call to DELETE /api/alarms

        // Simulate network delay
        try await Task.sleep(nanoseconds: 300_000_000) // 0.3 seconds

        print("✅ AlarmAPIClient: All alarms cleared")
    }
}

// MARK: - API Models (for future implementation)

struct AlarmRequest: Codable {
    let eventId: String
    let title: String
    let triggerTime: Date
    let notificationType: String
}

struct AlarmResponse: Codable {
    let success: Bool
    let alarmId: String?
    let message: String?
}
