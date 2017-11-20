//
//  FruitListingView.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

class FruitListingView: UIViewController, FruitListingUI {
  let presenter: FruitListingPresenter
  let user: FruitListingUser

  @IBOutlet weak var tableView: UITableView?
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
  @IBOutlet weak var activityLabel: UILabel?
  @IBOutlet weak var activityButton: UIButton?
  @IBAction func activityButtonAction() {
    user.refresh()
  }

  private let refreshControl = UIRefreshControl()

  internal var data: [Fruit] = [Fruit]()

  init(_ presenter: FruitListingPresenter) {
    self.presenter = presenter
    self.user = presenter
    super.init(nibName: nil, bundle: nil)
    title = "Fruit"
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableViewSetup()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    user.arrived()
  }

  // MARK: FruitListingUI

  func loading() {
    tableView?.isHidden = true
    activityLabel?.text = "Loading"
    activityIndicator?.startAnimating()
    activityButton?.isHidden = true
  }

  func finishLoading() {
    tableView?.isHidden = false
    activityButton?.isHidden = true
    activityLabel?.isHidden = true
    activityIndicator?.stopAnimating()
  }

  func noFruitAvailable() {
    tableView?.isHidden = true
    activityLabel?.text = "No fruit available"
    activityIndicator?.stopAnimating()
    activityButton?.setTitle("Reload", for: .normal)
    activityButton?.isHidden = false
  }

  func updateListing(_ fruit: [Fruit]) {
    refreshControl.endRefreshing()
    data = fruit
    tableView?.reloadData()
  }

  func updateListingFailure(_ error: GroceryError) {
    tableView?.isHidden = true
    activityLabel?.text = "Oh no, something went wrong"
    activityLabel?.isHidden = false
    activityButton?.setTitle("Retry", for: .normal)
    activityButton?.isHidden = false
    activityIndicator?.stopAnimating()
  }
}

// MARK: - Table View

extension FruitListingView: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = data[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "Fruit", for: indexPath)

    FruitCellConfigurator.configure(cell, with: item)

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = data[indexPath.row]

    user.select(item)
  }

  @objc func pulledToRefresh() {
    user.refresh()
  }

  private func tableViewSetup() {
    refreshControl.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
    tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "Fruit")
    tableView?.tableFooterView = UIView()
    tableView?.addSubview(refreshControl)
  }
}

//MARK: - Table View Cells

class FruitCellConfigurator {
  class func configure(_ cell: UITableViewCell, with fruit: Fruit) {
    let view = FruitViewModel(model: fruit)
    cell.textLabel?.text = view.displayName
  }
}


