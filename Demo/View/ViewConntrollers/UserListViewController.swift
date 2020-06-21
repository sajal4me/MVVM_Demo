//
//  UserListViewController.swift
//  Demo
//
//  Created by Sajal Gupta on 8/11/2019.
//  Copyright © 2020 Sajal Gupta. All rights reserved.
//

import UIKit


final class UserListViewController: BaseViewController {
 
    //MARK: - IBOutlets
    //======================
    @IBOutlet weak var userTableView: UITableView! {
        didSet {
            userTableView.delegate = self
            userTableView.dataSource = self
        }
    }
    
    //MARK: - Properties
    //======================
    private lazy var viewModel = UserListViewModel(self)

    //MARK: - View Life Cyclee
    //======================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Users"
        loadUsers()
        connfigureTableView()
        configureNavBar()
    }
    
    //MARK: - Private Methods
    //========================
    private func loadUsers() {
        viewModel.fetchUsers() 
    }
    private func connfigureTableView() {
        userTableView.register(with: [UserTVC.self])
    }
    
    private func configureNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
  
    
}

//MARK: - TableView Delegate & DataSource
//==========================================
extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTVC.defaultReuseIdentifier) as! UserTVC
        cell.populateCell(viewModel.user(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: Custom Delegates Methods
//================================
extension UserListViewController: UserListLoadingStateDelegate, AlertShowing {
    func willLoad() {
        startActivityIndicator()
    }
    
    func didLoad() {
        stopActivityIndicator()
        userTableView.reloadData()
    }
    
    func didFail(error: Error) {
        stopActivityIndicator()

        showAlert(title: "Error!", body: error.localizedDescription) {
            print("action")
        }
    }
}
