//
//  DocumentDetailView.swift
//  SahabatMikroFintek
//
//  Created by Kevin Dallian on 23/06/24.
//

import SwiftUI

struct DocumentDetailView: View {
    @State var urlString : URL?
    var body: some View {
        if let url = urlString {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure(let error):
                    Text("Error fetching image for url : \(error.localizedDescription)")
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            Text("No documents to show")
        }
    }
}

#Preview {
    DocumentDetailView(urlString: URL(string: "") ?? nil)
}
