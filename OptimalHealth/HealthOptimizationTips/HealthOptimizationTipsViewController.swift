//
//  HealthOptimizationTipsViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 11/22/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class HealthOptimizationTipsViewController: BaseViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var healthTipsTableView: UITableView!
    @IBOutlet var imgViewHeader: UIImageView!
    @IBOutlet var lblHeader: UILabel!
    
    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    
    var arrHealthTips = [HealthTipsBo]()
    var selectedHealthTips = HealthTipsBo()
    var pageHeader = ""
    var imgHeader = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDesign()
    }
    
    func initDesign(){
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topViewHeightConstraint.constant = 92
        }
        
        imgViewHeader.image = UIImage.init(named: imgHeader)
        lblHeader.text = pageHeader
        serviceCallToGetHealthTipsData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHealthTips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HealthOptimizationTipsTableViewCell", for: indexPath as IndexPath) as! HealthOptimizationTipsTableViewCell
        cell.selectionStyle = .none
        
        let healthTipsBo = arrHealthTips[indexPath.row]
        cell.lblHealthTipsTitle?.text = healthTipsBo.title
        cell.imgViewHealthTips?.sd_setImage(with: URL(string: healthTipsBo.imagePath!), placeholderImage: UIImage(named: ""))
        
        let attributedText = NSMutableAttributedString(string: healthTipsBo.shortDesc! , attributes: [NSAttributedString.Key.font: UIFont.init(name: "Poppins-Regular", size: 13.0)!])
        attributedText.append(NSAttributedString(string: " MORE", attributes: [NSAttributedString.Key.font: UIFont.init(name: "Poppins-SemiBold", size: 14.0)!]))
        
        cell.lblHealthTipsDesc?.attributedText = attributedText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedHealthTips = arrHealthTips[indexPath.row]
        self.performSegue(withIdentifier: "health_tips_details", sender: self)
    }
    
    //MARK: Button Action
    @IBAction func btnHomeViewAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapOnMore(sender : MyTapGesture) {
        print(sender.title)
        guard let range = sender.title.range(of: " MORE")?.nsRange else {
            return
        }
        let indexPath = NSIndexPath(row: sender.tagVal, section: 0)
        let cell = self.healthTipsTableView.cellForRow(at: indexPath as IndexPath) as! HealthOptimizationTipsTableViewCell
        if sender.didTapAttributedTextInLabel(label: cell.lblHealthTipsDesc, inRange: range) {
            // Substring tapped
            selectedHealthTips = arrHealthTips[indexPath.row]
            self.performSegue(withIdentifier: "health_tips_details", sender: self)
        }
    }
    
    //MARK: Service Call
    func serviceCallToGetHealthTipsData(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            
            print("url===\(AppConstant.getHealthTipsUrl)")
            
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request( AppConstant.getHealthTipsUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    // debugPrint(response)
                    AppConstant.hideHUD()
                    
                    switch(response.result) {
                    case .success(_):
                        debugPrint(response.result.value!)
                        
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToGetHealthTipsData()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            //print(dict!)
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    if let arrHealthData = dict!["HealthtipsList"] as? [[String:Any]]{
                                        for dict in arrHealthData{
                                            let healthTipsBo = HealthTipsBo()
                                            if let path = dict["FullPath"] as? String{
                                                healthTipsBo.htmlPath = path
                                            }else{
                                                healthTipsBo.htmlPath = ""
                                            }
                                            if let title = dict["Title"] as? String{
                                                healthTipsBo.title = title
                                            }else{
                                                healthTipsBo.title = ""
                                            }
                                            if let shortDesc = dict["ShortDesc"] as? String{
                                                healthTipsBo.shortDesc = shortDesc
                                            }else{
                                                healthTipsBo.shortDesc = ""
                                            }
                                            if let imagePath = dict["ImagePath"] as? String{
                                                healthTipsBo.imagePath = imagePath
                                            }else{
                                                healthTipsBo.imagePath = ""
                                            }
                                            if let lastDate = dict["LastEditDate"] as? String{
                                                healthTipsBo.lastEditDate = lastDate
                                            }else{
                                                healthTipsBo.lastEditDate = ""
                                            }
                                            self.arrHealthTips.append(healthTipsBo)
                                        }
                                    }
                                    self.healthTipsTableView.reloadData()
                                }else{
                                    if let msg = dict!["Message"] as? String{
                                        self.displayAlert(message: msg ?? "")
                                    }else{
                                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.getHealthTipsUrl)
                                    }
                                }
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        let error = response.result.error!
                        print("error.localizedDescription===\(error.localizedDescription)")
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.getHealthTipsUrl)
                        break
                        
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func getHeightFromImage(path: String) -> CGFloat{
        let url = URL(string: path)
        let pixelHeight = 300
        if let imageSource = CGImageSourceCreateWithURL(url! as CFURL, nil) {
            
            if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary? {
                let pixelWidth = imageProperties[kCGImagePropertyPixelWidth] as! Int
                var pixelHeight = imageProperties[kCGImagePropertyPixelHeight] as! Int
                print("the image width is: \(pixelWidth)")
                print("the image height is: \(pixelHeight)")
                if (pixelHeight < 100){
                    pixelHeight = 300
                }
            }
        }
        return CGFloat(pixelHeight)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "health_tips_details") {
            let vc = segue.destination as! HealthOptimizationTipsDetailsViewController
            vc.selectedHealthTips = selectedHealthTips
            vc.isFromHealthTips =  true
            return
        }
        
    }
    
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

extension Range where Bound == String.Index {
    var nsRange:NSRange {
        return NSRange(location: self.lowerBound.encodedOffset,
                       length: self.upperBound.encodedOffset -
                        self.lowerBound.encodedOffset)
    }
}

class MyTapGesture: UITapGestureRecognizer {
    var title = String()
    var tagVal = Int()
}

extension UIImageView {
    public func imageFromURL(urlString: String) {
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        if self.image == nil{
            self.addSubview(activityIndicator)
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                activityIndicator.removeFromSuperview()
                let size = image?.size
                
                // Figure out what our orientation is, and use that to form the rectangle
                var newSize: CGSize
                newSize = CGSize(width: AppConstant.screenSize.width, height: 200)
                let rect = CGRect(x: 0, y: 0, width: AppConstant.screenSize.width, height: 200.0)
                
                // Actually do the resizing to the rect using the ImageContext stuff
                UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
                image?.draw(in: rect)
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                self.image = image
            })
            
        }).resume()
    }
}
