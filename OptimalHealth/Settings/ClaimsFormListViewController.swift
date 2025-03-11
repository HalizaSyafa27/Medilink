//
//  ClaimsFormListController.swift
//  OptimalHealth
//
//  Created by Dinh Van Tin on 13/09/2022.
//  Copyright © 2022 Oditek. All rights reserved.
//

import Alamofire

class ClaimsFormListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var lblPageHeader: UILabel!
    @IBOutlet weak var iconHeader: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var tblViewMagazine: UITableView!
    @IBOutlet weak var lblNoDataAvailable: UILabel!
    
    var arrMagazine = [MagazineBo]()
    var pageHeader = ""
    var strHeaderImageName = ""
    var className = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDesign()
        serviceCallToGetClaimsFormList()
    }
    
    func initDesign(){
        self.lblNoDataAvailable.isHidden = true
        lblPageHeader.text = pageHeader
        iconHeader.image = UIImage.init(named: strHeaderImageName)
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
    }
    
    //MARK: Table View Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.arrMagazine.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClaimsFormTableViewCell", for: indexPath as IndexPath) as! ClaimsFormTableViewCell
           let mainMenu = self.arrMagazine[indexPath.row]
           cell.lblMenuTitle.text = mainMenu.desc
           return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DownloadClaimFormsID") as! DownloadClaimFormsViewController
        vc.className =  self.className
        vc.fileName = self.arrMagazine[indexPath.row].filename
        vc.pageTitle = self.pageHeader
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Service call
    func serviceCallToGetClaimsFormList(){
            if(AppConstant.hasConnectivity()) {
                if(AppConstant.hasConnectivity()) {//true connected
                    AppConstant.showHUD()
                    let headers: HTTPHeaders = [
                        "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                        "Accept": "application/json"
                    ]
                    print("url===\(AppConstant.webmdHealthMagazineUrl)")
                    Alamofire.request( AppConstant.getListClaimFormFileUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
                        .responseString { response in
                            AppConstant.hideHUD()
                            debugPrint(response)
                            switch(response.result) {
                            case .success(_):
                                let dict = AppConstant.convertToDictionary(text: response.result.value!)
                                let headerStatusCode : Int = (response.response?.statusCode)!
                                print("Status Code: \(headerStatusCode)")
                                if(headerStatusCode == 401){//Session expired
                                    AppConstant.hideHUD()
                                    self.isTokenVerified(completion: { (Bool) in
                                        if Bool{
                                            self.serviceCallToGetClaimsFormList()
                                        }
                                    })
                                }else{
                                    if let status = dict?["Status"] as? String {
                                        if(status == "1"){//Success
                                            self.arrMagazine.removeAll()
                                            let arrQstn = dict?["DownloadList"] as! [[String: Any]]
                                            if (arrQstn.count > 0){
                                                for dict in arrQstn {
                                                    let qstnBo = MagazineBo()
                                                    if let qstnId = dict["FILENAME"] as? String{
                                                        qstnBo.filename = qstnId
                                                    }
                                                    if let qstnName = dict["FILENAME"] as? String{
                                                        qstnBo.desc = qstnName
                                                    }
                                                    self.arrMagazine.append(qstnBo)
                                                }
                                                self.tblViewMagazine.reloadData()
                                                self.lblNoDataAvailable.isHidden = true
                                            }else{
                                                self.lblNoDataAvailable.isHidden = false
                                                self.tblViewMagazine.isHidden = true
                                            }
                                        }else{
                                            self.lblNoDataAvailable.isHidden = false
                                            if let msg = dict?["Message"] as? String{
                                                self.displayAlert(message: msg )
                                            }
                                        }
                                    }else{
                                        self.lblNoDataAvailable.isHidden = false
                                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.getListClaimFormFileUrl)
                                    }
                                }
                                break
                            case .failure(_):
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.getListClaimFormFileUrl)
                                break
                            }
                    }
                }else{
                    self.displayAlert(message: "Please check your internet connection.")
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

