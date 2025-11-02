//
//  ScheduleFileManager.swift
//  MomentumCalendar
//
//  Handles loading and parsing schedule JSON files
//

import Foundation

enum ScheduleFileError: Error, LocalizedError {
    case fileNotFound
    case invalidJSON
    case decodingFailed(Error)

    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Schedule file not found. Have you generated a schedule yet?"
        case .invalidJSON:
            return "Schedule file is not valid JSON"
        case .decodingFailed(let error):
            return "Failed to parse schedule: \(error.localizedDescription)"
        }
    }
}

/// Manages reading and parsing schedule files
class ScheduleFileManager {
    /// Default location for current schedule
    static let defaultSchedulePath = FileManager.default.homeDirectoryForCurrentUser
        .appendingPathComponent("CalendarSchedules")
        .appendingPathComponent("current-schedule.json")

    /// Loads a Week from the specified file path
    static func loadSchedule(from path: URL = defaultSchedulePath) throws -> Week {
        // Check if file exists
        guard FileManager.default.fileExists(atPath: path.path) else {
            throw ScheduleFileError.fileNotFound
        }

        // Read file data
        let data = try Data(contentsOf: path)

        // Configure JSON decoder for ISO8601 dates
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        // Decode to Week model
        do {
            let week = try decoder.decode(Week.self, from: data)
            return week
        } catch {
            throw ScheduleFileError.decodingFailed(error)
        }
    }

    /// Archives current schedule to dated file
    static func archiveSchedule(week: Week, archiveDirectory: URL? = nil) throws {
        let archiveDir = archiveDirectory ?? FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("CalendarSchedules")
            .appendingPathComponent("archive")

        // Create archive directory if needed
        try FileManager.default.createDirectory(at: archiveDir, withIntermediateDirectories: true)

        // Format filename as YYYY-Wxx.json
        let calendar = Calendar.current
        let weekNumber = calendar.component(.weekOfYear, from: week.weekStartDate)
        let year = calendar.component(.year, from: week.weekStartDate)
        let filename = "\(year)-W\(String(format: "%02d", weekNumber)).json"

        let archivePath = archiveDir.appendingPathComponent(filename)

        // Encode and write
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        let data = try encoder.encode(week)
        try data.write(to: archivePath)
    }
}
