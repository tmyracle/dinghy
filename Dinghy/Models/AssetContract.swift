//
//  AssetContractModel.swift
//  Dinghy
//
//  Created by Tyler Myracle on 2/20/21.
//

import Foundation

struct AssetContract: Codable {
    let address: String
    let asset_contract_type: String
    let created_date: String
    let name: String?
    let nft_version: String?
    let opensea_version: String?
    let owner: Int?
    let schema_name: String
    let symbol: String
    let total_supply: String?
    let description: String?
    let external_link: String?
    let image_url: String?
    let default_to_fiat: Bool
    let dev_buyer_fee_basis_points: Int
    let dev_seller_fee_basis_points: Int
    let only_proxied_transfers: Bool
    let opensea_buyer_fee_basis_points: Int
    let buyer_fee_basis_points: Int
    let seller_fee_basis_points: Int
    let payout_address: String?
}
