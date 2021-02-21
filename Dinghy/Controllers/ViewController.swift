//
//  ViewController.swift
//  Dinghy
//
//  Created by Tyler Myracle on 2/18/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var data: [Asset] = []
    
    var assetManager = AssetManager()
    let offset = 0
    let limit = 10
    let orderDirection = "asc"
    
    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        assetManager.delegate = self
        //getAssetData()
        assetManager.getAssets(offset: 0, limit: 10, orderDirection: "asc")
        prepareCollectionView()
        view.addSubview(collectionView!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    }
   /*
    func getAssetData() {
        let assetResults = assetManager.getAssets(offset: offset, limit: limit, orderDirection: orderDirection)
        data = assetResults
    }
 */
    
    func prepareCollectionView() {
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

extension ViewController: AssetManagerDelegate {
    func didUpdateAssets(_ assetManager: AssetManager, assets: [Asset]) {
        for asset in assets {
            data.append(asset)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

