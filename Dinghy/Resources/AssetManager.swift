//
//  AssetManager.swift
//  Dinghy
//
//  Created by Tyler Myracle on 2/20/21.
//

import Foundation

protocol AssetManagerDelegate {
    func didUpdateAssets(_ assetManager: AssetManager, assets: [Asset])
    func didFailWithError(error: Error)
}

struct AssetManager {
    let baseUrl = "https://api.opensea.io/api/v1/assets?search[categories][0]="
    
    let orderByOptions = ["sale_date", "sale_count", "visitor_count", "sale_price", "token_id"]
    let orderDirection = ["asc", "desc"]
    
    var delegate: AssetManagerDelegate?
    
    func getAssets(assetType: String, offset: Int, limit: Int, orderBy: String, orderDirection: String) {
        let urlString = "\(baseUrl)\(assetType)&order_by=\(orderBy)&order_direction=\(orderDirection)&offset=\(offset)&limit=\(limit)"
        self.performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let assets = self.parseJSON(safeData) {
                        self.delegate?.didUpdateAssets(self, assets: assets)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ assetData: Data) -> [Asset]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(AssetResults.self, from: assetData)
            return decodedData.assets
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
