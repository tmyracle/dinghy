//
//  AssetModel.swift
//  Dinghy
//
//  Created by Tyler Myracle on 2/20/21.
//

import Foundation

struct Asset: Codable {
    let id: Int
    let token_id: String
    let num_sales: Int
    let background_color: String?
    let image_url: String
    let image_preview_url: String?
    let image_thumbnail_url: String?
    let image_original_url: String?
    let animation_url: String?
    let animation_original_url: String?
    let name: String?
    let description: String?
    let external_link: String?
    let asset_contract: AssetContract?
    let owner: Owner?
    let permalink: String?
    let collection: Collection?
    let decimals: Int?
    let sell_orders: [SellOrder]?
    let creator: Creator
    let traits: [Trait]?
    let last_sale: LastSale?
    let top_bid: String?
    let listing_date: String?
    let is_presale: Bool?
    let transfer_fee_payment_token: String?
    let transfer_fee: String?
}

