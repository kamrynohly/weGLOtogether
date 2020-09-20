//
//  MentalHealthTableViewController.swift
//  weGLOTogether
//
//  Created by Kamryn Ohly on 9/19/20.
//  Copyright © 2020 Kamryn Ohly. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MentalHealthTableViewController: UITableViewController {

    var articlesArray : [ArticleData] = []
    
    let API_URL = "https://api.nytimes.com/svc/search/v2/articlesearch.json"
    let API_KEY = "0b2Bis6auaAsXPZAxBOmx2U6t8GgS4zU"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let params : [String : Any] = ["query": "mental-health tips", "api-key": API_KEY]
               getNYTAPIData(url: API_URL, parameters: params)
        tableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "customArticleCell")

        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

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

    
       func getNYTAPIData(url: String, parameters: [String : Any]) {

                   
                          Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
                              
                              response in
                              if response.result.isSuccess {
                                  print("Success! Got the API data.")
                                  
                                  let apiJSON : JSON = JSON(response.result.value!)
//                                  print(apiJSON)
                                  self.interpretNYTData(json: apiJSON)
                              }
                              else {
                                  print("Error \(response.result.error)")
                              }
                              
            }
                          
        }
    
    func interpretNYTData(json: JSON) {
        
        print(json)
        
        if let leadingPara = Optional(json["response"]["docs"][0]["snippet"].stringValue) {
            let object = ArticleData()
            object.leadingParagraph = leadingPara
            object.title = json["response"]["docs"][0]["headline"]["main"].stringValue
            articlesArray.append(object)
        }
        tableView.reloadData()
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
