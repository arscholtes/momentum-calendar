//
//  AlarmSettings.swift
//  MomentumCalendar
//
//  Agent-driven calendar for AuDHD productivity
//

import Foundation

/// Configuration for event alarms/notifications
struct AlarmSettings: Codable, Equatable {
    let triggerMinutesBefore: Int
    let notificationType: String  // "gentle", "urgent", "none"

    /// Valid notification types
    static let validNotificationTypes = ["gentle", "urgent", "none"]

    /// Valid minute ranges (5 minutes to 2 hours before)
    static let validMinuteRange = 5...120
}
