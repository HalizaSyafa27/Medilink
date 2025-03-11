//
//  HealthScreeningViewController.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 14/11/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import UIKit

class HealthScreeningViewController: BaseViewController {

    @IBOutlet weak var lblTitlePage: UILabel!
    @IBOutlet weak var lblButton1: UILabel!
    @IBOutlet weak var lblButton2: UILabel!
    @IBOutlet weak var lblButton3: UILabel!
    @IBOutlet weak var lblButton4: UILabel!
    @IBOutlet weak var lblTerm: UILabel!
    @IBOutlet weak var imgCheckTerm: UIImageView!
    @IBOutlet weak var imgButton1: UIImageView!
    @IBOutlet weak var imgButton2: UIImageView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    
    var cardNo:String = ""
    var className:String = ""
    var model = HealthScreeningModel()
    var model21 = HealthScreeningModel()
    var subMenuItem = MainMenuBo()
    var isCheckTerm:Bool = false
    let colorButton = UIColor(red: 0/255, green: 81/255, blue: 129/255, alpha: 1)
    
    override func viewDidAppear(_ animated: Bool) {
        self.getHealthRiskAssessmentByCardNoService()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        self.lblTitlePage.text = subMenuItem.FDESC
        self.lblButton1.layer.cornerRadius = 6
        self.lblButton1.layer.masksToBounds = true
        
        self.lblButton2.layer.cornerRadius = 6
        self.lblButton2.layer.masksToBounds = true
        
        self.lblButton3.layer.cornerRadius = 6
        self.lblButton3.layer.masksToBounds = true
        
        self.lblButton4.layer.cornerRadius = 6
        self.lblButton4.layer.masksToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.TermAndCondionAlert(_ :)))
        self.lblTerm.addGestureRecognizer(tap)
        self.lblTerm.isUserInteractionEnabled = true
    }
    
    @IBAction func langkah1Action(_ sender: UIButton) {
        if model.Langkah1Flag == "Y"{
            self.displayAlert(message: "Langkah 1 telah selesai sila sambung Langkah 2.")
        }else{
            if model.ulangDass21 == "Y" && model.UlangDass21btnStatus == "Y" && model.Mhid != ""{
                self.displayAlert(message: "Ulang borang dass21 is in progress and complte first before proceed to Langkah1.")
               
            }else{
                if isCheckTerm {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HealthStatusFormStoryboardID") as! HealthStatusFormViewController
                    vc.cardNo = self.cardNo
                    vc.className = self.className
                    vc.model = self.model
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.displayAlert(message: "Silakan membaca dan menyetujui  Syarat dan Ketentuan sebelum melanjutkan proses mengisi formulir.")
                }
            }
        }
    }
    
    
    @IBAction func langkah2Action(_ sender: UIButton) {
        if self.model.Langkah1Flag == "N"{
            self.displayAlert(message: "Sila lengkapkan langkah pertama dahulu.")
        }else{
            if isCheckTerm {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HealthyMindScreeningBeginStoryboardID") as! HealthyMindScreeningBeginViewController
                vc.cardNo = self.cardNo
                vc.className = self.className
                vc.model = self.model
                vc.isULangBorang = false
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                self.displayAlert(message: "Silakan membaca dan menyetujui  Syarat dan Ketentuan sebelum melanjutkan proses mengisi formulir.")
            }
        }
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func langkah3Action(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HealthScreeningReportListStoryboardID") as! HealthScreeningReportListViewController
        vc.cardNo = self.cardNo
        vc.className = self.className
        vc.model = self.model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func langkah4Action(_ sender: UIButton) {
        if (model.ulangDass21 == "N" && model.UlangDass21btnStatus == "Y" && model.Mhid != "") || (model.Langkah1Flag == "Y" && model.Langkah2Flag == "N" && model.Mhid != ""){
            self.displayAlert(message: "Langkah1 sedang dijalankan dan selesai dahulu sebelum meneruskan ke dass21.")
        }
        else {
            if isCheckTerm {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HealthyMindScreeningBeginStoryboardID") as! HealthyMindScreeningBeginViewController
                vc.cardNo = self.cardNo
                vc.className = self.className
                vc.model = self.model
                vc.isULangBorang = true
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                self.displayAlert(message: "Silakan membaca dan menyetujui  Syarat dan Ketentuan sebelum melanjutkan proses mengisi formulir.")
            }
        }
        
    }
    
    @IBAction func termAction(_ sender: UIButton) {
        isCheckTerm = !isCheckTerm
        if isCheckTerm {
            self.imgCheckTerm.image = UIImage(named: "checkbox_active")
        }else {
            self.imgCheckTerm.image = UIImage(named: "checkbox")
        }
    }
    
    @objc func TermAndCondionAlert(_ sender: UITapGestureRecognizer){
        let message:String = "\nAnda Menyetujui bahwa Medilink dapat mengumpulkan, menggunakan, dan mengakses data pribadi yang telah Anda berikan, untuk memberikan intervensi kepada gaya hidup sehat yang telah Anda setujui, atau untuk menganalisis dan mengkaji dalam bentuk program Personalized Health Management.\n\nData ini akan diperbarui di dalam Lembar Kerja Excel untuk analisis selanjutnya. Salinan formulir analisis akan dihapus setelah itu."
       
        let alertController = UIAlertController(title: "Syarat dan Ketentuan", message: message, preferredStyle: .alert)
        alertController.setTitle(font: UIFont.boldSystemFont(ofSize: 13), color: AppConstant.color1)
//        let rangeString:String = "\nPersetujuan Akta Perlindungan Data Peribadi (PDPA)"
//        alertController.setMessageTitle(font: UIFont.systemFont(ofSize: 12), color: UIColor.black, titleString: rangeString, fontTitle: UIFont.boldSystemFont(ofSize: 13), colorTitle: UIColor.black)
//        alertController.setBackgroudColor(color: UIColor.white)
        let actnOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(actnOk)
        self.present(alertController, animated: true, completion: nil)
      }
    
    func setControlPlayout(data:HealthScreeningModel){
        if model.ulangDass21 == "Y" && model.UlangDass21btnStatus == "Y" && model.Mhid != ""{
            lblButton1.backgroundColor = colorButton.withAlphaComponent(0.5)
        }else{
            lblButton1.backgroundColor = colorButton.withAlphaComponent(1)
        }
        if data.Langkah1Flag == "Y"{
            lblButton2.backgroundColor = colorButton.withAlphaComponent(1)
        }else{
            lblButton2.backgroundColor = colorButton.withAlphaComponent(0.5)
        }
        if data.UlangDass21btnStatus == "Y"{
            if model.ulangDass21 == "N" && model.Mhid != ""{
                lblButton4.backgroundColor = colorButton.withAlphaComponent(0.5)
            }else{
                lblButton4.backgroundColor = colorButton.withAlphaComponent(1)
            }
        }else{
            lblButton4.backgroundColor = colorButton.withAlphaComponent(0.5)
        }
        if data.Langkah1FlagColor == "Green" || data.Langkah1Flag == "Y"{
            imgButton1.image = UIImage(named: "tick")
            imgButton2.image = UIImage(named: "left_black")
            imgButton2.isHidden = false
        }else{
            imgButton1.image = UIImage(named: "left_black")
            imgButton2.isHidden = true
        }
    }
    
    //MARK: Service Call
    func getHealthRiskAssessmentByCardNoService(){
        let parameters = HealthScreeningParameters()
        parameters.pstMemID = AppConstant.retrievFromDefaults(key: StringConstant.memId)
        parameters.pstCardNo = AppConstant.retrievFromDefaults(key: StringConstant.cardNo)
        HealthScreeningService.healthScreeningInstance.getHealthRiskAssessmentByCardNoService(param: parameters) {
            result in
            self.model = result
            self.setControlPlayout(data:result)
            AppConstant.hideHUD()
          } onFailure: { (error) in
            self.displayAlert(title: "Alert", message: error.localizedDescription)
              AppConstant.hideHUD()
        } onFailToken: {
            AppConstant.hideHUD()
            self.getHealthRiskAssessmentByCardNoService()
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
