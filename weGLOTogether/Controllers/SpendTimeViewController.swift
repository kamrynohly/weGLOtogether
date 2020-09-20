//
//  SpendTimeViewController.swift
//  weGLOTogether
//
//  Created by Jordan Pemberton on 9/20/20.
//  Copyright © 2020 Kamryn Ohly. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SpendTimeViewController: UIViewController {

    @IBAction func OnHeadspace(_ sender: Any) {
        if let url = URL(string: "https://apps.apple.com/us/app/headspace-meditation-sleep/id493145008") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func OnCooking(_ sender: Any) {
        if let url = URL(string: "https://apps.apple.com/us/app/nyt-cooking/id911422904") {
            UIApplication.shared.open(url)
        }
    }
    
    
    @IBAction func OnReading(_ sender: Any) {
        if let url = URL(string: "https://apps.apple.com/us/app/goodreads-book-reviews/id355833469") {
            UIApplication.shared.open(url)
        }
    }
    
    
    @IBAction func OnLearning(_ sender: Any) {
        if let url = URL(string: "https://apps.apple.com/us/app/skillshare-creative-classes/id916819843") {
            UIApplication.shared.open(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
