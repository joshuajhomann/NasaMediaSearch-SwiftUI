//
//  PlaceholderView.swift
//  NasaMediaSearch-SwiftUI
//
//  Created by Joshua Homann on 7/4/20.
//

import SwiftUI

struct PlaceholderView: View {
  enum Icon {
    case loading, image(name: String)
  }
  var icon: Icon? = nil
  var text: String
  var body: some View {
    VStack {
      VStack {
        Spacer()
        switch icon {
        case .loading:
          ProgressView()
            .scaleEffect(2)
        case let .image(name):
          Image(systemName: name).font(.system(size: 64))
        case .none:
          EmptyView()
        }
        Text(text)
          .font(.title)
          .padding()
        Spacer()
      }
    }
  }
}
