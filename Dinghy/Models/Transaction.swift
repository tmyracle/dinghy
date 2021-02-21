//
//  Transaction.swift
//  Dinghy
//
//  Created by Tyler Myracle on 2/20/21.
//

import Foundation

struct Transaction: Codable {
    let block_hash: String
    let block_number: String
    let from_account: Owner?
    let id: Int
    let timestamp: String
    let to_account: Owner?
    let transaction_hash: String?
    let transaction_index: String?
}
