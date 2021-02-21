//
//  PaymentToken.swift
//  Dinghy
//
//  Created by Tyler Myracle on 2/20/21.
//

import Foundation

struct PaymentToken: Codable {
    let id: Int
    let symbol: String
    let address: String
    let image_url: String?
    let name: String
    let decimals: Int?
    let eth_price: String?
    let usd_price: String?
}
