//
//  LoanDetailViewModel.swift
//  SahabatMikroFintek
//
//  Created by Kevin Dallian on 22/06/24.
//

import Foundation

class LoanDetailViewModel : ObservableObject {
    @Published var loan : Loan
    
    init(loan: Loan) {
        self.loan = loan
    }
    
    func generateLinkEndpoint(urlString: String) -> URL? {
        guard let apiURL = Bundle.main.infoDictionary?["API_URL"] as? String else {
            return nil
        }
        return URL(string: "https://\(apiURL)\(urlString)") ?? nil
    }
}
