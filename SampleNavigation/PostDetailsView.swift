//
//  PostDetailsView.swift
//  SampleNavigation
//
//  Created by Tatiredd.reddy on 30/10/24.
//

import SwiftUI

struct PostDetailsView: View {
    let pass: String
    var body: some View {
        VStack {
            Text("Post Details")
            Text(pass)
        }
    }
}
