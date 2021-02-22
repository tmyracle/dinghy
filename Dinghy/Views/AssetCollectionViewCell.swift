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
        label.textColor = .label
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let lastSaleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemBackground
        imageView.layer.cornerRadius = 24
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.clipsToBounds = true
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = contentView.frame.size.width
        let height = contentView.frame.size.height
        
        imageView.frame = CGRect(x: 30, y: 60, width: width - 60, height: height / 1.5)
        nameLabel.frame = CGRect(x: 30, y: imageView.bottom + 10, width: width - 60, height: 30)
        lastSaleLabel.frame = CGRect(x: 30, y: nameLabel.bottom + 10, width: width - 60, height: 30)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        lastSaleLabel.text = nil
    }
    
    private func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(lastSaleLabel)
        contentView.addSubview(imageView)
    }
    
    public func configure(with model: Asset) {
        self.model = model
        nameLabel.text = model.name
        guard let safePrice = model.last_sale?.total_price else {return}
        let priceAsNumber = Double(safePrice)
        let truncatedPrice = priceAsNumber! / 1000000000000000000.0
        lastSaleLabel.text = "Last Ξ\(truncatedPrice)"
        imageView.sd_setImage(with: URL(string: model.image_url), completed: nil)
    }
}
