//
//  ContentView.swift
//  Shared
//
//  Created by Joshua Homann on 6/26/20.
//

import Combine
import SwiftUI

enum LoadingState<Content> {
  case loading, loaded(Content), error(Error), empty
}

struct LoadingView: View {
  @StateObject private var viewModel = SearchViewModel()
  @State private var isPresented = false
  @State private var detailItem: Item?
  var body: some View {
    NavigationView {
      VStack {
        SearchView(viewModel: viewModel)
      }
      .navigationTitle("Nasa")
      VStack {
        switch viewModel.searchResult {
        case .loading:
          PlaceholderView(icon: .loading, text: "Loading...")
        case .error:
          PlaceholderView(icon: .image(name:"xmark.octagon"), text: "Something went wrong")
        case .empty:
          viewModel.searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            ? PlaceholderView(icon: .image(name:"magnifyingglass.circle"), text: "Type a Search above")
            : PlaceholderView(icon: .image(name:"exclamationmark.arrow.triangle.2.circlepath"), text: "No results found")
        case let .loaded(items):
          SearchResultsView(
            items: items,
            selectedItem: .init(
              get: { detailItem },
              set: {
                detailItem = $0
                isPresented = true
              }
            )
          )
        }
      }
      .navigationBarHidden(true)
      .fullScreenCover(isPresented: $isPresented) {
        MediaDetailView(isPresented: $isPresented, item: detailItem)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    LoadingView()
  }
}
