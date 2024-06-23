//
//  SortModalView.swift
//  SahabatMikroFintek
//
//  Created by Kevin Dallian on 23/06/24.
//

import SwiftUI

struct SortModalView: View {
    @ObservedObject var vm : LoanListViewModel
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        List{
            Button {
                vm.sortOption = .amount
                dismiss()
            } label: {
                Text("Amount")
            }
            Button {
                vm.sortOption = .term
                dismiss()
            } label: {
                Text("Term")
            }
            Button {
                vm.sortOption = .purpose
                dismiss()
            } label: {
                Text("Purpose")
            }
        }
        .frame(width: 150, height: 120)
        .listStyle(.plain)
    }
}
