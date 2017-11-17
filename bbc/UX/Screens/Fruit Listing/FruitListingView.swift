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

  private var data: [Fruit] = [Fruit]()

  init(_ presenter: FruitListingPresenter) {
    self.presenter = presenter
    self.user = presenter
    super.init(nibName: nil, bundle: nil)
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
  }

  func updateListing(_ fruit: [Fruit]) {
    data = fruit
    tableView?.reloadData()
    tableView?.isHidden = false
  }

  func updateListingFailure(_ error: GroceryError) {
    tableView?.isHidden = true
  }
}

// MARK: - Table View

extension FruitListingView: UITableViewDelegate, UITableViewDataSource {
  struct TableViewCells {
    static let Fruit = CellBlueprint<FruitCell>("FruitCell", height: 100.0)
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = data[indexPath.row]
    let cell = TableViewCells.Fruit.dequeue(with: tableView, for: indexPath)

    FruitCellConfigurator.configure(cell, with: item)

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = data[indexPath.row]

    user.select(item)
  }

  private func tableViewSetup() {
    TableViewCells.Fruit.register(with: tableView)
    tableView?.tableFooterView = UIView()
  }
}

//MARK: - Table View Cells

class FruitCellConfigurator {
  class func configure(_ cell: FruitCell, with fruit: Fruit) {
    let view = FruitViewModel(model: fruit)
    cell.nameLabel?.text = view.displayName
  }
}


