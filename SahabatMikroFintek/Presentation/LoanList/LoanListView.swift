//
//  LoanListView.swift
//  SahabatMikroFintek
//
//  Created by Kevin Dallian on 22/06/24.
//

import SwiftUI

struct LoanListView: View {
    @StateObject var vm = LoanListViewModel()
    
    var body: some View {
        if vm.isLoading {
            ProgressView()
                .onAppear(perform: {
                    Task{
                        await vm.fetchLoanData()
                    }
                })
        } else {
            NavigationStack {
                List{
                    if vm.sortResults.isEmpty {
                        Text("No Loan to be shown")
                    } else {
                        ForEach(vm.sortResults, id: \.id) { loan in
                            NavigationLink {
                                LoanDetailView(vm: LoanDetailViewModel(loan: loan))
                            } label: {
                                ListComponent(loan: loan)
                            }
                        }
                    }
                }
                .searchable(text: $vm.searchText, prompt: "Search Borrower's Name")
                .navigationTitle("Loan List")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack{
                            Text("Sort By:\(vm.sortOption.rawValue)")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            Button {
                                vm.showModal.toggle()
                            } label: {
                                Image(systemName: "line.3.horizontal.decrease.circle")
                            }
                            .popover(isPresented: $vm.showModal) {
                                ModalView(vm: vm)
                                    .presentationCompactAdaptation(.popover)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ModalView: View {
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

#Preview {
    LoanListView()
}
