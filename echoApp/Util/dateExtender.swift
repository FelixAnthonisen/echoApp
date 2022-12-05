//
//  dateExtender.swift
//  echoApp
//
//  Created by Felix Anthonisen on 05/12/2022.
//

import Foundation

// https://stackoverflow.com/questions/24089999/how-do-you-create-a-swift-date-object
extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
}
