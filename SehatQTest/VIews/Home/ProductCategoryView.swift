//
//  ProductCategoryView.swift
//  SehatQTest
//
//  Created by reza pahlevi on 03/02/21.
//

import UIKit
import SDWebImage

protocol ProductCategoryViewDelegate : class {
    func didSelectedBtn(_ selectedRole: String)
}

class ProductCategoryView: UIView {
    weak var delegate: ProductCategoryViewDelegate?
    
    private lazy var scrollView: UIScrollView = { [unowned self] in
        let sc = UIScrollView()
        sc.isScrollEnabled = true
        sc.delegate = self
        return sc
    }()
    
    lazy var titleLbl: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .white
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(self)
        }
    }
    
    func createListCategory(roles: [CategoryHome]) {
        scrollView.subviews.forEach { $0.removeFromSuperview() }
        if !roles.isEmpty {
            var count = 0
            var px = 16
            var py = 32
            for data in roles {
                let imageView: UIImageView = UIImageView()
                let titleLbl = UILabel()
                titleLbl.numberOfLines = 2
                titleLbl.textAlignment = .center
                titleLbl.tag = count
                scrollView.addSubview(titleLbl)
                scrollView.addSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.width.height.equalTo(58)
                    make.centerX.equalTo(px+16)
                    make.centerY.equalTo(py+8)
                }
                titleLbl.snp.makeConstraints { make in
                    make.top.equalTo(imageView.snp.bottom).offset(8)
                    make.centerX.equalTo(imageView)
                }
                imageView.layer.cornerRadius = 29
                imageView.clipsToBounds = true
                titleLbl.text = data.name
                
                imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
                let imageUrl = URL(string: data.imageURL)
                
                imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(), options: .highPriority, completed: nil)
                
                px = px + 100
                count += 1
            }
            scrollView.contentSize = CGSize(width: px, height: 110)
        }
    }
    
    @objc func scrollButtonAction(sender: UIButton) {
        if let nameButton = sender.titleLabel?.text {
            delegate?.didSelectedBtn(nameButton)
        }
    }
}

extension ProductCategoryView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}
