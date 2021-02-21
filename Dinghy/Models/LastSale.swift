//
//  LastSale.swift
//  Dinghy
//
//  Created by Tyler Myracle on 2/20/21.
//

import Foundation

struct LastSale: Codable {
    let asset: LastSaleAsset?
    let asset_bundle: String?
    let event_type: String
    let event_timestamp: String
    let auction_type: String?
    let total_price: String?
    let payment_token: PaymentToken?
    let transaction: Transaction?
    let created_date: String
    let quantity: String?
}
