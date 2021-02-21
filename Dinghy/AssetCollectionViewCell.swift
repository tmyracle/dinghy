//
//  AssetCollectionViewCell.swift
//  Dinghy
//
//  Created by Tyler Myracle on 2/18/21.
//

import UIKit
import SDWebImage

class AssetCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AssetCollectionViewCell"
    
    private var model: Asset?
    
    private let tokenIdLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .red
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let imageUrlLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .red
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
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
        nameLabel.frame = CGRect(x: 30, y: height/4 - 50, width: width - 60, height: 30)
        imageUrlLabel.frame = CGRect(x: width/2 - size/2, y: height/2 + 100, width: size, height: 30)
        imageView.frame = CGRect(x: 30, y: height/4, width: width - 60, height: height / 2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tokenIdLabel.text = nil
        nameLabel.text = nil
        imageUrlLabel.text = nil
    }
    
    private func addSubviews() {
        contentView.addSubview(tokenIdLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageUrlLabel)
        contentView.addSubview(imageView)
    }
    
    public func configure(with model: Asset) {
        self.model = model
        tokenIdLabel.text = "\(model.id)"
        nameLabel.text = model.name
        imageUrlLabel.text = model.image_url
        imageView.sd_setImage(with: URL(string: model.image_url), completed: nil)
    }
}
