//
//  ListingView.swift
//  SampleNavigation
//
//  Created by Tatiredd.reddy on 30/10/24.
//

import SwiftUI

enum ListingDestination: Hashable {
    case yourListing
    case postDetails(value: String)
}

struct ListingView: View {
    @EnvironmentObject var router: Router
    var body: some View {
        List {
            HStack {
                Button("Next") {
                    router.navigate(to: ListingDestination.yourListing)
                }
            }
            
            HStack {
                Button("Details") {
                    router.navigate(to: ListingDestination.postDetails(value: "from listing"))
                }
            }
        }.listStyle(.plain)
        .navigationDestination(for: ListingDestination.self) { destination in
            switch destination {
            case .yourListing:
                MyListing().environmentObject(router)
            case .postDetails(let pass):
                PostDetailsView(pass: pass).environmentObject(router)
            }
        }
    }
}
