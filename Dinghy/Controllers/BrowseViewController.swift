//
//  ViewController.swift
//  Dinghy
//
//  Created by Tyler Myracle on 2/18/21.
//

import UIKit
import JGProgressHUD

class BrowseViewController: UIViewController {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private var data: [Asset] = []
    
    let assetTypes = ["art", "domain-names", "virtual-worlds", "trading-cards", "collectibles", "sports", "utility"]
    
    var assetManager = AssetManager()
    var offset = 0
    var limit = 10
    var selectedSortOption = "sale_date"
    var selectedOrderDirection = "desc"
    
    private var collectionView: UICollectionView?
    
    private let sortByPicker: UIPickerView = {
        let sortByPicker = UIPickerView()
        
        return sortByPicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareCollectionView()
        sortByPicker.delegate = self
        sortByPicker.dataSource = self
        assetManager.delegate = self
        assetManager.getAssets(assetType: assetTypes[0], offset: offset, limit: limit, orderBy: selectedSortOption, orderDirection: selectedOrderDirection)
        view.addSubview(collectionView!)
        view.addSubview(sortByPicker)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        sortByPicker.frame = CGRect(x: 0, y: view.bottom - 150, width: view.width, height: 100)
    }
    
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
        collectionView?.prefetchDataSource = self
        collectionView?.backgroundColor = .red
        collectionView?.contentInsetAdjustmentBehavior = .never
        collectionView?.showsVerticalScrollIndicator = false
    }
}

extension BrowseViewController: UICollectionViewDataSource {
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

extension BrowseViewController: AssetManagerDelegate {
    func didUpdateAssets(_ assetManager: AssetManager, assets: [Asset]) {
        self.data.append(contentsOf: assets)
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension BrowseViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath[1] % 9 == 0 {
                offset += 10
                assetManager.getAssets(assetType: assetTypes[0], offset: offset, limit: limit, orderBy: selectedSortOption, orderDirection: selectedOrderDirection)
            }
        }
    }
}

extension BrowseViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return assetManager.orderByOptions.count
    }
}

extension BrowseViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch assetManager.orderByOptions[row] {
        case "sale_date":
            return "Recently Sold"
        case "sale_count":
            return "Most Sold"
        case "visitor_count":
            return "Most Viewed"
        case "sale_price":
            return "Highest Price"
        case "token_id":
            return "Recently Created"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if selectedSortOption == self.assetManager.orderByOptions[row] {
            return
        } else {
            spinner.show(in: view)
            selectedSortOption = self.assetManager.orderByOptions[row]
            data = []
            self.assetManager.getAssets(assetType: assetTypes[0], offset: offset, limit: limit, orderBy: selectedSortOption, orderDirection: selectedOrderDirection)
            spinner.dismiss()
        }
    }
    
}
