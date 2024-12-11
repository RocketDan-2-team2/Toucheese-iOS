//
//  StudioHoursEntity.swift
//  Toucheese
//
//  Created by 유지호 on 12/11/24.
//

import Foundation

struct StudioHoursEntity: Decodable, Identifiable {
    let id: Int
    let wekkOfMonth: Int?
    let dayOfWeek: String
    let openTime: String
    let closeTime: String
    let breakStartTime: String?
    let breakEndTime: String?
    let holiday: Bool
    
    static let mockData: [StudioHoursEntity] = [
        .init(
            id: 1,
            wekkOfMonth: nil,
            dayOfWeek: "SUNDAY",
            openTime: "13:30:00",
            closeTime: "20:00:00",
            breakStartTime: nil,
            breakEndTime: nil,
            holiday: true
        ),
        .init(
            id: 2,
            wekkOfMonth: nil,
            dayOfWeek: "MONDAY",
            openTime: "13:30:00",
            closeTime: "20:00:00",
            breakStartTime: nil,
            breakEndTime: nil,
            holiday: false
        ),
        .init(
            id: 3,
            wekkOfMonth: nil,
            dayOfWeek: "TUESDAY",
            openTime: "13:30:00",
            closeTime: "20:00:00",
            breakStartTime: nil,
            breakEndTime: nil,
            holiday: false
        ),
        .init(
            id: 4,
            wekkOfMonth: nil,
            dayOfWeek: "WEDNESDAY",
            openTime: "13:30:00",
            closeTime: "20:00:00",
            breakStartTime: nil,
            breakEndTime: nil,
            holiday: false
        ),
        .init(
            id: 5,
            wekkOfMonth: nil,
            dayOfWeek: "THURSDAY",
            openTime: "13:30:00",
            closeTime: "20:00:00",
            breakStartTime: nil,
            breakEndTime: nil,
            holiday: false
        ),
        .init(
            id: 6,
            wekkOfMonth: nil,
            dayOfWeek: "FRIDAY",
            openTime: "13:30:00",
            closeTime: "20:00:00",
            breakStartTime: nil,
            breakEndTime: nil,
            holiday: false
        ),
        .init(
            id: 7,
            wekkOfMonth: nil,
            dayOfWeek: "SATURDAY",
            openTime: "13:30:00",
            closeTime: "20:00:00",
            breakStartTime: nil,
            breakEndTime: nil,
            holiday: true
        )
    ]
}
