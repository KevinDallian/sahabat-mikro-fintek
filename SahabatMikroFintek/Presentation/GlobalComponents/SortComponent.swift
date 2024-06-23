//
//  SortComponent.swift
//  SahabatMikroFintek
//
//  Created by Kevin Dallian on 23/06/24.
//

import SwiftUI

struct SortComponent: View {
    var title : String
    var checked : Bool
    var body: some View {
        HStack{
            Text(title)
            if checked {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 15, height: 12)
                    .foregroundStyle(.blue)
            }
        }
    }
}

#Preview {
    SortComponent(title: "Amount", checked: true)
}
