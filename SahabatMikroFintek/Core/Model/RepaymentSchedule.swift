//
//  RepaymentSchedule.swift
//  SahabatMikroFintek
//
//  Created by Kevin Dallian on 22/06/24.
//

import Foundation

struct RepaymentSchedule : Codable {
    let installments : [Installment]
}

struct Installment : Codable {
    let dueDate : String
    let amountDue : Int
}

//"repaymentSchedule": {
//  "installments": [
//    {
//      "dueDate": "2023-01-15",
//      "amountDue": 500
//    },
//    {
//      "dueDate": "2023-02-15",
//      "amountDue": 500
//    }
//  ]
//}
