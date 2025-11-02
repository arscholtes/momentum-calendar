//
//  WeekView.swift
//  MomentumCalendar
//
//  Main calendar view - displays full week with all days
//

import SwiftUI

struct WeekView: View {
    @StateObject private var viewModel = WeekViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // Header with title and controls
            headerView

            Divider()

            // Main calendar grid
            if viewModel.isLoading {
                loadingView
            } else if let errorMessage = viewModel.errorMessage {
                errorView(message: errorMessage)
            } else if let week = viewModel.currentWeek {
                calendarGrid(week: week)
            } else {
                emptyStateView
            }
        }
        .frame(minWidth: 1200, minHeight: 800)
    }

    // MARK: - Header
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Momentum Calendar")
                    .font(.title)
                    .fontWeight(.bold)

                if let lastUpdated = viewModel.lastUpdated {
                    Text("Last updated: \(lastUpdated.timeString())")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            Button(action: {
                viewModel.refresh()
            }) {
                Label("Refresh", systemImage: "arrow.clockwise")
            }
            .disabled(viewModel.isLoading)
        }
        .padding()
    }

    // MARK: - Calendar Grid
    private func calendarGrid(week: Week) -> some View {
        ScrollView {
            HStack(alignment: .top, spacing: 0) {
                // Time axis on left
                TimeAxisView()

                // 7 day columns (Mon-Sun)
                HStack(spacing: 8) {
                    ForEach(week.weekDays(), id: \.self) { day in
                        let dayEvents = viewModel.events(for: day)
                        DayColumnView(day: day, events: dayEvents)
                    }
                }
                .padding(.horizontal, 8)
            }
            .padding()
        }
    }

    // MARK: - States
    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading schedule...")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func errorView(message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(.orange)

            Text("Error Loading Schedule")
                .font(.headline)

            Text(message)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("Try Again") {
                viewModel.refresh()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "calendar.badge.clock")
                .font(.system(size: 48))
                .foregroundColor(.blue)

            Text("No Schedule Found")
                .font(.headline)

            Text("Generate a schedule using the agent to get started.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            Text("Schedule file location:\n~/CalendarSchedules/current-schedule.json")
                .font(.caption)
                .foregroundColor(.tertiary)
                .multilineTextAlignment(.center)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

// MARK: - Preview
#Preview {
    WeekView()
}
