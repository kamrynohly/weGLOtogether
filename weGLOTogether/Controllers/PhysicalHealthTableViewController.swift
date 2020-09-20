//
//  PhysicalHealthTableViewController.swift
//  weGLOTogether
//
//  Created by Kamryn Ohly on 9/19/20.
//  Copyright © 2020 Kamryn Ohly. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PhysicalHealthTableViewController: UITableViewController {

    var articlesArray : [ArticleData] = []
     
     let API_URL = "https://api.nytimes.com/svc/search/v2/articlesearch.json"
     let API_KEY = "0b2Bis6auaAsXPZAxBOmx2U6t8GgS4zU"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let params : [String : Any] = ["query": "ways to be healthy", "api-key": API_KEY]
                     getNYTAPIData(url: API_URL, parameters: params)
              tableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "customArticleCell")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articlesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customArticleCell", for: indexPath) as! CustomArticleCell
        cell.articleLeadingPara.text = articlesArray[indexPath.row].leadingParagraph
        cell.articleTitle.text = articlesArray[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: articlesArray[indexPath.row].websiteAddress) else { return }
               UIApplication.shared.open(url)
    }
    
    func getNYTAPIData(url: String, parameters: [String : Any]) {

                       
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
                                  
                                  response in
                                  if response.result.isSuccess {
                                      print("Success! Got the API data.")
                                      
                                      let apiJSON : JSON = JSON(response.result.value!)
                                      print(apiJSON)
                                      self.interpretNYTData(json: apiJSON)
                                  }
                                  else {
                                      print("Error \(response.result.error)")
                                  }
                                  
                }
                              
            }
    
    
    func interpretNYTData(json: JSON) {
        
        
        var i = 0
        while i < 10 {
            if let leadingPara = Optional(json["response"]["docs"][i]["abstract"].stringValue) {
                       let object = ArticleData()
                       object.leadingParagraph = leadingPara
                       object.title = json["response"]["docs"][i]["headline"]["main"].stringValue
                object.websiteAddress = json["response"]["docs"][i]["web_url"].stringValue
                       articlesArray.append(object)
                   }
            i += 1
        }
        tableView.reloadData()
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
