//
//  SearchView.swift
//  NasaMediaSearch-SwiftUI
//
//  Created by Joshua Homann on 7/4/20.
//

import SwiftUI

struct SearchView: View {
  @ObservedObject var viewModel: SearchViewModel
  var body: some View {
    VStack {
      SearchBar(searchTerm: $viewModel.searchTerm)
        .font(.title)
        .padding()
      List {
        ForEach(viewModel.searchItems) { searchItem in
          Section(header: Text(searchItem.title)) {
            if let children = searchItem.children {
              OutlineGroup(children, children: \.children) { item in
                Label(title: {
                  Text(item.title)
                }, icon: {
                  Image(systemName: "magnifyingglass.circle.fill")
                })
                .font(.title2)
                .onTapGesture {
                  viewModel.searchTerm = item.title
                }
              }
            }
          }
          .font(.title)
        }
      }
    }
  }
}
