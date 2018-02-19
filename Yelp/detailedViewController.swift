//
//  detailedViewController.swift
//  Yelp
//
//  Created by Diego Medina on 2/16/18.
//  Copyright © 2018 Timothy Lee. All rights reserved.
//

// todo: left off on passing data from one view controller to another

import UIKit
import MapKit
import CoreLocation

class detailedViewController: UIViewController {

    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    var backdropImageViewURL = URL(string: "google.com")
    var nameStr = String()
    var ratingImageViewURL = URL(string: "google.com")
    var reviewsCountLabelStr = NSNumber()
    var priceLabelStr = String()
    var mapViewStr = String()
    var distanceStr = String()
    var addressStr = String()
    var categoriesStr = String()
    var lat = 0.0
    var lon = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backdropImageView.setImageWith(backdropImageViewURL!)
        nameLabel.text = nameStr
        ratingImageView.setImageWith(ratingImageViewURL!)
        distanceLabel.text = distanceStr
        addressLabel.text = addressStr
        categoriesLabel.text = categoriesStr
        
        
        // address to location
        var geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(addressStr) {
            placemarks, error in
            let placemark = placemarks?.first
            self.lat = (placemark?.location?.coordinate.latitude)!
            self.lon = (placemark?.location?.coordinate.longitude)!
            print("Lat: \(self.lat), Lon: \(self.lon)")
        }
        
        // map
        let centerLocation = CLLocation( latitude: self.lat, longitude: self.lon)
        goToLocation(location: centerLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToLocation( location: CLLocation ){
        
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
