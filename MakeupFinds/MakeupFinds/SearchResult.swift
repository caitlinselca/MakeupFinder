//
//  SearchResult.swift
//  MakeupFinds
//
//  Created by Caitlin Selca
//  Source: Ray Wenderlich
//  Copyright © 2020 Caitlin Selca. All rights reserved.
//

import UIKit
import Foundation

// MARK: - MakeupElement
//
class Makeup: Codable {
    var resultCount = 0
    var results = [MakeupElement]()
}

class MakeupElement: Codable {
    
    let id: Int
    let brand: String?
    let name: String
    let price: String?
    let priceSign: PriceSign?
    let currency: Currency?
    let imageLink: String
    let productLink: String
    let websiteLink: String
    let makeupDescription: String?
    let rating: Double?
    let category: Category?
    let productType: ProductType
    let tagList: [String]
    let createdAt, updatedAt: String
    let productAPIURL: String
    let apiFeaturedImage: String
//    let productColors: [ProductColor]

    enum CodingKeys: String, CodingKey {
        case id, brand, name, price
        case priceSign = "price_sign"
        case currency
        case imageLink = "image_link"
        case productLink = "product_link"
        case websiteLink = "website_link"
        case makeupDescription = "description"
        case rating, category
        case productType = "product_type"
        case tagList = "tag_list"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case productAPIURL = "product_api_url"
        case apiFeaturedImage = "api_featured_image"
//        case productColors = "product_colors"
    }

    init(id: Int, brand: String?, name: String, price: String?, priceSign: PriceSign?, currency: Currency?, imageLink: String, productLink: String, websiteLink: String, makeupDescription: String?, rating: Double?, category: Category?, productType: ProductType, tagList: [String], createdAt: String, updatedAt: String, productAPIURL: String, apiFeaturedImage: String
//        , productColors: [ProductColor]
    ) {
        self.id = id
        self.brand = brand
        self.name = name
        self.price = price
        self.priceSign = priceSign
        self.currency = currency
        self.imageLink = imageLink
        self.productLink = productLink
        self.websiteLink = websiteLink
        self.makeupDescription = makeupDescription
        self.rating = rating
        self.category = category
        self.productType = productType
        self.tagList = tagList
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.productAPIURL = productAPIURL
        self.apiFeaturedImage = apiFeaturedImage
//        self.productColors = productColors
    }
}

enum Category: String, Codable {
    case bbCc = "bb_cc"
    case concealer = "concealer"
    case contour = "contour"
    case cream = "cream"
    case empty = ""
    case gel = "gel"
    case highlighter = "highlighter"
    case lipGloss = "lip_gloss"
    case lipStain = "lip_stain"
    case lipstick = "lipstick"
    case liquid = "liquid"
    case mineral = "mineral"
    case palette = "palette"
    case pencil = "pencil"
    case powder = "powder"
}

enum Currency: String, Codable {
    case cad = "CAD"
    case gbp = "GBP"
    case usd = "USD"
}

enum PriceSign: String, Codable {
    case empty = "$"
    case priceSign = "£"
}

// MARK: - ProductColor
class ProductColor: Codable {
    let hexValue: String
    let colourName: String?

    enum CodingKeys: String, CodingKey {
        case hexValue = "hex_value"
        case colourName = "colour_name"
    }

    init(hexValue: String, colourName: String?) {
        self.hexValue = hexValue
        self.colourName = colourName
    }
}

enum ProductType: String, Codable {
    case blush = "blush"
    case bronzer = "bronzer"
    case eyebrow = "eyebrow"
    case eyeliner = "eyeliner"
    case eyeshadow = "eyeshadow"
    case foundation = "foundation"
    case lipLiner = "lip_liner"
    case lipstick = "lipstick"
    case mascara = "mascara"
    case nailPolish = "nail_polish"
}

func < (lhs: MakeupElement, rhs: MakeupElement) -> Bool {
  return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
}

