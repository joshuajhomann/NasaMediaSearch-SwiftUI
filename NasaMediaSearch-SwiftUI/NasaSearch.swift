//
//  NasaSearch.swift
//  NasaSearch
//
//  Created by Joshua Homann on 6/26/20.
//

import Combine
import Foundation

public enum NasaMediaService {
  public enum Error: Swift.Error {
    case invalidURL
  }
  enum Constant {
    static let baseURL = URL(string:"https://images-api.nasa.gov/search")!
  }
  public static func search(query: String, mediaType: MediaType) -> AnyPublisher<[Item], Swift.Error> {
    var components = URLComponents(url: Constant.baseURL, resolvingAgainstBaseURL: false)
    components?.queryItems = [
      URLQueryItem(name: "q", value: query),
      URLQueryItem(name: "media_type", value: mediaType.rawValue)
    ]
    guard let url = components?.url else {
      return Fail(error: Error.invalidURL)
        .eraseToAnyPublisher()
    }
    return URLSession
      .shared
      .dataTaskPublisher(for: url)
      .map(\.data)
      .decode(type: NasaMediaCollection.self, decoder: JSONDecoder())
      .map { $0.collection?.items ?? [] }
      .eraseToAnyPublisher()
  }
}
