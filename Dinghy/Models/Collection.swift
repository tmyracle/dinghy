//
//  CollectionModel.swift
//  Dinghy
//
//  Created by Tyler Myracle on 2/20/21.
//

import Foundation

struct Collection: Codable {
    let banner_image_url: String?
    let chat_url: String?
    let created_date: String
    let default_to_fiat: Bool
    let description: String?
    let dev_buyer_fee_basis_points: String?
    let dev_seller_fee_basis_points: String?
    let discord_url: String?
    let display_data: DisplayData?
    let external_url: String?
    let featured: Bool
    let featured_image_url: String?
    let hidden: Bool
    let safelist_request_status: String?
    let image_url: String?
    let is_subject_to_whitelist: Bool
    let large_image_url: String?
    let medium_username: String?
    let name: String?
    let only_proxied_transfers: Bool
    let opensea_buyer_fee_basis_points: String?
    let opensea_seller_fee_basis_points: String?
    let payout_address: String?
    let require_email: Bool
    let short_description: String?
    let slug: String?
    let telegram_url: String?
    let twitter_url: String?
    let wiki_url: String?
}
