//
//  LocalViewController.swift
//  weGLOTogether
//
//  Created by Kamryn Ohly on 9/19/20.
//  Copyright © 2020 Kamryn Ohly. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class LocalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var businessArray : [CustomBusinessCell] = []
    
    @IBOutlet weak var businessTableView: UITableView!
    
    let CLIENT_ID = "O_S2Kxq35Kp8o7cm_Nqx4w"
       let API_URL = "https://api.yelp.com/v3/businesses/search"
       let API_KEY = "OhaLtEVBl_r4NvCfKn1yDjklV80KqTl6YWDYANZGrMUqM7NO0V96mXX0iJpKX_093vpgztEoz7oG-FKNM6IWFJyt3HcBRo3FG2s7sotHKYqStiwBnvP3_NvuHwVmX3Yx"

    
    override func viewDidLoad() {
        super.viewDidLoad()

        businessTableView.register(UINib(nibName: "CustomBusinessCell", bundle: nil), forCellReuseIdentifier: "CustomBusinessCell")
        let params : [String : Any] = ["term": "local restaurants", "location": "Sandusky, OH"]
                       
        getYelpAPIData(url: API_URL, parameters : params)

        // Do any additional setup after loading the view.
    }
    

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = businessTableView.dequeueReusableCell(withIdentifier: "CustomBusinessCell", for: indexPath) as! CustomBusinessCell
    
    return cell
  }
    
    func getYelpAPIData(url: String, parameters: [String : Any]) {

            
                   Alamofire.request(url, method: .get, parameters: parameters, headers: ["Authorization": "Bearer \(API_KEY)"]).responseJSON {
                       
                       response in
                       if response.result.isSuccess {
                           print("Success! Got the API data.")
                           
                           let apiJSON : JSON = JSON(response.result.value!)
                           print(apiJSON)
                           self.interpretYelpData(json: apiJSON)
                       }
                       else {
                           print("Error \(response.result.error)")
                       }
                       
                   }
                   
               }
    
    func interpretYelpData(json: JSON) {
//        print(json)
        var businessInfo = CustomBusinessCell()
        var image = json["businesses"][2]["image_url"].stringValue
        print(image)
//        businessInfo.businessImage = UIImageView.load(url: URL(image))
        print("TESTING")
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
//extension UIImageView {
//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}
