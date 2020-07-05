//
//  MediaDetailView.swift
//  NasaMediaSearch-SwiftUI
//
//  Created by Joshua Homann on 7/4/20.
//

import SwiftUI

struct MediaDetailView: View {
  @Binding var isPresented: Bool
  var item: Item?
  var body: some View {
    NavigationView {
      GeometryReader { geometry in
        VStack(alignment: .center, spacing: 12) {
          NetworkImage(
            url: (item?.links?.first?.href).flatMap(URL.init(string:)),
            placeHolder: nil
          )
          .frame(
            width: min(geometry.size.width, geometry.size.height) * 0.8,
            height: min(geometry.size.width, geometry.size.height) * 0.8
          )
          .clipShape(ContainerRelativeShape())
          Text(item?.data.first?.title ?? "")
            .font(.title)
          Text(item?.data.first?.description508 ?? "")
            .font(.subheadline)
          Spacer()
        }
        .navigationBarTitle(Text(item?.data.first?.title ?? ""), displayMode: .inline)
        .toolbar {
          ToolbarItem(placement: .cancellationAction) {
            Button {
              isPresented = false
            } label: {
              Image(systemName: "xmark.circle.fill")
            }
            .accentColor(.black)
          }
        }
        .padding()
      }
    }
  }
}
