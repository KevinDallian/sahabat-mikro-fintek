//
//  LoanDetailView.swift
//  SahabatMikroFintek
//
//  Created by Kevin Dallian on 22/06/24.
//

import SwiftUI

struct LoanDetailView: View {
    @StateObject var vm : LoanDetailViewModel
    var body: some View {
        List {
            Section("Loan Detail") {
                Text("Email: \(vm.loan.borrower.email)")
                Text("Credit Score : \(vm.loan.borrower.creditScore)")
            }
            Section("Collateral Type") {
                Text("\(vm.loan.collateral.type)")
            }
            Section("Repayment Schedule"){
                ForEach(vm.loan.repaymentSchedule.installments, id: \.dueDate) { installment in
                    HStack {
                        Text("\(installment.amountDue) at")
                        Text("\(installment.dueDate)")
                    }
                }
            }
            Section("Documents") {
                if vm.loan.documents.isEmpty {
                    Text("No Documents")
                } else {
                    ForEach(vm.loan.documents, id: \.self) { document in
                        NavigationLink {
                            DocumentDetailView(urlString: vm.generateLinkEndpoint(urlString: document.url))
                        } label: {
                            Text(document.type)
                        }

                    }
                }
            }
        }
        .navigationTitle(vm.loan.borrower.name)
    }
}

#Preview {
    LoanDetailView(vm: LoanDetailViewModel(loan: Loan.mockData))
}
