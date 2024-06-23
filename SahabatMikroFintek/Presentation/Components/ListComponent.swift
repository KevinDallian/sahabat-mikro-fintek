//
//  ListComponent.swift
//  SahabatMikroFintek
//
//  Created by Kevin Dallian on 22/06/24.
//

import SwiftUI

struct ListComponent: View {
    @State var loan : Loan
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("\(loan.borrower.name)")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("\(loan.purpose)")
                Text("\(loan.termInMonths()) Months")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
            }
            Spacer()
            VStack(alignment: .trailing){
                Text("\(loan.amount.formatted(.currency(code: "USD")))")
                Text("\(loan.interestRate.formatted(.percent.rounded()))")
                Text("**\(loan.riskRating)** Rating")
            }
        }
    }
}

#Preview {
    ListComponent(loan: Loan.mockData)
}
