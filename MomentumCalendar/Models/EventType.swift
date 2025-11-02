//
//  EventType.swift
//  MomentumCalendar
//
//  Agent-driven calendar for AuDHD productivity
//

import Foundation

/// Categorizes events by their nature and energy requirements
enum EventType: String, Codable, CaseIterable {
    case workout
    case study
    case work
    case recovery
    case buffer
    case social
    case other

    /// Human-readable display name
    var displayName: String {
        switch self {
        case .workout: return "Workout"
        case .study: return "Study"
        case .work: return "Work"
        case .recovery: return "Recovery"
        case .buffer: return "Buffer"
        case .social: return "Social"
        case .other: return "Other"
        }
    }
}
