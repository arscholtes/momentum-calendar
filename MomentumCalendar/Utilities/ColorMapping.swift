//
//  ColorMapping.swift
//  MomentumCalendar

import SwiftUI

/// Maps EventType to a SwiftUI Color for visual display
func colorForEventType(_ eventType: EventType) -> Color {

    switch eventType {
    case .workout:
        return Color.blue.opacity(0.7)
    case .study:
        return Color.green.opacity(0.7)
    case .work:
        return Color.red.opacity(0.7)
    case .recovery:
        return Color.purple.opacity(0.7)
    case .buffer:
        return Color.gray.opacity(0.7)
    case .social:
        return Color.orange.opacity(0.7)
    case .other:
        return Color.gray.opacity(0.7)
    }
}

extension EventType {
    /// Convenience property for getting color directly from EventType
    var color: Color {
        colorForEventType(self)
    }
}

