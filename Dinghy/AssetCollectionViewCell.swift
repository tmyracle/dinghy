//
//  AssetCollectionViewCell.swift
//  Dinghy
//
//  Created by Tyler Myracle on 2/18/21.
//

import UIKit

class AssetCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AssetCollectionViewCell"
    
    private var model: AssetModel?
    
    private let tokenIdLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .red
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .red
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .link
        contentView.clipsToBounds = true
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.frame.size.width / 3
        let width = contentView.frame.size.width
        let height = contentView.frame.size.height
        
        tokenIdLabel.frame = CGRect(x: width/2 - size/2, y: height / 2, width: size, height: 30)
        nameLabel.frame = CGRect(x: width/2 - size/2, y: height/2 + 50, width: size, height: 30)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tokenIdLabel.text = nil
        nameLabel.text = nil
    }
    
    private func addSubviews() {
        contentView.addSubview(tokenIdLabel)
        contentView.addSubview(nameLabel)
    }
    
    public func configure(with model: AssetModel) {
        self.model = model
        tokenIdLabel.text = model.tokenId
        nameLabel.text = model.name
    }
}
