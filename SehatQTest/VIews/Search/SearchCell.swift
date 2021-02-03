//
//  SearchCell.swift
//  SehatQTest
//
//  Created by reza pahlevi on 03/02/21.
//

import Foundation
import SDWebImage

class SearchCell: UITableViewCell {
    
    lazy var productImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    
    var titleLbl: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    var priceLbl: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
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
        contentView.addSubview(priceLbl)
        
        productImg.snp.makeConstraints { make in
            make.top.left.equalTo(contentView).offset(8)
            make.size.equalTo(100)
            make.bottom.equalTo(contentView).offset(-8)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(productImg.snp.top)
            make.left.equalTo(productImg.snp.right).offset(16)
            make.right.equalTo(contentView)
        }
        
        priceLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(16)
            make.left.right.equalTo(titleLbl)
        }
    }
    
    func mappingData(_ product: ProductPromo){
        titleLbl.text = product.title
        productImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageUrl = URL(string: product.imageURL)
        productImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(), options: .highPriority, completed: nil)
        priceLbl.text = product.price
    }
    
}
