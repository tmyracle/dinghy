//
//  OwnerModel.swift
//  Dinghy
//
//  Created by Tyler Myracle on 2/20/21.
//

import Foundation

struct Owner: Codable {
    let user: User?
    let profile_img_url: String?
    let address: String?
    let config: String
    let discord_id: String
}
