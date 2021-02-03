//
//  ProfileViewController.swift
//  SehatQTest
//
//  Created by reza pahlevi on 03/02/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var tableView: UITableView = { [unowned self] in
        let tv = UITableView()
        tv.tableFooterView = UIView()
        tv.estimatedRowHeight = 120
        tv.backgroundColor = .white
        tv.register(OrderCell.self, forCellReuseIdentifier: "orderCell")
        tv.dataSource = self
        tv.delegate = self
        tv.separatorStyle = .singleLine
        tv.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    var vm = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        tableView.reloadData()
    }

    private func setupView() {
        setNavTitle(withTitle: "Purchased History", withBackButton: false)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(view)
        }
    }

}

// MARK: UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.orderItemList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderCell
        
        if let data = vm.orderItemList?[indexPath.item] {
            cell.mappingData(data)
        }
        
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = vm.orderItemList?[indexPath.item] {
            if let product = vm.getProduct(data.id) {
                let vc = ProductDetailViewController()
                vc.product = product
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            }
         
        }
    }

}
