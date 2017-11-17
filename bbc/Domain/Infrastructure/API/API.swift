//
//  API.swift
//  bbc
//
//  Created by Robin Hayward on 17/11/2017.
//  Copyright © 2017 Mayker. All rights reserved.
//

import Foundation

struct APIConfig {
  let host: String = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master"
}

protocol APIInterface {
  func fruit(completion: @escaping (APIResponse) -> ())
}

class API: APIInterface {
  let config: APIConfig
  let session: URLSession

  init(config: APIConfig = APIConfig(), session: URLSession = URLSession.shared) {
    self.config = config
    self.session = session
  }

  func fruit(completion: @escaping (APIResponse) -> ()) {
    let url = URL(string: "\(config.host)/data.json")!
    let request = URLRequest(url: url)
    let task = session.dataTask(with: request) { (data, response, error) in
      SwitchToMainThread.with {
        completion(APIResponse(data, response, error))
      }
    }

    task.resume()
  }
}
