//
//  SearchbarView.swift
//  NasaMediaSearch-SwiftUI
//
//  Created by Joshua Homann on 7/4/20.
//

import SwiftUI

struct SearchBar: View {
  @Binding var searchTerm: String
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Image(systemName: "magnifyingglass.circle")
          .foregroundColor(.gray)
        TextField("Search...", text: $searchTerm)
          .padding()
        Button {
          searchTerm = ""
        } label: {
          Image(systemName: "xmark.circle.fill")
        }
        .accentColor(.black)
      }
      .padding(.horizontal, 9.0)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color.gray, lineWidth: 1)
      )
    }
  }
}
