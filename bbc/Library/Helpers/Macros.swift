//
//  MacroHelpers.swift
//  bbc
//
//  Created by Robin Hayward on 20/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation
import UIKit

class Macro {
  class func filename(from path: String) -> String {
    return (path as NSString).lastPathComponent as String
  }
}
