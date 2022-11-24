//
//  Countries.swift
//
//  Created by Agha Asad Hussain on 11/16/22.
//

import Foundation
import SwiftUI
import CoreLocation

var countries : [Country]! = []

struct DataObj:  Decodable{
    var data: [Country]
}

struct Country: Decodable, Identifiable{
    let resource: String
    let id: Int
    let continent_id: Int?
    let name: String
    let image_path: String
    let updated_at: String?    
}

struct DataModel: Decodable {
    var data : [Country]

    enum CodingKeys: String, CodingKey{
        case data
    }
    
    enum NameKeys: CodingKey {
        case resource
        case id
        case continent_id
        case name
        case image_path
        case updated_at
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode([Country].self, forKey: .data)
    }
    
}
