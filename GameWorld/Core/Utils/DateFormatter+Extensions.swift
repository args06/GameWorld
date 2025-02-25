//
//  DateFormatter+Extensions.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation

extension DateFormatter {

    static var formatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
}

extension String {
    func toDate(dateFormat: DateFormatter.Style) -> Date {
        let formatter = DateFormatter.formatter

        guard let date = formatter.date(from: self) else {
            return Date()
        }

        return date
    }

    func formatDate(dateFormat: DateFormatter.Style) -> String {
        let formatter = DateFormatter.formatter
        guard let date = formatter.date(from: self) else {
            return self
        }

        return date.toString(dateFormat: dateFormat)
    }
}

extension Date {
    func toString(dateFormat: DateFormatter.Style) -> String {
        let formatter = DateFormatter.formatter
        formatter.dateStyle = dateFormat
        return formatter.string(from: self)
    }
}
