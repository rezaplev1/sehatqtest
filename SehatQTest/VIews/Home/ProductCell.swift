//
//  ProductCell.swift
//  SehatQTest
//
//  Created by reza pahlevi on 03/02/21.
//

import UIKit
import SDWebImage

class ProductCell: UITableViewCell {
    
    lazy var productImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var likeStatusImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    var titleLbl: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.selectionStyle = .none
        contentView.addSubview(productImg)
        contentView.addSubview(titleLbl)
        contentView.addSubview(likeStatusImg)
        
        productImg.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.left.right.equalTo(contentView)
        }
        
        likeStatusImg.snp.makeConstraints { make in
            make.left.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-32)
            make.size.equalTo(32)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(productImg.snp.bottom).offset(16)
            make.bottom.left.right.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-16)
        }
    }
    
    func mappingData(_ product: ProductPromo){
        titleLbl.text = product.title
        productImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageUrl = URL(string: product.imageURL)
        productImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(), options: .highPriority, completed: nil)
        
        likeStatusImg.image = product.loved == 1 ? UIImage(named: "loveSelectedLogo") : UIImage(named: "loveNormalLogo")
    }

}
