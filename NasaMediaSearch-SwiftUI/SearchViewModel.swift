//
//  SearchViewModel.swift
//  NasaMediaSearch-SwiftUI
//
//  Created by Joshua Homann on 7/4/20.
//

import Combine
import SwiftUI

final class SearchViewModel: ObservableObject {
  @Published var searchTerm = ""
  @Published var mediaType = MediaType.image
  @Published var searchResult: LoadingState<[Item]> = .empty
  @Published var searchItems: [ListItem] = []

  @AppStorage("recents") var storeRecentSearchTerms = Data()

  struct ListItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var children: [ListItem]?
    init(title: String, children: [ListItem]? = nil) {
      self.title = title
      self.children = children
    }
  }

  private var subscriptions = Set<AnyCancellable>()
  init() {

    searchItems = (try? JSONDecoder().decode([ListItem].self, from: storeRecentSearchTerms))
      ?? [ListItem(title: "Recent Searches")]

    Publishers
      .CombineLatest(
        $searchTerm,
        $mediaType
      )
      .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
      .map { [weak self] term, mediaType -> AnyPublisher<LoadingState<[Item]>,Never> in
        guard !(term.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) else {
          return Just(.empty).eraseToAnyPublisher()
        }
        return NasaMediaService
          .search(query: term, mediaType: mediaType)
          .handleEvents(receiveOutput: { [weak self] items in
            guard !items.isEmpty, let self = self else { return }
            var copy = self.searchItems.first?.children ?? []
            guard !Set(copy.map(\.title)).contains(term) else { return }
            copy.insert(.init(title: term, children: nil), at: 0)
            DispatchQueue.main.async {
              self.searchItems[0].children = Array(copy.prefix(5))
              self.storeRecentSearchTerms = (try? JSONEncoder().encode(self.searchItems)) ?? Data()
            }
          })
          .map { $0.isEmpty ? LoadingState.empty : .loaded($0)}
          .catch { Just(.error($0)).eraseToAnyPublisher() }
          .prepend(.loading)
          .eraseToAnyPublisher()
      }
      .switchToLatest()
      .receive(on: RunLoop.main)
      .assign(to: \.searchResult, on: self)
      .store(in: &subscriptions)
  }
}
