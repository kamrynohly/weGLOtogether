//
//  OneselfViewController.swift
//  weGLOTogether
//
//  Created by Kamryn Ohly on 9/19/20.
//  Copyright © 2020 Kamryn Ohly. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class OneselfViewController: UIViewController {

    let API_URL = "https://api.nytimes.com/svc/search/v2/articlesearch.json"
    let API_KEY = "0b2Bis6auaAsXPZAxBOmx2U6t8GgS4zU"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let params : [String : Any] = ["query": "covid", "api-key": API_KEY]
        getNYTAPIData(url: API_URL, parameters: params)
        // Do any additional setup after loading the view.
    }
    
    func getNYTAPIData(url: String, parameters: [String : Any]) {

               
                      Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
                          
                          response in
                          if response.result.isSuccess {
                              print("Success! Got the API data.")
                              
                              let apiJSON : JSON = JSON(response.result.value!)
                              print(apiJSON)
//                              self.interpretYelpData(json: apiJSON)
                          }
                          else {
                              print("Error \(response.result.error)")
                          }
                          
                      }
                      
                  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
