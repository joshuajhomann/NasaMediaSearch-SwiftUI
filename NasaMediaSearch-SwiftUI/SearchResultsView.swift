//
//  SearchResultsView.swift
//  NasaMediaSearch-SwiftUI
//
//  Created by Joshua Homann on 7/4/20.
//

import SwiftUI

struct MediaCell: View {
  var item: Item
  var body: some View {
    ZStack {
      Color(UIColor.systemGray)
      VStack(alignment: .center, spacing: 12) {
        NetworkImage(
          url: (item.links?.first?.href).flatMap(URL.init(string:)),
          placeHolder: nil
        )
        .aspectRatio(1, contentMode: .fit)
        .frame(width: 300, height: 300, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        VStack(alignment: .leading, spacing: 12) {
        Text(item.data.first?.title ?? "")
          .font(.title)
        Text(item.data.first?.description508 ?? "")
          .font(.subheadline)
        }
        Spacer()
      }
      .padding(.all, 24)
      .clipShape(RoundedRectangle(cornerRadius: 24))
    }
  }
}

struct SearchResultsView: View {
  var items: [Item]
  @Binding var selectedItem: Item?
  var body: some View {
    ScrollView {
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 348), spacing: 12)]
      ) {
        ForEach(items) { item in
          VStack {
            MediaCell(item: item).clipShape(RoundedRectangle(cornerRadius: 24))
            Divider()
          }
          .onTapGesture {
            self.selectedItem = item
          }
        }
      }
    }.padding(.horizontal, 8)
  }
}
