//
//  NewsModel.swift
//  NYTimes
//
//  Created by Sajjad Zafar on 6/25/23.
//

import Foundation

// MARK: - NewsModel
public struct NewsModel: Codable {
    public let status, copyright: String?
    public let numResults: Int?
    public let results: [NewsResults]?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }

    public init(status: String?, copyright: String?, numResults: Int?, results: [NewsResults]?) {
        self.status = status
        self.copyright = copyright
        self.numResults = numResults
        self.results = results
    }
}

// MARK: - Result
public struct NewsResults: Codable {
    public let uri: String?
    public let url: String?
    public let id, assetID: Int?
    public let source: String?
    public let publishedDate, updated, section, subsection: String?
    public let nytdsection, adxKeywords: String?
    public let column: String?
    public let byline: String?
    public let type: String?
    public let title, abstract: String?
    public let desFacet, orgFacet, perFacet, geoFacet: [String]?
    public let media: [Media]?
    public let etaID: Int?

    enum CodingKeys: String, CodingKey {
        case uri, url, id
        case assetID = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated, section, subsection, nytdsection
        case adxKeywords = "adx_keywords"
        case column, byline, type, title, abstract
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case etaID = "eta_id"
    }

    public init(uri: String?, url: String?, id: Int?, assetID: Int?, source: String?, publishedDate: String?, updated: String?, section: String?, subsection: String?, nytdsection: String?, adxKeywords: String?, column: String?, byline: String?, type: String?, title: String?, abstract: String?, desFacet: [String]?, orgFacet: [String]?, perFacet: [String]?, geoFacet: [String]?, media: [Media]?, etaID: Int?) {
        self.uri = uri
        self.url = url
        self.id = id
        self.assetID = assetID
        self.source = source
        self.publishedDate = publishedDate
        self.updated = updated
        self.section = section
        self.subsection = subsection
        self.nytdsection = nytdsection
        self.adxKeywords = adxKeywords
        self.column = column
        self.byline = byline
        self.type = type
        self.title = title
        self.abstract = abstract
        self.desFacet = desFacet
        self.orgFacet = orgFacet
        self.perFacet = perFacet
        self.geoFacet = geoFacet
        self.media = media
        self.etaID = etaID
    }
}

// MARK: - Media
public struct Media: Codable {
    public let type: String?
    public let subtype: String?
    public let caption, copyright: String?
    public let approvedForSyndication: Int?
    public let mediaMetadata: [MediaMetadatum]?

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }

    public init(type: String?, subtype: String?, caption: String?, copyright: String?, approvedForSyndication: Int?, mediaMetadata: [MediaMetadatum]?) {
        self.type = type
        self.subtype = subtype
        self.caption = caption
        self.copyright = copyright
        self.approvedForSyndication = approvedForSyndication
        self.mediaMetadata = mediaMetadata
    }
}

// MARK: - MediaMetadatum
public struct MediaMetadatum: Codable {
    public let url: String?
    public let format: String?
    public let height, width: Int?

    public init(url: String?, format: String?, height: Int?, width: Int?) {
        self.url = url
        self.format = format
        self.height = height
        self.width = width
    }
}
