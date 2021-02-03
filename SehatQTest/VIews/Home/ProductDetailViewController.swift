//
//  ProductDetailViewController.swift
//  SehatQTest
//
//  Created by reza pahlevi on 03/02/21.
//

import UIKit
import SDWebImage

class ProductDetailViewController: UIViewController {
    
    let productImg: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var titleLbl: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "-"
        return label
    }()
    
    lazy var likeStatusImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    var descLbl: UILabel = {
        let label: UILabel = UILabel()
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    
    var addBtn: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.orange.cgColor
        button.layer.backgroundColor = UIColor.orange.cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 2
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.setTitle("Buy", for: .normal)
        button.addTarget(self, action: #selector(didTapAddOrder), for: .touchUpInside)
        return button
    }()
    
    var priceLbl: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "-"
        return label
    }()
    
    lazy var scrollView: UIScrollView = { [unowned self] in
        let sc = UIScrollView()
        sc.backgroundColor = .clear
        sc.bounces = true
        sc.addSubview(productImg)
        sc.addSubview(titleLbl)
        sc.addSubview(likeStatusImg)
        sc.addSubview(descLbl)
        sc.addSubview(addBtn)
        sc.addSubview(priceLbl)
        
        productImg.snp.makeConstraints { (make) in
            make.top.equalTo(sc).offset(16)
            make.left.equalTo(sc).offset(20)
            make.right.equalTo(sc).offset(-20)
            make.size.equalTo(sc.snp.width).offset(-40)
        }
        
        titleLbl.snp.makeConstraints { (make) in
            make.top.equalTo(productImg.snp.bottom).offset(16)
            make.left.equalTo(sc).offset(20)
            make.width.equalTo(sc.snp.width).offset(-40)
        }
        
        likeStatusImg.snp.makeConstraints { (make) in
            make.right.equalTo(sc).offset(-20)
            make.top.equalTo(productImg.snp.bottom).offset(-16)
            make.size.equalTo(32)
        }
        
        descLbl.snp.makeConstraints { (make) in
            make.top.equalTo(titleLbl.snp.bottom).offset(16)
            make.left.equalTo(sc).offset(20)
            make.right.equalTo(sc).offset(-20)
            make.width.equalTo(sc.snp.width).offset(-40)
        }
        
        addBtn.snp.makeConstraints { (make) in
            make.top.equalTo(descLbl.snp.bottom).offset(16)
            make.right.equalTo(sc).offset(-20)
            make.width.equalTo(100)
            make.bottom.equalTo(sc).offset(-20)
        }
        
        priceLbl.snp.makeConstraints { (make) in
            make.right.equalTo(addBtn.snp.left).offset(-20)
            make.centerY.equalTo(addBtn)
        }
        
        return sc
    }()
    
    var product: ProductPromo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        mappingData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupView() {
        
        let shareImage = UIImage(named: "shareImagelogo")
        self.navigationController?.navigationBar.backIndicatorImage = shareImage
        self.navigationController?.navigationBar.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: shareImage, style: .plain, target: self, action: #selector(didTapShared))
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    
    private func mappingData() {
        titleLbl.text = product.title
        productImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageUrl = URL(string: product.imageURL)
        productImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(), options: .highPriority, completed: nil)
        
        likeStatusImg.image = product.loved == 1 ? UIImage(named: "loveSelectedLogo") : UIImage(named: "loveNormalLogo")
        
        descLbl.text = product.productPromoDescription
        priceLbl.text = product.price
    }
    
    @objc func didTapShared() {
        let objectsToShare = ["Checkout this product \(product?.title ?? "")"] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @objc func didTapAddOrder() {
        let orderItem: OrderItemModel = OrderItemModel()
        orderItem.id = product.id
        orderItem.imageURL = product.imageURL
        orderItem.title = product.title
        orderItem.price = product.price
        RealmManager.shared.add(orderItem)
        simpleAlert(message: "Purchase successful")
    }
}
