//
//  SearchViewController.swift
//  SehatQTest
//
//  Created by reza pahlevi on 03/02/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    lazy var searchBar:UISearchBar = UISearchBar()
    
    private lazy var tableView: UITableView = { [unowned self] in
        let tv = UITableView()
        tv.tableFooterView = UIView()
        tv.estimatedRowHeight = 120
        tv.backgroundColor = .white
        tv.register(SearchCell.self, forCellReuseIdentifier: "searchCell")
        tv.dataSource = self
        tv.delegate = self
        tv.separatorStyle = .singleLine
        tv.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    var vm = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    private func setupView() {
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(view)
        }
    }
    
}

// MARK: - UISearchBarDelegate
extension SearchViewController : UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        vm.textSearch = searchBar.text ?? ""
        tableView.reloadData()
        searchBar.endEditing(true)
        
    }
    
}

// MARK: UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.productPromoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchCell
        
        if let data = vm.productPromoList?[indexPath.item] {
            cell.mappingData(data)
        }
        
        return cell
    }
    
}

// MARK: UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = vm.productPromoList?[indexPath.item] {
            let vc = ProductDetailViewController()
            vc.product = data
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
