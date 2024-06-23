//
//  DateFormatter.swift
//  SahabatMikroFintek
//
//  Created by Kevin Dallian on 23/06/24.
//

import Foundation

func stringToDate(_ dateString : String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: dateString)!
}
