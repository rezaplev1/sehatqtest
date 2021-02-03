//
//  HomeViewController.swift
//  SehatQTest
//
//  Created by reza pahlevi on 02/02/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    internal let itemHeight: CGFloat = 200
    
    var tableViewHeight: CGFloat {
        let totalBrand: CGFloat = CGFloat(vm.productPromoList?.count ?? 0)
        return (totalBrand * itemHeight)
    }
    
    lazy var productCategoryView: ProductCategoryView = { [unowned self] in
        let vw = ProductCategoryView()
        return vw
    }()
    
    private lazy var tableView: UITableView = { [unowned self] in
        let tv = UITableView()
        tv.tableFooterView = UIView()
        tv.estimatedRowHeight = 120
        tv.backgroundColor = .white
        tv.register(ProductCell.self, forCellReuseIdentifier: "productCell")
        tv.dataSource = self
        tv.delegate = self
        tv.separatorStyle = .singleLine
        tv.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    lazy var scrollView: UIScrollView = { [unowned self] in
        let sc = UIScrollView()
        sc.bounces = true
        
        sc.addSubview(productCategoryView)
        sc.addSubview(tableView)
        productCategoryView.snp.makeConstraints { make in
            make.top.equalTo(sc)
            make.left.equalTo(sc)
            make.right.equalTo(sc)
            make.width.equalTo(sc.snp.width)
            make.height.equalTo(110)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(productCategoryView.snp.bottom).offset(0)
            make.left.equalTo(sc.snp.left).offset(20)
            make.right.equalTo(sc).offset(-20)
            make.width.equalTo(sc.snp.width).offset(-40)
            make.height.equalTo(tableViewHeight)
            make.bottom.equalTo(sc)
        }
        
        return sc
    }()
    
    lazy var searchBar:UISearchBar = UISearchBar()
    
    var vm = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RealmManager.shared.loadRealmObject()
        setupView()
        vm.delegate = self
        vm.getHome()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupView() {
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        let loveImage = UIImage(named: "loveSelectedLogo")
        self.navigationController?.navigationBar.backIndicatorImage = loveImage
        self.navigationController?.navigationBar.tintColor = .black
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: loveImage, style: .plain, target: self, action: #selector(didTapLove))
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
        if let categoryHome = vm.categoryHomeList {
            productCategoryView.createListCategory(roles: categoryHome)
        }
        
    }
    
    @objc func didTapLove() {
    }
}

// MARK: HomeViewModelDelegate

extension HomeViewController: HomeViewModelDelegate {
    
    func failedReq(message: String) {
        simpleAlert(message: message)
    }
    
    func success() {
        if let categoryHome = vm.categoryHomeList {
            productCategoryView.createListCategory(roles: categoryHome)
        }
        tableView.reloadData()
        tableView.snp.updateConstraints { make in
            make.top.equalTo(productCategoryView.snp.bottom).offset(0)
            make.left.equalTo(scrollView.snp.left).offset(20)
            make.right.equalTo(scrollView).offset(-20)
            make.width.equalTo(scrollView.snp.width).offset(-40)
            make.height.equalTo(tableViewHeight)
            make.bottom.equalTo(scrollView)
        }
    }
}

// MARK: UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.productPromoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        
        if let data = vm.productPromoList?[indexPath.item] {
            cell.mappingData(data)
        }
        
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = vm.productPromoList?[indexPath.item] {
            let vc = ProductDetailViewController()
            vc.product = data
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
}


// MARK: - UISearchBarDelegate

extension HomeViewController : UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let vc = SearchViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
        return false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
}
