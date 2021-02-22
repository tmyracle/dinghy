//
//  CollectionManager.swift
//  Dinghy
//
//  Created by Tyler Myracle on 2/21/21.
//

import Foundation

protocol CollectionManagerDelegate {
    func didUpdateAssets(_ assetManager: CollectionManager, collections: [Collection])
    func didFailWithError(error: Error)
}

struct CollectionManager {
    let baseUrl = "https://api.opensea.io/api/v1/collections?"
    
    let limit = 20
    let offset = 0
    
    var delegate: CollectionManagerDelegate?
    
    func getAssets(offset: Int, limit: Int) {
        let urlString = "\(baseUrl)&offset=\(offset)&limit=\(limit)"
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
                    if let collections = self.parseJSON(safeData) {
                        print(collections)
                        //self.delegate?.didUpdateAssets(self, assets: assets)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ collectionData: Data) -> [Collection]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CollectionResults.self, from: collectionData)
            return decodedData.collections
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
