//
//  LoanDetailViewModel.swift
//  SahabatMikroFintek
//
//  Created by Kevin Dallian on 22/06/24.
//

import Foundation

class LoanDetailViewModel : ObservableObject {
    @Published var loan : Loan
    let endpoint = "https://raw.githubusercontent.com/andreascandle/p2p_json_test/main"
    
    init(loan: Loan) {
        self.loan = loan
    }
    
    func generateLinkEndpoint(urlString: String) -> URL? {
        return URL(string: "\(endpoint)\(urlString)") ?? nil
    }
}
