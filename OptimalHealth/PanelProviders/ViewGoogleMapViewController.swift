//
//  ViewGoogleMapViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/17/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewGoogleMapViewController: BaseViewController , GMSMapViewDelegate , CLLocationManagerDelegate {
    
    @IBOutlet weak var googleMapView: GMSMapView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    
    var latitude = ""
    var longitude = ""
    var locationManager = CLLocationManager()
    var arrLocations = [CLLocationCoordinate2D]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDesign()
    }
    
    func initDesign(){
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        latitude = AppConstant.selectedPanelProvider.latitude
        longitude = AppConstant.selectedPanelProvider.longitude
        self.createMarker(titleMarker: AppConstant.selectedPanelProvider.providerName, subTitleMarker: AppConstant.selectedPanelProvider.address, latitude: Double(latitude)!, longitude: Double(longitude)!)
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(latitude)! ,longitude: Double(longitude)! , zoom: 16)
        self.googleMapView.animate(to: camera)
        
        self.googleMapView?.isMyLocationEnabled = true
        
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Google Map Delegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            self.showAlertForLocationNotEnabled()
            return
        }
        locationManager.startUpdatingLocation()
        googleMapView.isMyLocationEnabled = true
        googleMapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        guard let lat = self.googleMapView.myLocation?.coordinate.latitude,
            let lng = self.googleMapView.myLocation?.coordinate.longitude else { return }
        let source = CLLocationCoordinate2DMake(lat, lng)
        let destination = CLLocationCoordinate2DMake(Double(latitude)!, Double(longitude)!)
        self.drawPath(startLocation: source, endLocation: destination)
        arrLocations.removeAll()
        arrLocations.append(source)
        arrLocations.append(destination)
        self.setBoundsForMap()
        
        locationManager.stopUpdatingLocation()
    }
    
    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                print(location)
                
                if error != nil {
                    print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                    return
                }
                
                if (placemarks!.count) > 0 {
                    let pm = placemarks?[0]
                    print("you are in city ->",String(describing: pm!.locality))
                    
                }
                else {
                    print("Problem with the data received from geocoder")
                }
            })
            
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
    // MARK: function for create a marker pin on map
    func createMarker(titleMarker: String, subTitleMarker: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.snippet = subTitleMarker
        //marker.icon = UIImage.init(named: "map_pin")
        marker.map = googleMapView
        self.googleMapView.selectedMarker = marker
    }
    
    //MARK: - Draw direction path, from start location to desination location
    func drawPath(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D)
    {
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let origin = "\(startLocation.latitude),\(startLocation.longitude)"
            let destination = "\(endLocation.latitude),\(endLocation.longitude)"
            
            let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(AppConstant.GoogleMapApiKey)"
            
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request(url).responseJSON { response in
                AppConstant.hideHUD()
                print(response.request as Any)  // original URL request
                print(response.response as Any) // HTTP URL response
                print(response.data as Any)     // server data
                print(response.result as Any)   // result of response serialization
                
                if let json = try? JSON(data: response.data!) {
                    let routes = json["routes"].arrayValue
                    print("Direction Response \(json)")
                    
                    // print route using Polyline
                    for route in routes
                    {
                        let arrlegs = route["legs"].arrayValue
                        let dict = arrlegs[0]
                        let distanceDict = dict["distance"].dictionary
                        let distance = distanceDict!["text"]?.string
                        print(distance as Any)
                        let durationDict = dict["duration"].dictionary
                        let duration = durationDict!["text"]?.string
                        print(duration as Any)
                        let routeOverviewPolyline = route["overview_polyline"].dictionary
                        let points = routeOverviewPolyline?["points"]?.stringValue
                        let path = GMSPath.init(fromEncodedPath: points!)!
                        let polyline = GMSPolyline.init(path: path)
                        polyline.strokeWidth = 3
                        polyline.strokeColor = AppConstant.colorWithHexString(hexString: "3C8391")
                        
                        polyline.map = self.googleMapView
                        
                    }
                }
                
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
        
    }
    
    // MARK: Set bounds for Map
    func setBoundsForMap() {
        googleMapView.clear()
        var bounds = GMSCoordinateBounds()
        for var i in (0..<arrLocations.count)
        {
            let location = arrLocations[i]
            
            let latitude = location.latitude
            let longitude = location.longitude
            let coordinate = CLLocationCoordinate2D(latitude:latitude, longitude:longitude)
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude:latitude, longitude:longitude)
            marker.map = self.googleMapView
            if i == 1 {
                marker.icon = GMSMarker.markerImage(with: UIColor.red)
                marker.title = AppConstant.selectedPanelProvider.providerName
                marker.snippet = AppConstant.selectedPanelProvider.address
                googleMapView.selectedMarker = marker
            }else{//Starting point
                marker.icon = GMSMarker.markerImage(with: UIColor.green)
            }
            
            bounds = bounds.includingCoordinate(coordinate)
        }
        let update = GMSCameraUpdate.fit(bounds, withPadding: 70)
        self.googleMapView.animate(with: update)
    }
    
    func showAlertForLocationNotEnabled(){
        let alert = UIAlertController(title: StringConstant.locationNotEnabledTitleMsg, message: StringConstant.noLocationDescMsg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { action in
            
            if let url = URL(string:UIApplication.openSettingsURLString)
            {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        alert.view.tintColor = AppConstant.themeRedColor
        self.present(alert, animated: true, completion: nil)
    }
    
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
