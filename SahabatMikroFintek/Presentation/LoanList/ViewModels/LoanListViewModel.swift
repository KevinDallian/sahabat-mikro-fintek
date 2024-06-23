//
//  LoanListViewModel.swift
//  SahabatMikroFintek
//
//  Created by Kevin Dallian on 22/06/24.
//

import Combine
import Foundation

class LoanListViewModel : ObservableObject {
    @Published var loans : [Loan] = []
    @Published var isLoading : Bool = true
    @Published var searchText : String = ""
    @Published var showModal = false
    @Published var sortOption : SortOption = .amount
    @Published var sortIsAscending : Bool = false
    
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
        let sortedResults : [Loan]
        switch sortOption {
        case .amount:
            sortedResults = searchResults.sorted { sortIsAscending ? $0.amount < $1.amount : $0.amount > $1.amount }
        case .term:
            sortedResults = searchResults.sorted { sortIsAscending ? $0.term < $1.term : $0.term > $1.term }
        case .purpose:
            sortedResults = searchResults.sorted { sortIsAscending ? $0.purpose < $1.purpose : $0.purpose > $1.purpose }
        }
        return sortedResults
    }
    
    func fetchLoanData() async {
        guard let apiURL = Bundle.main.infoDictionary?["API_URL"] as? String else {
            return
        }
        
        guard let url = URL(string: "https://\(apiURL)/api/json/loans.json") else {
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
