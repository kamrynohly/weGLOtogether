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

    @IBAction func ConnectingTapped(_ sender: Any) {
        guard let url = URL(string: "https://skribbl.io") else { return }
               UIApplication.shared.open(url)
//        if let url = URL(string: "https://skribbl.io") {
//        UIApplication.shared.open(url)
//    }
}
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
