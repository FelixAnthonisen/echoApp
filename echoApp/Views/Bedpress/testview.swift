//
//  testview.swift
//  echoApp
//
//  Created by Felix Anthonisen on 05/12/2022.
//

/*extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
}
*/
import SwiftUI

struct testview: View {
    var body: some View {
        //Text(Date("2022-03-24T15:15:00.000Z"))
        
        Text(Date("2022-03-24").ISO8601Format())
        //Text("\(Date.now.ISO8601Format())")
    }
}

struct testview_Previews: PreviewProvider {
    static var previews: some View {
        testview()
    }
}
