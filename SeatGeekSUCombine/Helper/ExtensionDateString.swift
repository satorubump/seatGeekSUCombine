//
//  ExtensionDateString.swift
//  SeatGeekSUCombine
//
//  Created by Satoru Ishii on 5/13/21.
//

import Foundation

extension String {
    func eventDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: self) else {  return ""   }
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEE, d MMM yyyy h:mm a", options: 0, locale: Locale.current)
        return dateFormatter.string(from: date)
    }
}
