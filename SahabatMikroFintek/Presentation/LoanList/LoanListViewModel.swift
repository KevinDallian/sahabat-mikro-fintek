//
//  LoanListViewModel.swift
//  SahabatMikroFintek
//
//  Created by Kevin Dallian on 22/06/24.
//

import Combine
import Foundation

class LoanListViewModel : ObservableObject {
    let endpoint = "https://raw.githubusercontent.com/andreascandle/p2p_json_test/main/api/json/loans.json"
    @Published var loans : [Loan] = []
    @Published var isLoading : Bool = true
    @Published var searchText : String = ""
    @Published var showModal = false
    @Published var sortOption : SortOption = .amount
    
    enum SortOption : String {
        case amount = "Amount", term = "Term", purpose = "Purpose"
    }
    
    private var cancellable: AnyCancellable?
    
    var searchResults : [Loan] {
        if searchText.isEmpty {
            return loans
        } else {
            return loans.filter({$0.borrower.name.contains(searchText)})
        }
    }
    
    var sortResults : [Loan] {
        switch sortOption {
        case .amount:
            return searchResults.sorted{ $0.amount > $1.amount }
        case .term:
            return searchResults.sorted{ $0.term > $1.term }
        case .purpose:
            return searchResults.sorted{ $0.purpose > $1.purpose }
        }
    }
    
    func fetchLoanData() async {
        guard let url = URL(string: endpoint) else {
            return
        }
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: [Loan].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    print("Error fetching loan list data : \(error.localizedDescription)")
                    self.isLoading = false
                }
            }, receiveValue: { loans in
                self.loans = loans
            })
    }
}
