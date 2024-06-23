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
            Section("Filter By"){
                Button {
                    vm.sortOption = .amount
                    dismiss()
                } label: {
                    SortComponent(title: "Amount", checked: vm.sortOption == .amount)
                }
                Button {
                    vm.sortOption = .term
                    dismiss()
                } label: {
                    SortComponent(title: "Term", checked: vm.sortOption == .term)
                }
                Button {
                    vm.sortOption = .purpose
                    dismiss()
                } label: {
                    SortComponent(title: "Purpose", checked: vm.sortOption == .purpose)
                }
            }
            Section("Sort By") {
                Button{
                    vm.sortIsAscending = true
                    dismiss()
                } label: {
                    SortComponent(title: "Ascending", checked: vm.sortIsAscending)
                }
                Button{
                    vm.sortIsAscending = false
                    dismiss()
                } label: {
                    SortComponent(title: "Descending", checked: !vm.sortIsAscending)
                }
            }
        }
        .frame(width: 220, height: 200)
        .listStyle(.plain)
    }
}
