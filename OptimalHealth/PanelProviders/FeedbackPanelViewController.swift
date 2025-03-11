//
//  FeedbackPanelViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 22/08/19.
//  Copyright © 2019 Oditek. All rights reserved.
//

import UIKit
import FloatRatingView
import Alamofire

@objc protocol FeedbackDelegate: class {
    @objc func updateList(selectedRow: Int, likeVal: String)
}

class FeedbackPanelViewController: BaseViewController, FloatRatingViewDelegate {
    
    @IBOutlet var floatRatingView: FloatRatingView!
    @IBOutlet var feedbackTextView: UITextView!
    @IBOutlet var btnSend: UIButton!
    @IBOutlet var viewContainer: UIView!
    
    var providerBo = PanelProvidersBo()
    var likeStatus = ""
    var starRating = ""
    var selectedRow = 0
    weak var delegate: FeedbackDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        initDesign()
        setupRatingView()
    }
    
    func initDesign(){
        feedbackTextView.layer.borderWidth = 1.0
        feedbackTextView.layer.cornerRadius = 5.0
        feedbackTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        btnSend.layer.cornerRadius = 5.0
        btnSend.clipsToBounds = true
        viewContainer.layer.cornerRadius = 10.0
        viewContainer.clipsToBounds = true
        btnSend.isEnabled = false
        btnSend.backgroundColor = UIColor.init(hexString: "BFBFBF") //Gray Clr
    }
    
    func setupRatingView(){
        floatRatingView.delegate = self
        floatRatingView.contentMode = UIView.ContentMode.scaleAspectFit
        floatRatingView.type = .wholeRatings
    }
    
    // MARK: FloatRatingViewDelegate
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        btnSend.backgroundColor = AppConstant.themeRedColor //Blue Clr
        btnSend.isEnabled = true
        starRating = String(Int(rating))
    }
    
    //MARK: Button ACtion
    @IBAction func btnSendAction(sender: AnyObject){
        self.serviceCallToUpdateFeedback()
    }
    @IBAction func outSidePopupAction(sender: AnyObject){
        self.backToParentPage()
    }
    
    func backToParentPage(){
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    //MARK: Servica Call Methods
    func serviceCallToUpdateFeedback(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            let params: Parameters = [
                "pstProvider_Code": self.providerBo.providerCode,
                "pstLike": self.likeStatus,
                "pstStar": starRating,
                "pstFeedback": feedbackTextView.text.trim()
            ]
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            
            print("Headers--- \(headers)")
            
            
            print("params===\(params)")
            print("url===\(AppConstant.postRateProviderUrl)")
//            
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
//            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
//            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request( AppConstant.postRateProviderUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                        //  debugPrint(dict)
                        
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToUpdateFeedback()
                                }
                            })
                        }else{
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){//success
                                    if let msg = dict?["Message"] as? String{
                                        self.delegate?.updateList(selectedRow: self.selectedRow, likeVal: self.likeStatus)
                                        self.backToParentPage()
                                        self.displayAlert(message: msg)
                                    }
                                    
                                }else{
                                    if let msg = dict?["Message"] as? String{
                                        self.backToParentPage()
                                        self.displayAlert(message: msg)
                                    }
                                    
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.postRateProviderUrl)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.postRateProviderUrl)
                        break
                        
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    //MARK: Alert Method
    func showAlert(msg: String){
        let alert = UIAlertController(title: msg, message: "", preferredStyle: .alert)
        alert.view.tintColor = AppConstant.themeGreenColor
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            self.delegate?.updateList(selectedRow: self.selectedRow, likeVal: self.likeStatus)
            self.backToParentPage()
        }))
        alert.view.tintColor = AppConstant.themeRedColor
        self.present(alert, animated: true, completion: nil)
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
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
