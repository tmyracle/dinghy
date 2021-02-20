//
//  ViewController.swift
//  Dinghy
//
//  Created by Tyler Myracle on 2/18/21.
//

import UIKit

struct AssetModel {
    let tokenId: String
    let imageUrl: String
    let backgroundColor: String
    let name: String
    let externalLink: String
    let owner: String
    let lastSale: String
}

class ViewController: UIViewController {
    
    private let offSet = 10
    private let order = "desc"
    
    private var data = [AssetModel]()
    
    
    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = createFakeData()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0.0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), collectionViewLayout: layout)
        collectionView?.register(AssetCollectionViewCell.self, forCellWithReuseIdentifier: AssetCollectionViewCell.identifier)
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .red
        collectionView?.contentInsetAdjustmentBehavior = .never
        collectionView?.showsVerticalScrollIndicator = false
        view.addSubview(collectionView!)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    }
    
    func createFakeData() -> [AssetModel] {
        var models: [AssetModel] = []
        for index in 0..<10 {
            let asset = AssetModel(tokenId: "\(index)", imageUrl: "https://google.com", backgroundColor: "black", name: "Item \(index)", externalLink: "https://google.com", owner: "Tyler", lastSale: "Yesterday")
            models.append(asset)
        }
        return models
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssetCollectionViewCell.identifier, for: indexPath) as! AssetCollectionViewCell
        cell.configure(with: model)
        return cell
    }
    
    
}

