//
//  CommunityViewController.swift
//  weGLOTogether
//
//  Created by Kamryn Ohly on 9/20/20.
//  Copyright © 2020 Kamryn Ohly. All rights reserved.
//

import UIKit
import MapKit

struct CommunityOrganization {
    var name: String
    var latitude: CLLocationDegrees
    var longtitude: CLLocationDegrees
    var phone: Int
}
class CommunityViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      let location = CLLocationCoordinate2D(latitude: 41.450642,
             longitude: -82.706604)
        let span = MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)
        let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
        
        let organizations = [CommunityOrganization(name: "Humane Society", latitude: 41.437960, longtitude: -82.744210, phone: 4196266220),
     CommunityOrganization(name: "Ohio Veteran's Home", latitude: 41.418171, longtitude: -82.688538, phone: 4196252454),
     CommunityOrganization(name: "Nehemiah Partners of Sandusky", latitude: 41.445520, longtitude: -82.706300, phone: 4196099181)]
    
        fetchStadiumsOnMap(organizations)

    }
    
    func fetchStadiumsOnMap(_ organizations: [CommunityOrganization]) {
    for organization in organizations {
      let annotations = MKPointAnnotation()
      annotations.title = organization.name
      annotations.coordinate = CLLocationCoordinate2D(latitude:
        organization.latitude, longitude: organization.longtitude)
      mapView.addAnnotation(annotations)
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
}
