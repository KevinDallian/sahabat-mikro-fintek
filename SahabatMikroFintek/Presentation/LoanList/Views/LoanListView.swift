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
                                SortModalView(vm: vm)
                                    .presentationCompactAdaptation(.popover)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LoanListView()
}
