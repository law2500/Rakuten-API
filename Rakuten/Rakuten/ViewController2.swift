//
//  ViewController2.swift
//  Rakuten
//


import UIKit
import MapKit

class ViewController2: UIViewController {
    
    var latitude: Double?
    var longitude: Double?
    
    
    var jsonView: Itemr? {
        didSet{
             latitude = jsonView?.Item.latitude
             longitude = jsonView?.Item.longitude
        }
    }
    
    
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var mapApi: MKMapView!
    
    
    @IBOutlet weak var textLabel: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        textLabel.text = jsonView?.Item.golfCourseCaption
        label.text = jsonView?.Item.address
        
        let url = jsonView?.Item.golfCourseImageUrl
        let data = try! Data(contentsOf: url!)
        imageView.image = UIImage(data: data)
        imageView.layer.cornerRadius = 30
        
        setupMap()
       
        
    }
    
    fileprivate func setupMap() {
            // map center
        let lat = CLLocationDegrees(latitude ?? 0.0)
        let long = CLLocationDegrees(longitude ?? 0.0)
            let loc: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
            mapApi.setCenter(loc ,animated:true)

            // map region
            var region: MKCoordinateRegion = mapApi.region
            region.center = loc
            region.span.latitudeDelta = 0.01
            region.span.longitudeDelta = 0.01
            mapApi.setRegion(region,animated:true)
        }
    
    
}
