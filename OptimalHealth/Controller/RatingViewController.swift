//
//  RatingViewController.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 23/11/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import UIKit
import Alamofire

class RatingViewController: BaseViewController {
    
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgViewPageHeader: UIImageView!
    @IBOutlet weak var lblTitleHeader: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblVisitDate: UILabel!
    @IBOutlet weak var lblClaimId: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var btnStar1: UIButton!
    @IBOutlet weak var btnStar2: UIButton!
    @IBOutlet weak var btnStar3: UIButton!
    @IBOutlet weak var btnStar4: UIButton!
    @IBOutlet weak var btnStar5: UIButton!
    
    @IBOutlet weak var imgStar1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    
    @IBOutlet weak var desView: UIView!
    @IBOutlet weak var txtDes: UITextView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var infoView: UIView!
    
    var placeholderLabel : UILabel!
    var className:String = ""
    var strTitleHeader: String = ""
    var model:ClaimBo?
    var numberStar: Int = 0
    var strPageTitle:String = ""
    var pageHeaderImage:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if (AppConstant.screenSize.height >= 812) {
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        lblTitle.text = strPageTitle
        self.imgViewPageHeader.image = UIImage.init(named: pageHeaderImage)
        if self.className == "PANEL_PROVIDER"{
            lblClaimId.isHidden = true
            lblVisitDate.isHidden = true
            infoView.isHidden = true
            lblTitleHeader.text = strTitleHeader
            lblName.text = model?.providerName
        }else{
            lblTitleHeader.text = strTitleHeader
            lblName.text = model?.providerName
            lblClaimId.text = model?.claimId
            lblVisitDate.text = model?.admissionDate
        }
        
        self.desView.layer.cornerRadius = 4
        self.desView.layer.masksToBounds = true
        self.desView.layer.borderColor = UIColor.lightGray.cgColor
        self.desView.layer.borderWidth = 1.0
        
        self.btnNext.layer.cornerRadius = self.btnNext.frame.size.height/2
        if model?.ratingID != "" && model?.ratingID != nil{
            postViewRatingbyClaimIdServices()
            txtDes.isEditable = false
            btnNext.setTitle("CLOSE", for: .normal)
        }else{
            txtDes.delegate = self
            placeholderLabel = UILabel()
            placeholderLabel.text = "Share details of your own experience at this place"
            placeholderLabel.font = .italicSystemFont(ofSize: (txtDes.font?.pointSize)!)
            placeholderLabel.sizeToFit()
            txtDes.addSubview(placeholderLabel)
            placeholderLabel.frame.origin = CGPoint(x: 5, y: (txtDes.font?.pointSize)! / 2)
            placeholderLabel.textColor = UIColor.lightGray
            placeholderLabel.isHidden = !txtDes.text.isEmpty
        }
    }
    
    @IBAction func btnGoHomeAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    var star1: Bool = false
    @IBAction func star1Action(_ sender: UIButton)
    {
        if self.model?.ratingID == "" || model?.ratingID == nil{
            imgStar2.image = UIImage(named: "starempty.png")
            imgStar3.image = UIImage(named: "starempty.png")
            imgStar4.image = UIImage(named: "starempty.png")
            imgStar5.image = UIImage(named: "starempty.png")
            star2 = false
            star3 = false
            star4 = false
            star5 = false
            star1 = !star1
            if star1 {
                numberStar = 1
                imgStar1.image = UIImage.init(named: "star_custom.png")
            }else{
                imgStar1.image = UIImage.init(named: "starempty.png")
                numberStar = 0
            }
        }
    }
    
    var star2: Bool = false
    @IBAction func star2Action(_ sender: UIButton) {
        if self.model?.ratingID == "" || model?.ratingID == nil{
            imgStar3.image = UIImage(named: "starempty.png")
            imgStar4.image = UIImage(named: "starempty.png")
            imgStar5.image = UIImage(named: "starempty.png")
            star1 = true
            star3 = false
            star4 = false
            star5 = false
            star2 = !star2
            if star2 {
                numberStar = 2
                imgStar1.image = UIImage.init(named: "star_custom.png")
                imgStar2.image = UIImage.init(named: "star_custom.png")
            }else{
                numberStar = 1
                imgStar2.image = UIImage.init(named: "starempty.png")
            }
        }
    }
    
    var star3: Bool = false
    @IBAction func star3Action(_ sender: UIButton) {
        if self.model?.ratingID == "" || model?.ratingID == nil{
            imgStar4.image = UIImage(named: "starempty.png")
            imgStar5.image = UIImage(named: "starempty.png")
            star1 = true
            star2 = true
            star4 = false
            star5 = false
            star3 = !star3
            if star3 {
                numberStar = 3
                imgStar1.image = UIImage.init(named: "star_custom.png")
                imgStar2.image = UIImage.init(named: "star_custom.png")
                imgStar3.image = UIImage.init(named: "star_custom.png")
            }else{
                numberStar = 2
                imgStar3.image = UIImage.init(named: "starempty.png")
            }
        }
    }
    
