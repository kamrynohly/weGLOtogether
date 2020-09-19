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

    @IBOutlet weak var businessTypeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    var businessArray : [BusinessData] = []
    
    @IBOutlet weak var businessTableView: UITableView!
    
    let CLIENT_ID = "O_S2Kxq35Kp8o7cm_Nqx4w"
       let API_URL = "https://api.yelp.com/v3/businesses/search"
       let API_KEY = "OhaLtEVBl_r4NvCfKn1yDjklV80KqTl6YWDYANZGrMUqM7NO0V96mXX0iJpKX_093vpgztEoz7oG-FKNM6IWFJyt3HcBRo3FG2s7sotHKYqStiwBnvP3_NvuHwVmX3Yx"

    
    override func viewDidLoad() {
        super.viewDidLoad()

       businessTableView.register(UINib(nibName: "BusinessCell", bundle: nil), forCellReuseIdentifier: "customBusinessCell")
        let params : [String : Any] = ["term": "local restaurants", "location": "Sandusky, OH"]
        
        businessTableView.delegate = self
        businessTableView.dataSource = self
        
        getYelpAPIData(url: API_URL, parameters : params)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func locationChangedPressed(_ sender: UIButton) {
        businessArray = []
        if let location = locationTextField.text {
            if let type = businessTypeTextField.text {
                let params : [String : Any] = ["term": "local \(type)", "location": location]
                getYelpAPIData(url: API_URL, parameters: params)
            }
            else {
                //do nothing
            }
        }
        else {
            //do nothing
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: businessArray[indexPath.row].website) else { return }
        UIApplication.shared.open(url)

    }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 200
       }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return businessArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "customBusinessCell", for: indexPath) as! CustomBusinessCell
    
    
    cell.businessImage.load(url: businessArray[indexPath.row].imageAddress)
    print(businessArray[indexPath.row].imageAddress)
    cell.businessTitle.text = businessArray[indexPath.row].title
    cell.businessPrice.text = businessArray[indexPath.row].price
    cell.businessNumber.text = businessArray[indexPath.row].phone
    cell.businessAddress.text = businessArray[indexPath.row].address

    
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
        print(json.count)
        var i = 0
        while (i < 6)  {
            print(json["businesses"][i]["name"])
            if let indexWorks = Optional(json["businesses"][i]["name"]) {
                let businessInfo = BusinessData()
                if let img = json["businesses"][i]["image_url"].url {
                    businessInfo.imageAddress = img
                } else {
                    //no image
                }

                 businessInfo.title = json["businesses"][i]["name"].stringValue
                 businessInfo.phone = json["businesses"][i]["display_phone"].stringValue
                 businessInfo.price = json["businesses"][i]["price"].stringValue
                 businessInfo.address = json["businesses"][i]["location"]["display_address"][0].stringValue + ", " + json["businesses"][i]["location"]["display_address"][1].stringValue
                 businessInfo.website = json["businesses"][i]["url"].stringValue
                businessArray.append(businessInfo)
            } else {
                //do nothing
            }
            
            i += 1
        }
        print("successfully appended business data points")

        businessTableView.reloadData()
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

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
