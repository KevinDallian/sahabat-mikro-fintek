//
//  Document.swift
//  SahabatMikroFintek
//
//  Created by Kevin Dallian on 22/06/24.
//

import Foundation

struct Document : Codable, Hashable {
    let type : String
    let url : String
}

//"documents": [
//  {
//    "type": "Income Statement",
//    "url": "/loans/documents/income_statement/slip-gaji-karyawan-pertamina.jpeg"
//  }
//],
