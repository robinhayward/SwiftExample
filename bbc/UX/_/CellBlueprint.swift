//
//  CellBlueprint.swift
//  bbc
//
//  Created by Robin Hayward on 15/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

class CellBlueprint<CellType: UITableViewCell> {
  let id: String
  let height: CGFloat

  init(_ id: String, height: CGFloat) {
    self.id = id
    self.height = height
  }

  func register(with tableView: UITableView?) {
    tableView?.register(nib(), forCellReuseIdentifier: id)
  }

  func dequeue(with tableView: UITableView?, for indexPath: IndexPath) -> CellType {
    return tableView?.dequeueReusableCell(withIdentifier: id, for: indexPath) as! CellType
  }

  private func nib() -> UINib {
    return UINib(nibName: id, bundle: nil)
  }
}