    var star4: Bool = false
    @IBAction func star4Action(_ sender: UIButton) {
        if self.model?.ratingID == "" || model?.ratingID == nil{
            imgStar5.image = UIImage(named: "starempty.png")
            star1 = true
            star2 = true
            star3 = true
            star5 = false
            star4 = !star4
            if star4 {
                numberStar = 4
                imgStar1.image = UIImage.init(named: "star_custom.png")
                imgStar2.image = UIImage.init(named: "star_custom.png")
                imgStar3.image = UIImage.init(named: "star_custom.png")
                imgStar4.image = UIImage.init(named: "star_custom.png")
            }else{
                numberStar = 3
                imgStar4.image = UIImage.init(named: "starempty.png")
            }
        }
    }
    
    var star5: Bool = false
    @IBAction func star5Action(_ sender: UIButton) {
        if self.model?.ratingID == "" || model?.ratingID == nil{
            star1 = true
            star2 = true
            star3 = true
            star4 = true
            star5 = !star5
            if star5 {
                numberStar = 5
                imgStar1.image = UIImage.init(named: "star_custom.png")
                imgStar2.image = UIImage.init(named: "star_custom.png")
                imgStar3.image = UIImage.init(named: "star_custom.png")
                imgStar4.image = UIImage.init(named: "star_custom.png")
                imgStar5.image = UIImage.init(named: "star_custom.png")
            }else{
                numberStar = 4
                imgStar5.image = UIImage.init(named: "starempty.png")
            }
        }
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        if model?.ratingID != ""{
            self.navigationController?.popViewController(animated: true)
        }else{
            if self.numberStar <= 0 {
                self.displayAlert(title: "", message: "Please select a Rating.")
            }
            else if self.txtDes.text == "" {
                self.displayAlert(title: "", message: "Please enter Remarks.")
            }else{
                let uploadFileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UploadFileViewController") as! UploadFileViewController
                uploadFileVC.className = className
                uploadFileVC.pageTitle = strPageTitle
                uploadFileVC.pageHeader = strTitleHeader
                uploadFileVC.rating = numberStar
                uploadFileVC.visitDate = model?.admissionDate ?? ""
                uploadFileVC.providerCode = model?.providerCode ?? ""
                uploadFileVC.strClaimId = model?.claimId ?? ""
                uploadFileVC.ratingRemarks = txtDes.text ?? ""
                self.navigationController?.pushViewController(uploadFileVC, animated: true)
            }
        }
    }
    
    // MARK: - Call Services
    func postViewRatingbyClaimIdServices(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let url = AppConstant.postViewRatingbyClaimId
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            let pstMemID:String = AppConstant.retrievFromDefaults(key: StringConstant.memId)
            let requestParams: Parameters = [
                "pstMemID": pstMemID ,
                "pstClaimID": model?.claimId ?? "",
                "pstRatingID": model?.ratingID ?? ""
            ]
            print("params===\(requestParams)")
            print("url===\(url)")
            Alamofire.request( url, method: .post, parameters: requestParams, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.postViewRatingbyClaimIdServices()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){
                                    if let objInfo = dict?["ViewRatingData"] as? [String: Any]{
                                        if let star = objInfo["Star"] as? Int{
                                            if star  > 0{
                                                self.imgStar1.image = UIImage.init(named: "star_custom.png")
                                            }
                                            if star  > 1{
                                                self.imgStar2.image = UIImage.init(named: "star_custom.png")
                                            }
                                            if star  > 2{
                                                self.imgStar3.image = UIImage.init(named: "star_custom.png")
                                            }
                                            if star  > 3{
                                                self.imgStar4.image = UIImage.init(named: "star_custom.png")
                                            }
                                            if star > 4{
                                                self.imgStar5.image = UIImage.init(named: "star_custom.png")
                                            }
                                        }
                                        if let ratingRemarks = objInfo["RatingRemarks"] as? String{
                                            self.txtDes.text = ratingRemarks
                                        }
                                    }
                                    
                                }else{
                                    //Failure
                                    if let msg = dict?["Message"] as? String{
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: url)
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.imageUploadStartTime = nil
                        AppConstant.showNetworkAlertMessage(apiName: url)
                        break
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
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

extension RatingViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel?.isHidden = !textView.text.isEmpty
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderLabel?.isHidden = !textView.text.isEmpty
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel?.isHidden = true
    }
}
