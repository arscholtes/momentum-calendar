//
//  Event.swift
//  MomentumCalendar
//
//  Agent-driven calendar for AuDHD productivity
//

import Foundation

/// Represents a single calendar event
struct Event: Codable, Identifiable {
    let id: UUID
    let title: String
    let startTime: Date
    let durationMinutes: Int
    let eventType: EventType
    let energyLevel: EnergyLevel?
    let alarmSettings: AlarmSettings?
    let notes: String?

    /// Computed end time based on start + duration
    var endTime: Date {
        Calendar.current.date(byAdding: .minute, value: durationMinutes, to: startTime) ?? startTime
    }

    /// Returns duration formatted as "1h 30m" or "45m"
    var formattedDuration: String {
        let hours = durationMinutes / 60
        let minutes = durationMinutes % 60

        if hours > 0 && minutes > 0 {
            return "\(hours)h \(minutes)m"
        } else if hours > 0 {
            return "\(hours)h"
        } else {
            return "\(minutes)m"
        }
    }
}

/// Energy level classification for events
enum EnergyLevel: String, Codable {
    case high
    case medium
    case low
    case rest

    var displayName: String {
        rawValue.capitalized
    }
}
