//
//  ViewController.swift
//  Med Deliver
//
//  Created by Supath Shrestha on 17/10/2018.
//  Copyright © 2018 Supath Shrestha. All rights reserved.
//


import UIKit
import MapKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var myMapView: MKMapView!
    
    @IBAction func searchButton(_ sender: Any)
    {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        //Ignoring user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //Activity Indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        //Hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Create the search request
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                print("ERROR")
            }
            else
            {
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.myMapView.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(coordinate, span)
                self.myMapView.setRegion(region, animated: true)
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createAnnotations(locations: annotationLocations)
        
        // Do any additional setup after loading the view.
        // annotate location(s)
    }
    let annotationLocations = [
        
         ["title": "University Medical Centre", "latitude": 51.296351, "longitude":1.062152],
        ["title": "Boots Pharmacy", "latitude":  51.274631, "longitude":1.084672],
        ["title": "Superdrug Pharmacy", "latitude":  51.278395, "longitude":1.082779],
        ["title": "Lloyds Pharmacy in Sainsburys", "latitude":  51.284997, "longitude":1.085479],
        ["title": "Morrisons Pharmacy", "latitude":  51.273057, "longitude":1.063127],
        ["title": "Asda Pharmacy", "latitude":  51.291392, "longitude":1.096899]
    ]
    
    // create annotation
    // [Dictionary<String,Any>] or [[String: Any]] works for argument type
    
    func createAnnotations(locations: [[String : Any]]) {
        for location in locations {
            let annotations = MKPointAnnotation()
            annotations.title = location["title"] as? String
            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees,
                                                            longitude: location["longitude"] as! CLLocationDegrees)
            
            myMapView.addAnnotation(annotations)
            
        }
    }
    
    
}






