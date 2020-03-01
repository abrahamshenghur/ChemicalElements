//
//  Model.swift
//  ChemicalElements
//
//  Created by John on 11/11/19.
//  Copyright © 2019 Abraham Shenghur. All rights reserved.
//

import Foundation


struct LocalJSONData: Decodable {
    var elements: [Element]
    
    enum CodingKeys: String, CodingKey {
        case elements
    }
}

struct Element: Decodable {
    var name: String
    var number: Int
    var symbol: String
    var atomicWeight: Double
    var summary: String
    var category: String
    var webpageUrl: String
    var period: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case number
        case symbol
        case atomicWeight = "atomic_mass"
        case summary
        case category
        case websiteURL = "source"
        case period
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        number = try container.decode(Int.self, forKey: .number)
        symbol = try container.decode(String.self, forKey: .symbol)
        atomicWeight = try container.decode(Double.self, forKey: .atomicWeight)
        summary = try container.decode(String.self, forKey: .summary)
        category = try container.decode(String.self, forKey: .category)
        webpageUrl = try container.decode(String.self, forKey: .websiteURL)
        period = try container.decode(Int.self, forKey: .period)
    }
}


