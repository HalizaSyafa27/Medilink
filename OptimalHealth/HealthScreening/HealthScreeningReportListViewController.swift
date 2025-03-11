//
//  HealthScreeningReportListViewController.swift
//  OptimalHealth
//
//  Created by tran ngoc nhan on 14/11/2023.
//  Copyright © 2023 Oditek. All rights reserved.
//

import UIKit
import DropDown

class HealthScreeningReportListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnSelectPageSize: UIButton!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtMonth: UITextField!
    @IBOutlet weak var tbvHealthScreeningReport: UITableView!
    @IBOutlet weak var headerTableView: UIView!
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var lblPageLenght: UILabel!
    
    let menu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "10",
            "20",
            "50",
            "All"
        ]
        return menu
    }()
    var strSelect: String = "All"
    var cardNo:String = ""
    var className:String = ""
    var model = HealthScreeningModel()
    var reportList = [HealthScreeningModel]()
    var monthObjList = [ProviderTypeModel]()
    var yearList = DropDown()
    var monthList = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        self.getYearService()
        self.getMonthService()
        self.postViewHraReportListService()
        
        self.lblYear.layer.cornerRadius = lblYear.layer.frame.height/2
        self.lblYear.layer.borderColor = UIColor.lightGray.cgColor
        self.lblYear.layer.masksToBounds = true
        self.lblYear.layer.borderWidth = 1.0
        self.lblMonth.layer.cornerRadius = lblYear.layer.frame.height/2
        self.lblMonth.layer.borderColor = UIColor.lightGray.cgColor
        self.lblMonth.layer.masksToBounds = true
        self.lblMonth.layer.borderWidth = 1.0
        self.changePageSize()
        self.selectYear()
        self.selectMonth()
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbvHealthScreeningReport.dequeueReusableCell(withIdentifier: "HealthScreeningReportListTableViewCell", for: indexPath) as! HealthScreeningReportListTableViewCell
        let data = self.reportList[indexPath.row]
        cell.lblDate.text = data.dateSubmitted
        
        cell.btnView.layer.cornerRadius = cell.btnView.layer.frame.height/2

        let tap1Gesture = GLApplicationStatusTapGestureRecognizer(target: self, action: #selector(viewSelector(sender:)))
        tap1Gesture.indexRowSelected = indexPath.row
        cell.btnView.isUserInteractionEnabled = true
        cell.btnView.addGestureRecognizer(tap1Gesture)
        
        return cell
    }
    
    @objc func viewSelector(sender: GLApplicationStatusTapGestureRecognizer) {
        let data = self.reportList[sender.indexRowSelected!]
        self.postViewHraReportDataService(pstMhId: data.hid ?? "")
    }
    
    
    @IBAction func onChangePageSizeAction(_ sender: UIButton) {
        menu.anchorView = self.btnSelectPageSize
        menu.bottomOffset = CGPoint(x: 0, y:(menu.anchorView?.plainView.bounds.height)!)
        menu.show()
    }
    
    func changePageSize(){
        self.menu.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lblPageLenght.text = item
            self.pageZise = item == "All" ? 0 : (Int(item) ?? 10)
            self.pageNumber = 1
            self.postViewHraReportListService()
        }
    }
    
    @IBAction func onSelectYearAction(_ sender: UIButton) {
        yearList.anchorView = self.txtYear
        yearList.bottomOffset = CGPoint(x: 0, y:(yearList.anchorView?.plainView.bounds.height)!)
        yearList.show()
    }
    
    func selectYear(){
        self.yearList.selectionAction = { [unowned self] (index: Int, item: String) in
            self.txtYear.text = item == self.strSelect ? "" : item
            self.postViewHraReportListService()
        }
    }
    
    @IBAction func onSelectMonthAction(_ sender: UIButton) {
        monthList.anchorView = self.txtMonth
        monthList.bottomOffset = CGPoint(x: 0, y:(monthList.anchorView?.plainView.bounds.height)!)
        monthList.show()
    }
    
    func selectMonth(){
        self.monthList.selectionAction = { [unowned self] (index: Int, item: String) in
            self.txtMonth.text = item == self.strSelect ? "" : item
            self.postViewHraReportListService()
        }
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    //MARK: Service Call
    func postViewHraReportListService(){
        let parameters = HealthScreeningParameters()
        parameters.pstMemID = model.MemId
        parameters.pstCardNo = model.CardNo
        parameters.pstYear = self.txtYear.text ?? ""
        let result = self.monthObjList.filter{ $0.fDesc == self.txtMonth.text ?? "" }
        parameters.pstMonth = result.count > 0 ? result[0].refCd : ""
        parameters.pstPageNo = self.pageNumber
        parameters.pstPageSize = self.pageZise
        self.reportList.removeAll()
        AppConstant.showHUD()
        HealthScreeningService.healthScreeningInstance.postViewHraReportListService(param: parameters) {
            result in
            self.reportList = result
            self.tbvHealthScreeningReport.reloadData()
            if result.count < 1{
                self.lblNoData.isHidden = false
            }else{
                self.lblNoData.isHidden = true
            }
            AppConstant.hideHUD()
          } onFailure: { (error) in
              self.displayAlert(message: error.localizedDescription)
              self.tbvHealthScreeningReport.reloadData()
              self.lblNoData.isHidden = false
              AppConstant.hideHUD()
        } onFailToken: {
            AppConstant.hideHUD()
            self.postViewHraReportListService()
        }
    }
    
    func postViewHraReportDataService(pstMhId:String){
        let parameters = HealthScreeningParameters()
        parameters.pstHid = pstMhId
        AppConstant.showHUD()
        HealthScreeningService.healthScreeningInstance.postViewHraReportDataService(param: parameters) {
            result in
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"ViewGLLettersViewController") as! ViewGLLettersViewController
            vc.className = self.className
            vc.strPdfBase64 = result
            self.navigationController?.pushViewController(vc, animated: true)
            AppConstant.hideHUD()
          } onFailure: { (error) in
              self.displayAlert(message: error.localizedDescription)
              AppConstant.hideHUD()
        } onFailToken: {
            AppConstant.hideHUD()
            self.postViewHraReportDataService(pstMhId: pstMhId)
        }
    }
    
    func getYearService(){
       AppConstant.showHUD()
        HealthScreeningService.healthScreeningInstance.getYearService(){
            result in
            self.yearList.dataSource.append(self.strSelect)
            for item in result{
                self.yearList.dataSource.append(item.fDesc ?? "")
            }
            AppConstant.hideHUD()
        } onFailure: { (error) in
            AppConstant.hideHUD()
            self.displayAlert(title: "Error", message: error.localizedDescription)
        } onFailToken: {
            AppConstant.hideHUD()
            self.getYearService()
        }
    }
    
    func getMonthService(){
       AppConstant.showHUD()
        HealthScreeningService.healthScreeningInstance.getMonthService(){
            result in
            self.monthObjList = result
            self.monthList.dataSource.append(self.strSelect)
            for item in result{
                self.monthList.dataSource.append(item.fDesc ?? "")
            }
            AppConstant.hideHUD()
        } onFailure: { (error) in
            AppConstant.hideHUD()
            self.displayAlert(title: "Error", message: error.localizedDescription)
        } onFailToken: {
            AppConstant.hideHUD()
            self.getMonthService()
        }
    }
}

class GLApplicationStatusTapGestureRecognizer: UITapGestureRecognizer {
    var indexRowSelected: Int?
}
