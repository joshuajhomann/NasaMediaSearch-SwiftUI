//
//  NasaMediaCollection.swift
//  NasaSearch
//
//  Created by Joshua Homann on 6/26/20.
//

// MARK: - NasaImageCollection
public struct NasaMediaCollection: Codable {
  public var collection: Collection?
}

// MARK: - Collection
public struct Collection: Codable {
  public var links: [CollectionLink]?
  public var items: [Item]
  public var version: String
  public var href: String
  public var metadata: Metadata
}

// MARK: - Item
public struct Item: Codable, Hashable, Identifiable {
  public var id: String { href }

  public static func == (lhs: Item, rhs: Item) -> Bool {
    return lhs.data == rhs.data
  }
  public func hash(into hasher: inout Hasher) {
    data.forEach { hasher.combine($0)}
  }

  public var data: [Datum]
  public var links: [ItemLink]?
  public var href: String
}

// MARK: - Datum
public struct Datum: Codable, Hashable {
  public var datumDescription: String?
  public var dateCreated: String?
  public var center: String?
  public var keywords: [String]?
  public var nasaID, title: String
  public var mediaType: MediaType
  public var description508, secondaryCreator, photographer, location: String?
  public var album: [String]?

  public enum CodingKeys: String, CodingKey {
    case datumDescription = "description"
    case dateCreated = "date_created"
    case center, keywords
    case nasaID = "nasa_id"
    case title
    case mediaType = "media_type"
    case description508 = "description_508"
    case secondaryCreator = "secondary_creator"
    case photographer, location, album
  }
}

public enum MediaType: String, Codable, CaseIterable {
  case image = "image"
  case audio = "audio"
  case video = "video"
}

// MARK: - ItemLink
public struct ItemLink: Codable {
  public var render: MediaType?
  public var href: String
  public var rel: Rel
}

public enum Rel: String, Codable {
  case captions = "captions"
  case preview = "preview"
}

// MARK: - CollectionLink
public struct CollectionLink: Codable {
  public var prompt: String
  public var href: String
  public var rel: String
}

// MARK: - Metadata
public struct Metadata: Codable {
  public var totalHits: Int

  public enum CodingKeys: String, CodingKey {
    case totalHits = "total_hits"
  }
}

