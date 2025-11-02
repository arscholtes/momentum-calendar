//
//  FileWatcher.swift
//  MomentumCalendar
//
//  Monitors schedule file for changes and triggers reload
//

import Foundation

/// Watches a file for changes and calls handler when modified
class FileWatcher {
    private var fileDescriptor: Int32 = -1
    private var source: DispatchSourceFileSystemObject?
    private let fileURL: URL
    private let onChange: () -> Void

    init(fileURL: URL, onChange: @escaping () -> Void) {
        self.fileURL = fileURL
        self.onChange = onChange
    }

    /// Start watching the file
    func startWatching() {
        // Open file descriptor
        fileDescriptor = open(fileURL.path, O_EVTONLY)
        guard fileDescriptor != -1 else {
            print("⚠️ FileWatcher: Could not open file at \(fileURL.path)")
            return
        }

        // Create dispatch source
        source = DispatchSource.makeFileSystemObjectSource(
            fileDescriptor: fileDescriptor,
            eventMask: [.write, .delete, .rename],
            queue: DispatchQueue.global(qos: .background)
        )

        // Set event handler
        source?.setEventHandler { [weak self] in
            self?.onChange()
        }

        // Set cancel handler to close file descriptor
        source?.setCancelHandler { [weak self] in
            guard let fd = self?.fileDescriptor else { return }
            close(fd)
        }

        // Start monitoring
        source?.resume()
        print("👀 FileWatcher: Monitoring \(fileURL.lastPathComponent)")
    }

    /// Stop watching the file
    func stopWatching() {
        source?.cancel()
        source = nil
        print("🛑 FileWatcher: Stopped monitoring")
    }

    deinit {
        stopWatching()
    }
}
