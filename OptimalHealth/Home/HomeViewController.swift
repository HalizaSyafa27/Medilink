
//  HomeViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 27/01/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import SWXMLHash
import DropDown

class HomeViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ChooseDelegate, XMLParserDelegate {

    @IBOutlet weak var heightConstraintNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintTopBar: NSLayoutConstraint!
    @IBOutlet weak var imgViewUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblAddCartCount: UILabel!
    @IBOutlet weak var collectionViewHealthTips: UICollectionView!
    @IBOutlet weak var collectionViewMenuItems: UICollectionView!
    @IBOutlet weak var collectionViewDealsOffers: UICollectionView!
    @IBOutlet weak var collectionViewButtonMenuItems: UICollectionView!
    @IBOutlet weak var viewbuttomMenu: UIView!
    @IBOutlet weak var lblNoDataFound: UILabel!
    @IBOutlet weak var heightConstraintHealthTipsView: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintDynamicMenuView: NSLayoutConstraint!
    @IBOutlet weak var heightConstraintDealsOffersView: NSLayoutConstraint!
    @IBOutlet weak var viewHealthTips: UIView!
    @IBOutlet weak var viewDynamicMenu: UIView!
    @IBOutlet weak var viewDealsOffers: UIView!
    @IBOutlet weak var viewColorhealthtips: UIView!
    @IBOutlet weak var imgViewVirtualCard: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewWelcome: UIView!
    
    @IBOutlet weak var viewTitleHealthTips: CustomView!
    @IBOutlet weak var viewTitleDealsOffer: UIView!
    @IBOutlet weak var viewLatestnews: CustomView!
    @IBOutlet weak var viewProducts: UIView!
    @IBOutlet weak var viewProductsDealsOfferContainer: UIView!
    @IBOutlet weak var viewProductsDealsOfferContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblMyVirtualCardTitle: UIView!
    @IBOutlet var lblMessageUnreadCount: UILabel!
    
    @IBOutlet weak var lblHealthTips: UILabel!
    @IBOutlet weak var lblLatestNews: UILabel!
    @IBOutlet weak var viewBottomHealthTips: UIView!
    @IBOutlet weak var viewBottomLatestNews: UIView!
    @IBOutlet weak var viewCovid19: UIView!
    @IBOutlet weak var viewFitness: UIView!
    @IBOutlet weak var viewBottomFitness: UIView!
    @IBOutlet weak var lblSelectPlan: UILabel!
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var planSelectionView: UIView!
    @IBOutlet weak var heightPlanSelectionViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightWelcomeViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollViewMain: UIScrollView!
    var arrHealthTips = [HealthTipsBo]()
    var arrDealsOffers = [HelthTipsDealsOffresBo]()
    var arrMenus = [MainMenuBo]()
    var selectedHealthTips = HealthTipsBo()
    var isViewDynamicScrollable = false
    
    var allHomeMenus:[String]! = []
    var allHomeMenuImages:[String]!
    let itemsPerRow: CGFloat = 3
    let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    var userType : String = ""
    var arrPolicyDetails = [PolicyDetailsBo]()
    
    var selectedPolicy = PolicyDetailsBo()
    var selectedMenu = MainMenuBo()
    var className = ""
    var memberDetailsbo = MemberBo()
    var dataSource = [CustomObject]()
    var selectedSubMenu = [SubMenuBo]()
    var surrPage:Int = 1
    var currentVisiblePolicyCell = 0
    var isPolicyChanged = false
    var isDynamicMenu = true
    var prevPolicyCell:Int = 0
    var roleDesc = ""
    var arrBottomMenu = [MainMenuBo]()
    var arrVirtualCard = [VirtualCardBo]()
    var virtualcardWidth: CGFloat = 0.0
    var virtualcardHeight: CGFloat = 0.0
    var unreadMessagesCount = 0
    var unreadHealthAdvisoryCount = 0
    var strHeaderImageName = "ic_etiqapanel_white"
    var menuCellheight: CGFloat = 40.0
    var isFromHomePage = false
    var isDidLoadCalled = false
    var isHealthTipsSelected = true
    
    var arrNews = [News]()
    var arrNewsBackup = [News]()
    var elementName: String = String()
    var newstitle = String()
    var desc = String()
    var pubDate = String()
    var selectedNewsBo = News()
    let heightConstraintMenuItem: CGFloat = 87.5
    var heightConstraintOut: CGFloat = 140
    var isMenuListApiLoaded: Bool = false
    var isWHOApiLoaded: Bool = false
    var newsCount: Int = 0
    var bgTask = UIBackgroundTaskIdentifier(rawValue: 0)
    var currentTime: Date?
    var arrPlanOption = [PolicyDetailsBo]()
    let menu: DropDown = {
        let menu = DropDown()
        return menu
    }()
    var phoneNumber = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollViewMain.isScrollEnabled = false
        self.getPlanOption()
        self.initDesign()
        self.enableSwipeToBack()
//        bgTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
//            UIApplication.shared.endBackgroundTask(self.bgTask)
//        })
//        let timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(notificationReceived), userInfo: nil, repeats: true)
//        RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
        //Get data option for plan
        self.heightPlanSelectionViewConstraint.constant = 0
        self.heightWelcomeViewConstraint.constant = 110
        self.planSelectionView.isHidden = true
        self.selectView.layer.borderColor = UIColor.systemGray.cgColor
        self.selectView.layer.borderWidth = 1
        self.selectView.layer.cornerRadius = 10
        self.changeSelectPlan()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.getProfileImage()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        isDynamicMenu = true
        //loadRSS()
        //Update unread message count
        updateUnreadMessageCount()
        //update Profile Data
        let username = AppConstant.retrievFromDefaults(key: StringConstant.displayName) == "" ? AppConstant.retrievFromDefaults(key: StringConstant.name) : AppConstant.retrievFromDefaults(key: StringConstant.displayName)
        lblUserName.text = "Welcome back \(username)"
        
        let profileImgStr = AppConstant.retrievFromDefaults(key: StringConstant.profileImageUrl)
        if profileImgStr != ""{
            if let data = Data(base64Encoded: profileImgStr) {
                let image = UIImage(data: data)
                self.imgViewUser.image = image
            }
        }else{
            self.imgViewUser.image = UIImage.init(named: "userGray")
        }
        
        //Show Large Profile pic
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.showprofileImage(_:)))
        self.imgViewUser.addGestureRecognizer(tap)
        self.imgViewUser.isUserInteractionEnabled = true
        
        if ((self.arrMenus.count == 0) && (isDidLoadCalled == false)) {// Agent
            AppConstant.isAppOpenedFromCallReceived = false
            self.loadRSS()
            self.serviceCallToGetDynamicMenu()
        }
        
        //Show Health tips
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.showHealthTips(_:)))
        self.viewTitleHealthTips.addGestureRecognizer(tap2)
        self.viewTitleHealthTips.isUserInteractionEnabled = true
        
        //Show Large Profile pic
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.showLatestNews(_:)))
        self.viewLatestnews.addGestureRecognizer(tap3)
        self.viewLatestnews.isUserInteractionEnabled = true
        
        //Show Covid 19
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(self.showCovid19))
        self.viewCovid19.addGestureRecognizer(tap4)
        self.viewCovid19.isUserInteractionEnabled = true
        
        //Show self Doctor
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(self.showFitness(_:)))
        self.viewFitness.addGestureRecognizer(tap5)
        self.viewFitness.isUserInteractionEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isDidLoadCalled = false
    }
    
    func initDesign(){
        isDidLoadCalled = true
        print("Screen Size: \(AppConstant.screenSize.height)")
        print("Nav Bar Height: \(AppConstant.navBarHeight)")
        if (AppConstant.screenSize.height >= 812) {
            heightConstraintNavBar.constant = AppConstant.navBarHeight
            heightConstraintTopBar.constant = AppConstant.navBarHeight
            self.heightConstraintOut = 162
         }
        
        //Dashboard ApiCall
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.authorizeHealthKit()
        }
        
        //Message Count
        lblMessageUnreadCount.layer.cornerRadius = lblMessageUnreadCount.frame.size.width / 2
        lblMessageUnreadCount.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(virtualCardAction))
          imgViewVirtualCard.addGestureRecognizer(tap)
          imgViewVirtualCard.isUserInteractionEnabled = true
        
        showHideDymamicMenuContainerViews()
        
        roleDesc = AppConstant.retrievFromDefaults(key: StringConstant.roleDesc)
        
        lblNoDataFound.isHidden = true
        
        let username = AppConstant.retrievFromDefaults(key: StringConstant.displayName)
        lblUserName.text = "Welcome back \(username)"
        
        self.imgViewUser.layer.cornerRadius = self.imgViewUser.frame.height/2
        self.imgViewUser.layer.cornerRadius = self.imgViewUser.frame.width/2
        self.imgViewUser.layer.borderWidth = 1.5
        self.imgViewUser.layer.borderColor = AppConstant.themeRedColor.cgColor
        self.imgViewUser.clipsToBounds = true
        
        let profileImgStr = AppConstant.retrievFromDefaults(key: StringConstant.profileImageUrl)
        if profileImgStr != ""{
            if let data = Data(base64Encoded: profileImgStr) {
                let image = UIImage(data: data)
                self.imgViewUser.image = image
            }
        }
        
        self.viewbuttomMenu.addTopBorder(AppConstant.themeSeparatorGrayColor, height: 1.0)

        self.lblAddCartCount.layer.cornerRadius = self.lblAddCartCount.frame.height/2
        self.lblAddCartCount.layer.cornerRadius = self.lblAddCartCount.frame.width/2
        self.lblAddCartCount.clipsToBounds = true
                
        collectionViewHealthTips.delegate = self
        collectionViewMenuItems.delegate = self
        collectionViewDealsOffers.delegate = self
        collectionViewButtonMenuItems.delegate = self

        collectionViewHealthTips.dataSource = self
        collectionViewMenuItems.dataSource = self
        collectionViewDealsOffers.dataSource = self
        collectionViewButtonMenuItems.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateUnreadMessageCount), name: NSNotification.Name(rawValue: StringConstant.updateNotificationCount), object: nil)
        
        //set Initial Height for collection views
//        heightConstraintHealthTipsView.constant = 0
//        heightConstraintDynamicMenuView.constant = 0
//        heightConstraintDealsOffersView.constant = 0
        
        userType = AppConstant.retrievFromDefaults(key: StringConstant.memberType)
        if (userType == "2"){//Hide for NonMedilinkMember
            lblMyVirtualCardTitle.isHidden = true
            imgViewVirtualCard.isHidden = true
        }
                
    }
    @IBAction func tapSelectPlan(_ sender: UITapGestureRecognizer) {
        menu.anchorView = self.selectView
        menu.bottomOffset = CGPoint(x: 0, y:(menu.anchorView?.plainView.bounds.height)!)
        menu.show()
    }
    
    func changeSelectPlan(){
        self.menu.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lblSelectPlan.text = item
            let result = self.arrPlanOption[index]
            AppConstant.saveInDefaults(key: StringConstant.cardNo, value: result.cardNo)
            AppConstant.saveInDefaults(key: StringConstant.planCode, value: result.planCode)
            AppConstant.saveInDefaults(key: StringConstant.payorCode, value: result.payorCode)
            AppConstant.saveInDefaults(key: StringConstant.corpDesc, value: result.corpCode)
            AppConstant.saveInDefaults(key: StringConstant.policyNo, value: result.policyNo)
            AppConstant.saveInDefaults(key: StringConstant.roleDesc, value: result.roleDesc)
            AppConstant.saveInDefaults(key: StringConstant.role, value: result.role)
            self.roleDesc = result.roleDesc
            self.serviceCallToGetDynamicMenu()
        }
    }
    
    func enableSwipeToBack(){
        //Enable left swipe to back
       self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
       self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

    }
    
    func showHideDymamicMenuContainerViews(){
        viewTitleHealthTips.isHidden = true
        viewColorhealthtips.isHidden = true
        viewHealthTips.isHidden = true
        viewLatestnews.isHidden = true
        
        viewDynamicMenu.isHidden = true
        
        viewProductsDealsOfferContainer.isHidden = true
        viewDealsOffers.isHidden = true
        
        viewbuttomMenu.isHidden = true
        
        heightConstraintDealsOffersView.constant = 0
        viewProductsDealsOfferContainerHeightConstraint.constant = 0
    }
    
//    func menuListForCorporate() {
//        var menuBo = MainMenuBo()
//        menuBo.FDESC = "Panel Providers"
//        menuBo.OBJID = "MBAM0010"
//        menuBo.Image = "ic_etiqapanel.png"
//        self.arrMenus.append(menuBo)
//        
//        menuBo = MainMenuBo()
//        menuBo.FDESC = "My Today Hospital Admission/Discharge"
//        menuBo.OBJID = "MBAM0020"
//        menuBo.Image = "hospital_adimission_discharge.png"
//        self.arrMenus.append(menuBo)
//        
//        menuBo = MainMenuBo()
//        menuBo.FDESC = "Policy Holder"
//        menuBo.OBJID = "MBAM0030"
//        menuBo.Image = "policy_holder.png"
//        self.arrMenus.append(menuBo)
//        
//        menuBo = MainMenuBo()
//        menuBo.FDESC = "Policy Holder Health Record"
//        menuBo.OBJID = "MBAM0040"
//        menuBo.Image = "policy_holder_health_record.png"
//        
//        var subMenuBo = SubMenuBo()
//        subMenuBo.FDESC = "GL"
//        subMenuBo.OBJID = "gl_policy_holder_health_record"
//        subMenuBo.Image = "ic_myhrecord.png"
//        menuBo.arrSubMenu.append(subMenuBo)
//        
//        subMenuBo = SubMenuBo()
//        subMenuBo.FDESC = "Claims"
//        subMenuBo.OBJID = "claims_policy_holder_health_record"
//        subMenuBo.Image = "ic_myhrecord.png"
//        menuBo.arrSubMenu.append(subMenuBo)
//        self.arrMenus.append(menuBo)
//        
//        menuBo = MainMenuBo()
//        menuBo.FDESC = "Messages"
//        menuBo.OBJID = "MBMA0070"
//        menuBo.Image = "messages.png"
//        self.arrMenus.append(menuBo)
//        
//        menuBo = MainMenuBo()
//        menuBo.FDESC = "Hospital Admission Guide"
//        menuBo.OBJID = "MBMA0080"
//        menuBo.Image = "ic_hag.png"
//        self.arrMenus.append(menuBo)
//    }
    
//    func subMenuListForCorporate() {
//        let menuBo = MainMenuBo()
//        var subMenuBo = SubMenuBo()
//        subMenuBo.FDESC = "GL"
//        subMenuBo.OBJID = "gl_policy_holder_health_record"
//        subMenuBo.Image = "ic_myhrecord.png"
//        menuBo.arrSubMenu.append(subMenuBo)
//        
//        subMenuBo = SubMenuBo()
//        subMenuBo.FDESC = "Claims"
//        subMenuBo.OBJID = "claims_policy_holder_health_record"
//        subMenuBo.Image = "ic_myhrecord.png"
//        menuBo.arrSubMenu.append(subMenuBo)
//    }
    
    func setRoleDetails(atIndex:Int){
        selectedPolicy = self.arrPolicyDetails[atIndex]
        
        AppConstant.saveInDefaults(key: StringConstant.planCode, value: selectedPolicy.planCode)
        AppConstant.saveInDefaults(key: StringConstant.cardNo, value: selectedPolicy.cardNo)
        AppConstant.saveInDefaults(key: StringConstant.roleDesc, value: selectedPolicy.roleDesc)
        AppConstant.saveInDefaults(key: StringConstant.corpDesc, value: selectedPolicy.corpCode)
        AppConstant.memberType = selectedPolicy.roleDesc
        roleDesc = selectedPolicy.roleDesc
        
        if (self.arrPolicyDetails.count > 0){
//            lblPolicyCode.text = selectedPolicy.policyNo
//            lblPlanCode.text = selectedPolicy.planCode
//            lblPlanName.text = selectedPolicy.shortName
//            lblPlanVersion.text = selectedPolicy.planVersion
        }
        
        if(self.arrPolicyDetails.count < 2){
            //self.viewPolicyDetailsHeightConstraint.constant = 0
            //viewPolicyDetails.isHidden = true
        }else{
            //self.viewPolicyDetailsHeightConstraint.constant = 90
            //viewPolicyDetails.isHidden = false
        }
        
        if currentVisiblePolicyCell == 0 {
        }else{
        }
        
        if currentVisiblePolicyCell == self.arrPolicyDetails.count - 1 {
        }else{
        }
        
        if isPolicyChanged == true{
            self.serviceCallToGetDynamicMenu()
        }
        
        print("Saving Role Details")
        
    }
    
    //MARK:- Button Action
    @objc func virtualCardAction(){
        className = StringConstant.virtualCard
        self.selectedMenu.Image = "ic_virtual_card.png"
        self.performSegue(withIdentifier: "virtual_card_screen", sender: self)
        
    }
    
    @IBAction func btnSettingAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "home_setting", sender: self)
    }
    
    @IBAction func btnHomeAction(_ sender: UIButton) {
        
        collectionViewHealthTips.reloadData()
        collectionViewMenuItems.reloadData()
        collectionViewDealsOffers.reloadData()
        collectionViewButtonMenuItems.reloadData()
        
    }
      
    @IBAction func btnGoNextAction(_ sender: UIButton) {
          
        if sender.tag == 100{
            let visibleItems: NSArray = self.collectionViewHealthTips.indexPathsForVisibleItems as NSArray
            let nextItem: IndexPath = visibleItems.object(at: visibleItems.count - 1) as! IndexPath
            if nextItem.row + 1 < arrHealthTips.count {
                self.collectionViewHealthTips.scrollToItem(at: .init(row: nextItem.row + 1, section: 0), at: .left, animated: true)
            }
        }else if sender.tag == 101{
            let visibleItems: NSArray = self.collectionViewMenuItems.indexPathsForVisibleItems as NSArray
            let lastItem: IndexPath = visibleItems.object(at: visibleItems.count - 1) as! IndexPath
            if lastItem.row + 3 < arrMenus.count {
                self.collectionViewMenuItems.scrollToItem(at: .init(row: lastItem.row + 3, section: 0), at: .left, animated: true)
            }
        }
        
    }
    @IBAction func btnGoPreviousAction(_ sender: UIButton) {
          if sender.tag == 100{
              let visibleItems: NSArray = self.collectionViewHealthTips.indexPathsForVisibleItems as NSArray
              let nextItem: IndexPath = visibleItems.object(at: visibleItems.count - 1) as! IndexPath
            let firstItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
              if firstItem.row != 0 {
                  self.collectionViewHealthTips.scrollToItem(at: .init(row: nextItem.row - 3, section: 0), at: .right, animated: true)
              }
          }else if sender.tag == 101{
              let visibleItems: NSArray = self.collectionViewMenuItems.indexPathsForVisibleItems as NSArray
              let nextItem: IndexPath = visibleItems.object(at: visibleItems.count - 1) as! IndexPath
            let firstItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
              if firstItem.row != 0 {
                  self.collectionViewMenuItems.scrollToItem(at: .init(row: nextItem.row - 4, section: 0), at: .right, animated: true)
              }
          }
       
    }
    
    @IBAction func btnMessageAction(_ sender: UIButton) {
        let msgVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationMessagesViewController") as! NotificationMessagesViewController
        self.navigationController?.pushViewController(msgVC, animated: true)
    }
    
    @objc func showprofileImage(_ sender: UITapGestureRecognizer) {
        if AppConstant.retrievFromDefaults(key: StringConstant.profileImageUrl) == ""{
            AppConstant.showAlertToAddProfilePic()
        }else{
            self.performSegue(withIdentifier: "largeProfile_pic", sender: self)
        }
    }
    
    @objc func showHealthTips(_ sender: UITapGestureRecognizer) {
        if isHealthTipsSelected == true{
            return
        }
//        lblHealthTips.textColor = AppConstant.darkColor
//        lblLatestNews.textColor = AppConstant.lightGrayColor
        viewTitleHealthTips.fillColor = AppConstant.themeLightGrayColor
        viewLatestnews.fillColor = UIColor.init(hexString: "#E5E5E5")
        
        viewBottomHealthTips.backgroundColor = AppConstant.themeLightGrayColor
        viewBottomLatestNews.backgroundColor = UIColor.white
        viewColorhealthtips.backgroundColor = AppConstant.themeLightGrayColor
        
        isHealthTipsSelected = true
        self.collectionViewHealthTips.reloadData()
        self.collectionViewHealthTips?.scrollToItem(at: IndexPath(row: 0, section: 0),
              at: .left,
        animated: false)
    }
    
    @objc func showLatestNews(_ sender: UITapGestureRecognizer) {
        if isHealthTipsSelected == false{
            return
        }
        
        if self.arrNews.count == 0{
            self.loadRSS()
        }
        
        
        self.isHealthTipsSelected = false
        self.viewLatestnews.fillColor = AppConstant.themeLightGrayColor
        self.viewTitleHealthTips.fillColor = UIColor.init(hexString: "#E5E5E5")
//        self.lblHealthTips.textColor = AppConstant.lightGrayColor
//        self.lblLatestNews.textColor = AppConstant.darkColor
        
        self.viewBottomLatestNews.backgroundColor = AppConstant.themeLightGrayColor
        self.viewBottomHealthTips.backgroundColor = UIColor.white
        self.viewColorhealthtips.backgroundColor = UIColor.white
        self.collectionViewHealthTips.reloadData()
        
//        if self.arrNewsBackup.count < self.newsCount {
//            AppConstant.showHUD(title: "Loading...")
//        }else{
//            self.arrNews = self.arrNewsBackup
//            self.collectionViewHealthTips.reloadData()
//        }
        
        if self.arrNews.count > 0{
            self.collectionViewHealthTips?.scrollToItem(at: IndexPath(row: 0, section: 0),
                  at: .left,
            animated: false)
        }
        
        
    }
    
    @objc func showCovid19(_ sender: UITapGestureRecognizer) {
        className = StringConstant.covid19
        self.performSegue(withIdentifier: "covid", sender: self)
    }
    
    @objc func showFitness(_ sender: UITapGestureRecognizer) {
        className = StringConstant.selfDoctor
        self.serviceCallToGetDepedentList()
        //self.performSegue(withIdentifier: "selfDoctor", sender: self)
    }
    
    //MARK: Coredata Methods
    @objc func updateUnreadMessageCount(){
        let userId = AppConstant.retrievFromDefaults(key: StringConstant.email)
        let fetchRequest: NSFetchRequest<PushMessages> = PushMessages.fetchRequest()
        let predicate = NSPredicate(format: "userId = %@", argumentArray: [userId])
        fetchRequest.predicate = predicate
        
        do {
            let messages = try CoreDataManager.context.fetch(fetchRequest)
            var count = 0
            //var advCount = 0
            for item in messages {
                if item.readStatus == false{
                    count = count + 1
                    //if item.type == "2"{
                       // advCount = advCount + 1
                    //}else{
                        //count = count + 1
                    //}
                }
            }
            self.lblMessageUnreadCount.text = String(count)
            //self.lblHealthAdvisoryUnreadCount.text = String(advCount)
            self.unreadMessagesCount = count
            //self.unreadHealthAdvisoryCount = advCount
            self.lblMessageUnreadCount.isHidden = count == 0 ? true : false
            //self.lblHealthAdvisoryUnreadCount.isHidden =  true
            UIApplication.shared.applicationIconBadgeNumber = count
            
        } catch {}
        
        
    }
    
    //MARK:- Collectionview Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 100{
            return isHealthTipsSelected == true ? arrHealthTips.count : arrNews.count
        }else if collectionView.tag == 101{
           return arrMenus.count
        }else if collectionView.tag == 102{
            if arrDealsOffers.count == 0{
              lblNoDataFound.isHidden = false
                return 0
            }else{
                 return arrDealsOffers.count
            }
        }else{
             return arrBottomMenu.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 100{ // Health Tips
            if isHealthTipsSelected{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HealthTipsCollectionViewCell", for: indexPath as IndexPath) as! HealthTipsCollectionViewCell
                
                let healthBo = arrHealthTips[indexPath.row]
                cell.imgViewHealthTipsImg.sd_setImage(with: URL(string: healthBo.imagePath!), placeholderImage: UIImage(named: ""))
                cell.lblHealthTipsDesc.text = healthBo.title
                
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestNewsCollectionViewCell", for: indexPath as IndexPath) as! LatestNewsCollectionViewCell
                
                let newsBo = arrNews[indexPath.row]
                cell.lblTitle.text = newsBo.title
                cell.lblPublishedOn.text = AppConstant.convertDateToString(strDate: newsBo.pubDate, currDateFormat: StringConstant.dateFormatter10, requiredDateFormat: StringConstant.dateFormatter11)
                
                if newsBo.desc.hasPrefix("\n"){
                    newsBo.desc = String(newsBo.desc.dropFirst())
                }
                cell.lblDesc.text = newsBo.desc
                
                return cell
            }
        }else if collectionView.tag == 101 {// Dashboard MenuItem
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemsCollectionViewCell", for: indexPath as IndexPath) as! MenuItemsCollectionViewCell
            let mainMenu = self.arrMenus[indexPath.row]
            var imgName = mainMenu.Image.replacingOccurrences(of: ".png", with: "")
            imgName = "\(imgName)"
            cell.imgViewMenu.image = UIImage(named:imgName)
            cell.lblMenuTitle.text = mainMenu.FDESC
            return cell
        }else if collectionView.tag == 102{// Deals/Offers
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DealsOffersCollectionViewCell", for: indexPath as IndexPath) as! DealsOffersCollectionViewCell
            cell.imgViewProductImg.image = UIImage.init(named: arrDealsOffers[indexPath.row].image)
            cell.lblProductName.text = arrDealsOffers[indexPath.row].title
            cell.lblPoductOffers.text = arrDealsOffers[indexPath.row].offer
            cell.lblProductPrice.text = arrDealsOffers[indexPath.row].price
            if (indexPath.row + 1) % 3 == 0{
                cell.lblSeparator.isHidden = true
            }else{
                cell.lblSeparator.isHidden = false
            }
            return cell
        }else{ //Buttom MenuItem
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemsCollectionViewCell", for: indexPath as IndexPath) as! MenuItemsCollectionViewCell
            let imgName = arrBottomMenu[indexPath.row].Image.replacingOccurrences(of: ".png", with: "")
            cell.imgViewMenu.image = UIImage.init(named: imgName + "_blackred")
            cell.lblMenuTitle.text = arrBottomMenu[indexPath.row].FDESC
            return cell
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView.tag == 100{
            if isHealthTipsSelected{
                selectedHealthTips = self.arrHealthTips[indexPath.row]
                self.performSegue(withIdentifier: "health_tips_details", sender: self)
            }else{
                selectedNewsBo = self.arrNews[indexPath.row]
                self.performSegue(withIdentifier: "newsDetails", sender: self)
            }
        }else if collectionView.tag == 101{
            selectedMenu = self.arrMenus[indexPath.row]
            if(selectedMenu.OBJID == StringConstant.myEmployeeEntitlementBenefit){//My Employee Entitle Benefit
                className = selectedMenu.OBJID
                serviceCallToGetDepedentList()
            }else if(selectedMenu.OBJID == StringConstant.myPolicyEntitlement){//My Policy Entitlement
                className = selectedMenu.OBJID
                serviceCallToGetDepedentList()
            }
            else if(selectedMenu.OBJID == StringConstant.myTodayHospitalAdmissionDischargeAgent){//My Today Hospital Admission/Discharge For Agent
                
                self.performSegue(withIdentifier: "myTodayHospitalAdmissionDischarge", sender: self)
            }
            else if(selectedMenu.OBJID == StringConstant.myTodayGLStatus){//My Today GL Status
                className = selectedMenu.OBJID
                serviceCallToGetDepedentList()
            }
            else if(selectedMenu.OBJID == StringConstant.penelProvider || selectedMenu.OBJID == StringConstant.penelProviderAgent){//Panel Providers
                self.performSegue(withIdentifier: "panel_providers", sender: self)
            }else if(selectedMenu.OBJID == StringConstant.changePassword){//Change Password
                self.performSegue(withIdentifier: "change_password", sender: self)
            }else if(selectedMenu.OBJID == "RATE"){//Rate App
                UIApplication.shared.open(URL(string: AppConstant.rateAppUrl)!)
            }else if(selectedMenu.OBJID == "SHARE"){//Share App
                //let textToShare = "Check out this app"
                if let appUrl = NSURL(string: AppConstant.rateAppUrl) {
                    let objectsToShare = [appUrl]
                    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                    self.present(activityVC, animated: true, completion: nil)
                }
            }else if((selectedMenu.OBJID == "MMWA0190") || (selectedMenu.OBJID == "MMWA0191") || (selectedMenu.OBJID == "MMWA0022") || (selectedMenu.OBJID == "MMWARC")){//Out-Patient SP GL Request or Submit Pharmacy Request or Submit Reimbursement Claim or View Reimbursement Claim
                className = selectedMenu.OBJID
                self.serviceCallToGetDepedentList()
            }else if(selectedMenu.OBJID == StringConstant.cashLessClaim){//View CashlessClaim Submenu
                className = selectedMenu.OBJID
                self.performSegue(withIdentifier: "sub_menu_screen", sender: self)
            }else if(selectedMenu.OBJID == "CONTACTUS"){//Contact us
                AppConstant.isSlidingMenu = false
                self.performSegue(withIdentifier: "contact_us", sender: self)
            }else if(selectedMenu.OBJID == StringConstant.QRCode){//QR Code
                className = selectedMenu.OBJID
                self.serviceCallToGetDepedentList()
            }else if(selectedMenu.OBJID == StringConstant.healthAdvisory){//Health Advisory
                //self.performSegue(withIdentifier: "health_advisory", sender: self)
                let advisoryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HealthAdvisoryViewController") as! HealthAdvisoryViewController
                advisoryVC.pageHeader = selectedMenu.FDESC
                self.navigationController?.pushViewController(advisoryVC, animated: true)
            }else if(selectedMenu.OBJID == StringConstant.messagesAgent){//Messages
                self.performSegue(withIdentifier: "messages", sender: self)
            }else if(selectedMenu.OBJID == StringConstant.policyHolderAgent){//Policy Holder-NRIC/PolicyNo
                self.performSegue(withIdentifier: "search_nric_policynumber", sender: self)
            }else if(selectedMenu.OBJID == StringConstant.policyHolderHealthRecordAgent){//Policy Holder Health Record
                isDynamicMenu = false
                className = selectedMenu.OBJID
                self.performSegue(withIdentifier: "sub_menu_screen", sender: self)
            }else if(selectedMenu.OBJID == StringConstant.HAG || selectedMenu.OBJID == StringConstant.HAGAgent){//Hospital Admission Guide
                self.performSegue(withIdentifier: "hospital_admission", sender: self)
            }else if(selectedMenu.OBJID == StringConstant.Settings){//Settings
                className = selectedMenu.OBJID
                self.performSegue(withIdentifier: "home_setting", sender: self)
                //self.performSegue(withIdentifier: "sub_menu_screen", sender: self)
            }else if(selectedMenu.OBJID == StringConstant.viewGLLetter){//View Gl Letter
                className = selectedMenu.OBJID
                self.serviceCallToGetDepedentList()
            }else if(selectedMenu.OBJID == StringConstant.dashboard){//Dashboard
                className = selectedMenu.OBJID
                self.performSegue(withIdentifier: "dashboard", sender: self)
            }else if(selectedMenu.OBJID == StringConstant.downloadClaimForms){//Download Claim Forms
                className = selectedMenu.OBJID
                self.performSegue(withIdentifier: "download_claim_forms", sender: self)
            }else if(selectedMenu.OBJID == StringConstant.viewClaimsRecord){//View Claim Record Submenu
                className = selectedMenu.OBJID
                //isDynamicMenu = false
                self.performSegue(withIdentifier: "sub_menu_screen", sender: self)
            }else if(selectedMenu.OBJID == StringConstant.others){//Others
                className = selectedMenu.OBJID
                self.performSegue(withIdentifier: "sub_menu_screen", sender: self)
            }else if(selectedMenu.OBJID == StringConstant.logOff){//Log Off
                className = selectedMenu.OBJID
                self.showLogoutPopup()
            }else if(selectedMenu.OBJID == StringConstant.virtualCard){//Virtual Card
                className = selectedMenu.OBJID
                self.serviceCallToGetDepedentList()
            }else if(selectedMenu.OBJID == StringConstant.healthTips){//Health Optimization Tips
                className = selectedMenu.OBJID
                self.performSegue(withIdentifier: "health_tips", sender: self)
            }else if(selectedMenu.OBJID == StringConstant.chat){//chat
                let chatLoginId = AppConstant.retrievFromDefaults(key: StringConstant.chatUserName)
                let loginId = AppConstant.retrievFromDefaults(key: StringConstant.email)
                if ChatManager.shared.isLoggedIn() && chatLoginId == loginId {
                    ChatManager.shared.setUser(id: AppConstant.retrievFromDefaults(key: StringConstant.emailAddress), displayName: AppConstant.retrievFromDefaults(key: StringConstant.chatName), avatarUrl: StringConstant.avatarUrl)
                    ChatManager.shared.startChat(from: self)
                }else{
                    ChatManager.shared.signOut()
                    className = selectedMenu.OBJID
                    self.performSegue(withIdentifier: "live_chat", sender: self)
                }
            }else if (selectedMenu.OBJID == StringConstant.hospitalAdmissionGLRequest){
                className = selectedMenu.OBJID
                self.serviceCallToGetDepedentList()
            }else if(selectedMenu.OBJID == StringConstant.uploadMedicalChit){//ViewUploadMedicalChit
                className = selectedMenu.OBJID
                self.serviceCallToGetDepedentList()
            }else if(selectedMenu.OBJID == StringConstant.teleconsult){//teleconsult
                className = selectedMenu.OBJID
                let emergencyNo = AppConstant.retrievFromDefaults(key: StringConstant.emergencyNo)
                let teleHealthMsg: String = "For Medical Emergencies please dial \(emergencyNo) or visit Nearest Hospital"
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: teleHealthMsg, message: "", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        self.performSegue(withIdentifier: "sub_menu_screen", sender: self)
                    }))
                    alert.view.tintColor = AppConstant.themeRedColor
                    self.present(alert, animated: true, completion: nil)
                }
            }else if(selectedMenu.OBJID == StringConstant.WebMDSymptomChecker){//Symptom Checker
                className = selectedMenu.OBJID
                self.performSegue(withIdentifier: "covid", sender: self)
            }else if(selectedMenu.OBJID == StringConstant.WebMDHealthMagazine){//webMDMagazine
                className = selectedMenu.OBJID
                self.performSegue(withIdentifier: "magazinelisting", sender: self)
            }else if(selectedMenu.OBJID == StringConstant.E_marketplace){//E-Marketplace
                className = selectedMenu.OBJID
                self.performSegue(withIdentifier: "covid", sender: self)
            }else if(selectedMenu.OBJID == StringConstant.DisChargeAlert){
                className = selectedMenu.OBJID
                self.performSegue(withIdentifier: "claim_list", sender: self)
            }else if(selectedMenu.OBJID == StringConstant.HealthRiskAssessment){
                className = selectedMenu.OBJID
                self.serviceCallToGetDepedentList()
            }else if selectedMenu.OBJID == StringConstant.BMICALCULATOR{
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BMICalculatorStoryboardID") as! BMICalculatorViewController
                let pstCardNo : String = AppConstant.retrievFromDefaults(key: StringConstant.cardNo)
                vc.cardNo = pstCardNo
                vc.className = (selectedMenu.OBJID)
                vc.subMenuItem = selectedMenu
                self.navigationController?.pushViewController(vc, animated: true)
            }else if selectedMenu.OBJID == StringConstant.HEALTHSCREENING{
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HealthScreeningStoryboardID") as! HealthScreeningViewController
                let pstCardNo : String = AppConstant.retrievFromDefaults(key: StringConstant.cardNo)
                vc.cardNo = pstCardNo
                vc.className = selectedMenu.OBJID
                vc.subMenuItem = selectedMenu
                self.navigationController?.pushViewController(vc, animated: true)
            }else if(selectedMenu.OBJID == StringConstant.Dokterin){
                className = selectedMenu.OBJID
                self.serviceCallToGetDepedentList()
            }
            
        }else if collectionView.tag == 103{//Bottom Menu
            AppConstant.isSlidingMenu = false
            selectedMenu = self.arrBottomMenu[indexPath.row]
            if(selectedMenu.OBJID == StringConstant.healthAdvisory){//Health Advisory
                //self.performSegue(withIdentifier: "health_advisory", sender: self)
                let advisoryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HealthAdvisoryViewController") as! HealthAdvisoryViewController
                advisoryVC.pageHeader = selectedMenu.FDESC
                self.navigationController?.pushViewController(advisoryVC, animated: true)
            }else if(selectedMenu.OBJID == StringConstant.chat){//chat
                let chatLoginId = AppConstant.retrievFromDefaults(key: StringConstant.chatUserName)
                let loginId = AppConstant.retrievFromDefaults(key: StringConstant.email)
                if ChatManager.shared.isLoggedIn() && chatLoginId == loginId {
                    ChatManager.shared.setUser(id: AppConstant.retrievFromDefaults(key: StringConstant.emailAddress), displayName: AppConstant.retrievFromDefaults(key: StringConstant.chatName), avatarUrl: StringConstant.avatarUrl)
                    ChatManager.shared.startChat(from: self)
                }else{
                    ChatManager.shared.signOut()
                    className = selectedMenu.OBJID
                    self.performSegue(withIdentifier: "live_chat", sender: self)
                }
            }else if(selectedMenu.OBJID == StringConstant.QRCode){//QR Code
                className = selectedMenu.OBJID
                self.serviceCallToGetDepedentList()
            }else if(selectedMenu.OBJID == StringConstant.virtualCard){//Virtual Card
                className = selectedMenu.OBJID
                self.serviceCallToGetDepedentList()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var nbCol = 3
        if collectionView.tag == 100 || collectionView.tag == 102 {//Menu cell
            nbCol = 3
        }else if collectionView.tag == 101{
            nbCol = 4
        }
        else if collectionView.tag == 103{
            nbCol = self.arrBottomMenu.count > 3 ? 4 : self.arrBottomMenu.count
        }
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(nbCol))
        if collectionView.tag == 101{
            menuCellheight = 85.5 //CGFloat((collectionView.bounds.height - 4) / 2)
            print("Height ===\(CGFloat((collectionView.bounds.height - 4) / 2))")
            return CGSize(width: (collectionView.bounds.width - 40) / CGFloat(nbCol), height: self.heightConstraintMenuItem)
        }else if collectionView.tag == 100 || collectionView.tag == 102{
            let size = CGFloat((collectionView.bounds.width - 30) / CGFloat(nbCol))
            return CGSize(width: size, height: collectionView.bounds.height)
        }else{
            return CGSize(width: CGFloat(size), height: collectionView.bounds.height)
        }
    }
    
    func showLogoutPopup(){
           
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogoutPopupViewController") as! LogoutPopupViewController
           vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
           
           vc.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
           vc.view.alpha = 0.0
           UIView.animate(withDuration: 0.25, animations: {
               vc.view.alpha = 1.0
               vc.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           })
           
           if let topController = UIApplication.shared.keyWindow?.rootViewController {
               topController.addChild(vc)
               topController.view.addSubview(vc.view)
           }
           
           self.addChild(vc)
           self.view.addSubview(vc.view)
           return
       }
    
    func callPhone(){
        self.phoneNumber = "0939222333"
        if self.isNotNullOrNil(self.phoneNumber){
            if let url = NSURL(string: "tel://\(String(self.phoneNumber))"), UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.openURL(url as URL)
            }
        }else{
            self.displayAlert(message: "Phone number not available.")
        }
    }
    
    //MARK: Delegates
    
    func selectedObject(obj: CustomObject,type: String){
        self.setRoleDetails(atIndex: obj.index!)
    }
    
    func setDataSource(type: String) -> [CustomObject]{
        //States
        dataSource.removeAll()
        if type == "select_policy" {
            for item in 0..<self.arrPolicyDetails.count{
                let polBo = self.arrPolicyDetails[item]
                let customBo = CustomObject()
                customBo.name = polBo.policyNo
                customBo.index = item
                dataSource.append(customBo)
            }
        }
        return dataSource
    }
    
    //MARK: ServiceCall Methods
    func serviceCallToGetDynamicMenu(){
        if(AppConstant.hasConnectivity()) {//true connected
            print("Dynamic menu called")
            let roleDesc = AppConstant.retrievFromDefaults(key: StringConstant.roleDesc)
            //Logout app if roleDes not found, User needs to relogin again
            if roleDesc == ""{
                AppConstant.removeSavedDataAndNavigateToLoginPage()
                return
            }
            AppConstant.showHUD()
            var params: Parameters = [:]
            var url = ""
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            params = [
                "pstRole": roleDesc
            ]
            url = AppConstant.get_dynamic_menu_url
            print("params===\(params)")
            print("url===\(url)")
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = TimeInterval(AppConstant.timeout) // seconds
            configuration.timeoutIntervalForResource = TimeInterval(AppConstant.timeout) //seconds
            AFManager = Alamofire.SessionManager(configuration: configuration)
            AFManager.request( url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
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
                                    self.serviceCallToGetDynamicMenu()
                                }
                            })
                        }else{
                            self.arrMenus.removeAll()
                            self.arrHealthTips.removeAll()
                            self.arrBottomMenu.removeAll()
                            self.isMenuListApiLoaded = true
                            AppConstant.hideHUD()
                            if let status = dict?["Status"] as? String {
                                if(status == "0"){
                                    let msg = dict?["Message"] as? String
                                    if msg != "No Data Available"{
                                        self.displayAlert(message: msg ?? "")
                                    }
                                }else  if(status == "1"){//success
                                    if let responceDict = dict?["MenuDetails"] as? [String: Any]{
                                        
                                        if let arrFrame1 = responceDict["Frame1"] as? [[String: Any]]{
                                                     for dict in arrFrame1 {
                                                        let healthBo = HealthTipsBo()
                                                        if let fullPath = dict["FullPath"] as? String{
                                                            healthBo.htmlPath = fullPath
                                                        }else{
                                                            healthBo.htmlPath = ""
                                                        }
                                                        if let title = dict["Title"] as? String{
                                                           healthBo.title = title
                                                        }else{
                                                           healthBo.title = ""
                                                        }
                                                        if let shortDesc = dict["ShortDesc"] as? String{
                                                            healthBo.shortDesc = shortDesc
                                                        }else{
                                                            healthBo.shortDesc = ""
                                                        }
                                                        if let imgPath = dict["ImagePath"] as? String{
                                                            healthBo.imagePath = imgPath
                                                        }else{
                                                            healthBo.imagePath = ""
                                                        }
                                                        if let lastEditDt = dict["LastEditDate"] as? String{
                                                            healthBo.lastEditDate = lastEditDt
                                                        }else{
                                                            healthBo.lastEditDate = ""
                                                        }
                                                        self.arrHealthTips.append(healthBo)
                                                       
                                                    }
                                                     self.collectionViewHealthTips.reloadData()
                                                 if self.arrHealthTips.count == 0{
                                                     self.heightConstraintHealthTipsView.constant = 0
                                                     self.viewHealthTips.isHidden = true
                                                     self.viewTitleHealthTips.isHidden = true
                                                     self.viewLatestnews.isHidden = true
                                                     self.viewColorhealthtips.isHidden = true
                                                 }else{
                                                    self.viewTitleHealthTips.isHidden = false
                                                    self.viewColorhealthtips.isHidden = false
                                                    self.viewHealthTips.isHidden = false
                                                    
                                                    self.viewLatestnews.isHidden = false
                                                    self.viewBottomHealthTips.isHidden = false
                                                    self.viewCovid19.isHidden = false
                                                    self.viewFitness.isHidden = false
                                            }
                                        }else{
                                            self.heightConstraintHealthTipsView.constant = 0
                                              self.viewHealthTips.isHidden = true
                                            self.viewTitleHealthTips.isHidden = true
                                            self.viewLatestnews.isHidden = true
                                            self.viewColorhealthtips.isHidden = true
                                        }
                                        
                                      if let arrFrame2 = responceDict["Frame2"] as? [[String: Any]]
                                    {
                                         for dict in arrFrame2 {
                                            let menuBo = MainMenuBo()
                                            if let apiName = dict["APINAME"] as? String{
                                                menuBo.apiName = apiName
                                            }else{
                                                menuBo.apiName = ""
                                            }
                                            if let fdesc = dict["FDESC"] as? String{
                                                menuBo.FDESC = fdesc
                                            }else{
                                                menuBo.FDESC = ""
                                            }
                                            if let img = dict["IMAGE"] as? String{
                                                menuBo.Image = img
                                            }else{
                                                menuBo.Image = ""
                                            }
                                            if let objId = dict["OBJID"] as? String{
                                                menuBo.OBJID = objId
                                            }else{
                                                menuBo.OBJID = ""
                                            }
                                            if let ordseq = dict["ORDSEQ"] as? String{
                                                menuBo.ORDSEQ = ordseq
                                            }else{
                                                menuBo.ORDSEQ = ""
                                            }
                                            if let frame = dict["FRAME"] as? String{
                                                menuBo.frame = frame
                                            }else{
                                                menuBo.frame = ""
                                            }
                                            if (dict["SUBMENU"] as? [[String: Any]]) != nil{
                                                let subArray = dict["SUBMENU"] as? [[String: Any]]
                                                if subArray?.count != 0{
                                                    for dict in subArray! {
                                                        let subMenuBo = SubMenuBo()
                                                        if let apiName = dict["APINAME"] as? String{
                                                            subMenuBo.apiName = apiName
                                                        }else{
                                                            subMenuBo.apiName = ""
                                                        }
                                                        if let fdesc = dict["FDESC"] as? String{
                                                            subMenuBo.FDESC = fdesc
                                                        }else{
                                                            subMenuBo.FDESC = ""
                                                        }
                                                        if let img = dict["IMAGE"] as? String{
                                                            subMenuBo.Image = img
                                                        }else{
                                                            subMenuBo.Image = ""
                                                        }
                                                        if let objId = dict["OBJID"] as? String{
                                                            subMenuBo.OBJID = objId
                                                        }else{
                                                            subMenuBo.OBJID = ""
                                                        }
                                                        if let ordseq = dict["ORDSEQ"] as? String{
                                                            subMenuBo.ORDSEQ = ordseq
                                                        }else{
                                                            subMenuBo.ORDSEQ = ""
                                                        }
                                                        menuBo.arrSubMenu.append(subMenuBo)
                                                    }
                                                }
                                            }
                                            self.arrMenus.append(menuBo)
                                        }
                                        self.collectionViewMenuItems.reloadData()
                                        if self.arrMenus.count == 0{
                                            self.heightConstraintDynamicMenuView.constant = 0
                                            self.viewDynamicMenu.isHidden = true
                                        }else{
                                            self.viewDynamicMenu.isHidden = false
                                        }
                                          
                                        let menuBo = MainMenuBo()
                                        menuBo.apiName = "Dokterin"
                                        menuBo.FDESC = "Dokterin"
                                        menuBo.Image = "stethoscope.png"
                                        menuBo.OBJID = "Dokterin"
                                        menuBo.ORDSEQ = ""
                                        self.arrMenus.append(menuBo)

                                      } else {
                                        self.heightConstraintDynamicMenuView.constant = 0
                                        self.viewDynamicMenu.isHidden = true
                                        }
                                        
                                        if responceDict["Frame3"] is [[String: Any]]{
//                                            var maxRowCanFit = (self.viewContainer.frame.size.height - (self.viewWelcome.frame.size.height + self.viewHealthTips.frame.size.height + 10)) / self.heightConstraintMenuItem
                                            var maxRowCanFit = (self.view.frame.size.height - (self.viewWelcome.frame.size.height + self.viewHealthTips.frame.size.height + self.self.heightConstraintOut)) / self.heightConstraintMenuItem
                                            let numOfRow = self.arrMenus.count % 4 == 0 ? (self.arrMenus.count / 4) : ((self.arrMenus.count / 4))
//                                            if Int(numOfRow) >= Int(maxRowCanFit){
                                                self.isViewDynamicScrollable = true
                                                self.heightConstraintDynamicMenuView.constant = (self.heightConstraintMenuItem * CGFloat(Int(maxRowCanFit)))
                                                if let layout = self.collectionViewMenuItems.collectionViewLayout as? UICollectionViewFlowLayout {
                                                    layout.scrollDirection = .vertical
                                                }
//                                            }else if Int(numOfRow) == Int(maxRowCanFit){
//                                                self.heightConstraintDynamicMenuView.constant = self.viewContainer.frame.size.height - (self.viewWelcome.frame.size.height + self.viewHealthTips.frame.size.height)
//                                            }else{
//                                                if ((self.arrMenus.count != 0) && (numOfRow == 0)){
//                                                    self.heightConstraintDynamicMenuView.constant = 175
//                                                }else{
//                                                    self.heightConstraintDynamicMenuView.constant = self.arrMenus.count % 4 == 0 ? (self.heightConstraintMenuItem * CGFloat(numOfRow)) : ((self.heightConstraintMenuItem * CGFloat(numOfRow + 1)))
//                                                }
//                                                if let layout = self.collectionViewMenuItems.collectionViewLayout as? UICollectionViewFlowLayout {
//                                                    layout.scrollDirection = .vertical
//                                                }
//                                            }
                                        }
                                                
                                        if let arrFrame4 = responceDict["Frame4"] as? [[String: Any]]{
                                             for dict in arrFrame4 {
                                                let menuBo = MainMenuBo()
                                                if let apiName = dict["APINAME"] as? String{
                                                    menuBo.apiName = apiName
                                                }else{
                                                    menuBo.apiName = ""
                                                }
                                                if let fdesc = dict["FDESC"] as? String{
                                                    menuBo.FDESC = fdesc
                                                }else{
                                                    menuBo.FDESC = ""
                                                }
                                                if let img = dict["IMAGE"] as? String{
                                                    menuBo.Image = img
                                                }else{
                                                    menuBo.Image = ""
                                                }
                                                if let objId = dict["OBJID"] as? String{
                                                    menuBo.OBJID = objId
                                                }else{
                                                    menuBo.OBJID = ""
                                                }
                                                if let ordseq = dict["ORDSEQ"] as? String{
                                                    menuBo.ORDSEQ = ordseq
                                                }else{
                                                    menuBo.ORDSEQ = ""
                                                }
                                                if let frame = dict["FRAME"] as? String{
                                                    menuBo.frame = frame
                                                }else{
                                                    menuBo.frame = ""
                                                }
                                                self.arrBottomMenu.append(menuBo)
                                               
                                            }
                                            self.viewbuttomMenu.isHidden = false
                                            
                                          self.collectionViewButtonMenuItems.reloadData()
                                        }else{
                                            self.viewbuttomMenu.isHidden = true
                                        }
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: url)
                            }
                            //Register Device Token
                            if AppConstant.retrievFromDefaults(key: StringConstant.isVOIPTokenUpdated) != StringConstant.YES{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                    self.apiCallToRegisterDeviceToken()
                                })
                            }
                        }
                        self.collectionViewMenuItems.reloadData()
                        break
                    case .failure(_):
                        AppConstant.hideHUD()
//                        if self.arrMenus.count == 0{
//                            self.serviceCallToGetDynamicMenu()
//                        }
                        self.collectionViewMenuItems.reloadData()
                        break
                    }
            }
            
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToGetDepedentList(){
        if(AppConstant.hasConnectivity()) {//true connected
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.isHudShowing = false
            AppConstant.showHUD(title: "Loading...")
            let pstCardNo : String = AppConstant.retrievFromDefaults(key: StringConstant.cardNo)
            let userType : String = AppConstant.retrievFromDefaults(key: StringConstant.userType)
            var urlString = AppConstant.getMemberDependentDetailsUrl
            print("url===\(urlString)")
            let json = "{\"pstCardNo\":\"\(pstCardNo)\",\"pstUserType\":\"\(userType)\"}"
            print("param===\(json)")
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            let url = URL(string: urlString)!
            let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.setValue(AppConstant.retrievFromDefaults(key: StringConstant.authorization), forHTTPHeaderField: "Authorization")
            AFManager.request(request).responseJSON {
                (response) in
                 debugPrint(response)
                //AppConstant.hideHUD()
                AppConstant.hideHUDSingle()
                AppConstant.hideHUD()
                switch(response.result) {
                case .success(_):
                    debugPrint(response)
                    //debugPrint(response.result.value!)
                    
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.serviceCallToGetDepedentList()
                            }
                        })
                    }else{
                        if  let dict = response.result.value as? [String : Any]{
                            if let status = dict["Status"] as? String {
                                if(status == "1"){//success
                                    if let arrDependentDetails = dict["MemberDependentDetails"] as? [[String:Any]]{
                                        
                                        for dictDependentDetails in arrDependentDetails{
                                            
                                            self.memberDetailsbo = MemberBo()
                                            if let cardNo = dictDependentDetails["CardNo"] as? String{
                                                self.memberDetailsbo.cardNo = cardNo
                                            }else{
                                                self.memberDetailsbo.cardNo = ""
                                            }
                                            if let dependentId = dictDependentDetails["DependentId"] as? String{
                                                self.memberDetailsbo.dependentId = dependentId
                                            }else{
                                                self.memberDetailsbo.dependentId = ""
                                            }
                                            if let dependentStatus = dictDependentDetails["Dependentstatus"] as? String{
                                                self.memberDetailsbo.dependentStatus = dependentStatus
                                            }else{
                                                self.memberDetailsbo.dependentStatus = ""
                                            }
                                            if let employeeId = dictDependentDetails["EmployeeId"] as? String{
                                                self.memberDetailsbo.employeeId = employeeId
                                            }else{
                                                self.memberDetailsbo.employeeId = ""
                                            }
                                            if let Gender = dictDependentDetails["Gender"] as? String{
                                                self.memberDetailsbo.gender = Gender
                                            }else{
                                                self.memberDetailsbo.gender = ""
                                            }
                                            if let MemberType = dictDependentDetails["MemberType"] as? String{
                                                self.memberDetailsbo.memberType = MemberType
                                            }else{
                                                self.memberDetailsbo.memberType = ""
                                            }
                                            if let name = dictDependentDetails["Name"] as? String{
                                                self.memberDetailsbo.name = name
                                            }else{
                                                self.memberDetailsbo.name = ""
                                            }
                                            if let NationalId = dictDependentDetails["NationalId"] as? String{
                                                self.memberDetailsbo.nationalId = NationalId
                                            }else{
                                                self.memberDetailsbo.nationalId = ""
                                            }
                                            if let PAYOR_MEMBER_ID = dictDependentDetails["PAYOR_MEMBER_ID"] as? String{
                                                self.memberDetailsbo.PAYOR_MEMBER_ID = PAYOR_MEMBER_ID
                                            }else{
                                                self.memberDetailsbo.PAYOR_MEMBER_ID = ""
                                            }
                                            if let PolicyNo = dictDependentDetails["PolicyNo"] as? String{
                                                self.memberDetailsbo.policyNo = PolicyNo
                                            }else{
                                                self.memberDetailsbo.policyNo = ""
                                            }
                                            if let dateOfBirth = dictDependentDetails["DateOfBirth"] as? String{
                                                self.memberDetailsbo.dateOfBirth = dateOfBirth
                                            }else{
                                                self.memberDetailsbo.dateOfBirth = ""
                                            }
                                            if let memberControlNo = dictDependentDetails["MemberControlNo"] as? String{
                                                self.memberDetailsbo.memberControlNo = memberControlNo
                                            }else{
                                                self.memberDetailsbo.memberControlNo = ""
                                            }
                                            if let corpCode = dictDependentDetails["CorpCode"] as? String{
                                                self.memberDetailsbo.corpCode = corpCode
                                            }else{
                                                self.memberDetailsbo.corpCode = ""
                                            }
                                            if let payorCode = dictDependentDetails["PAYOR_CODE"] as? String{
                                                self.memberDetailsbo.payorCode = payorCode
                                            }else{
                                                self.memberDetailsbo.payorCode = ""
                                            }
                                            if let arrDependents = dictDependentDetails["Dependents"] as? [[String:Any]]{
                                                if arrDependents.count > 0 {
                                                    for dictDependent in arrDependents{
                                                        let dependentBo = DependentBo()
                                                        if let cardNo = dictDependent["CardNo"] as? String{
                                                            dependentBo.cardNo = cardNo
                                                        }else{
                                                            dependentBo.cardNo = ""
                                                        }
                                                        if let dependentId = dictDependent["DependentId"] as? String{
                                                            dependentBo.dependentId = dependentId
                                                        }else{
                                                            dependentBo.dependentId = ""
                                                        }
                                                        if let dependentStatus = dictDependent["Dependentstatus"] as? String{
                                                            dependentBo.dependentStatus = dependentStatus
                                                        }else{
                                                            dependentBo.dependentStatus = ""
                                                        }
                                                        if let employeeId = dictDependent["EmployeeId"] as? String{
                                                            dependentBo.employeeId = employeeId
                                                        }else{
                                                            dependentBo.employeeId = ""
                                                        }
                                                        if let Gender = dictDependent["Gender"] as? String{
                                                            dependentBo.gender = Gender
                                                        }else{
                                                            dependentBo.gender = ""
                                                        }
                                                        if let MemberType = dictDependent["MemberType"] as? String{
                                                            dependentBo.memberType = MemberType
                                                        }else{
                                                            dependentBo.memberType = ""
                                                        }
                                                        if let name = dictDependent["Name"] as? String{
                                                            dependentBo.name = name
                                                        }else{
                                                            dependentBo.name = ""
                                                        }
                                                        if let NationalId = dictDependent["NationalId"] as? String{
                                                            dependentBo.nationalId = NationalId
                                                        }else{
                                                            dependentBo.nationalId = ""
                                                        }
                                                        if let PAYOR_MEMBER_ID = dictDependent["PAYOR_MEMBER_ID"] as? String{
                                                            dependentBo.PAYOR_MEMBER_ID = PAYOR_MEMBER_ID
                                                        }else{
                                                            dependentBo.PAYOR_MEMBER_ID = ""
                                                        }
                                                        if let PolicyNo = dictDependent["PolicyNo"] as? String{
                                                            dependentBo.policyNo = PolicyNo
                                                        }else{
                                                            dependentBo.policyNo = ""
                                                        }
                                                        if let dateOfBirth = dictDependent["DateOfBirth"] as? String{
                                                            dependentBo.dateOfBirth = dateOfBirth
                                                        }else{
                                                            dependentBo.dateOfBirth = ""
                                                        }
                                                        if let memberControlNo = dictDependent["MemberControlNo"] as? String{
                                                            dependentBo.memberControlNo = memberControlNo
                                                        }else{
                                                            dependentBo.memberControlNo = ""
                                                        }
                                                        if let corpCode = dictDependent["CorpCode"] as? String{
                                                            dependentBo.corpCode = corpCode
                                                        }else{
                                                            dependentBo.corpCode = ""
                                                        }
                                                        if let payorCode = dictDependent["PAYOR_CODE"] as? String{
                                                            dependentBo.payorCode = payorCode
                                                        }else{
                                                            dependentBo.payorCode = ""
                                                        }
                                                        self.memberDetailsbo.dependentArray.append(dependentBo)
                                                    }
                                                }
                                            }
                                            if self.selectedMenu.OBJID == StringConstant.myTodayGLStatus{
                                                if (self.memberDetailsbo.dependentArray.count > 0){
                                                    self.performSegue(withIdentifier: "dependent_screen", sender: self)
                                                }else{
                                                    self.performSegue(withIdentifier: "my_today_gl_status", sender: self)
                                                }
                                            }else if self.selectedMenu.OBJID == StringConstant.viewGLLetter{
                                                if (self.memberDetailsbo.dependentArray.count > 0){
                                                    self.performSegue(withIdentifier: "dependent_screen", sender: self)
                                                }else{
                                                    self.performSegue(withIdentifier: "viewGlLetterList", sender: self)
                                                    
                                                    //self.performSegue(withIdentifier: "view_gl_letter", sender: self)
                                                }
                                            }else if self.selectedMenu.OBJID == StringConstant.viewReimbursementClaim{
                                                if (self.memberDetailsbo.dependentArray.count > 0){
                                                    self.performSegue(withIdentifier: "dependent_screen", sender: self)
                                                }else{
                                                    self.performSegue(withIdentifier: "claim_list", sender: self)
                                                }
                                            }else if self.selectedMenu.OBJID == StringConstant.myEmployeeEntitlementBenefit{
                                                if (self.memberDetailsbo.dependentArray.count > 0){
                                                    self.performSegue(withIdentifier: "dependent_screen", sender: self)
                                                }else{
                                                    self.performSegue(withIdentifier: "policy_info", sender: self)
                                                }
                                            }else if self.selectedMenu.OBJID == StringConstant.myPolicyEntitlement{
                                                if (self.memberDetailsbo.dependentArray.count > 0){
                                                    self.performSegue(withIdentifier: "dependent_screen", sender: self)
                                                }else{
                                                    self.performSegue(withIdentifier: "policy_info", sender: self)
                                                }
                                            }else if self.selectedMenu.OBJID == StringConstant.Dokterin{
                                                if (self.memberDetailsbo.dependentArray.count > 0){
                                                    self.performSegue(withIdentifier: "dependent_screen", sender: self)
                                                }else{
                                                    self.performSegue(withIdentifier: "policy_info", sender: self)
                                                }
                                            }else{
                                                self.performSegue(withIdentifier: "dependent_screen", sender: self)
                                            }
                                        }
                                        
                                    }
                                    
                                }else{
                                    if let msg = dict["Message"] as? String{
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: urlString)
                            }
                        }
                    }
                    
                    break
                    
                case .failure(_):
                    let error = response.result.error!
                    print("error.localizedDescription===\(error.localizedDescription)")
                    AppConstant.showNetworkAlertMessage(apiName: urlString)
                    break
                    
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToGetVirtualCardDetails(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            let pstCardNo : String = AppConstant.retrievFromDefaults(key: StringConstant.cardNo)
            let pstPlancode : String = AppConstant.retrievFromDefaults(key: StringConstant.planCode)
            let params: Parameters = [
                "pstCardNo": pstCardNo,
                "pstPlancode": pstPlancode
            ]
            print("params===\(params)")
            print("url===\(AppConstant.dashboardVirtualCardUrl)")
            AFManager.request( AppConstant.dashboardVirtualCardUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                    AppConstant.hideHUD()
                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let dict = AppConstant.convertToDictionary(text: response.result.value!)
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToGetVirtualCardDetails()
                                }
                            })
                        }else{
                            if let status = dict!["Status"] as? String {
                                self.arrVirtualCard.removeAll()
                                //self.viewVirtualCard.isHidden = false manas
                                if(status == "1"){
                                    if let arrCardDetails = dict!["CardInfoList"] as? [[String:Any]]{
                                        if arrCardDetails.count > 0{
                                            //let dictCard = arrCardDetails[0]
                                            for dictCard in arrCardDetails{
                                                if let strCardInfo = dictCard["CardInfo"] as? String{
                                                    let virtualcardBo = VirtualCardBo()
                                                    if let cardBg = dictCard["CardImage"] as? String{
                                                        virtualcardBo.cardBgUrl = cardBg
                                                    }
                                                    
                                                    let arrCardInfo : [String] = strCardInfo.components(separatedBy: "<br/>")
                                                    if arrCardInfo.count > 4{
                                                        virtualcardBo.memberSince = arrCardInfo[4]
                                                    }
                                                    if arrCardInfo.count > 3{
                                                        virtualcardBo.value2 = arrCardInfo[3]
                                                    }
                                                    if arrCardInfo.count > 2{
                                                        virtualcardBo.value1 = arrCardInfo[2]
                                                    }
                                                    if arrCardInfo.count > 1{
                                                        virtualcardBo.name = arrCardInfo[1]
                                                    }
                                                    if arrCardInfo.count > 0{
                                                        virtualcardBo.cardNo = arrCardInfo[0]
                                                    }
                                                    if let strQRCode = dictCard["QrCode"] as? String{
                                                        virtualcardBo.qrCode = strQRCode
                                                    }
                                                    if let color = dictCard["FontColor"] as? String{
                                                        virtualcardBo.foregroundColor = color // "#66ff33"
                                                    }
                                                    self.arrVirtualCard.append(virtualcardBo)
                                                }
                                            }
                                        }
                                    }
                                }else{
                                    if let message = dict!["Message"] as? String{
                                        self.displayAlert(message: message )
                                    }
                                }
                            }else{
                                AppConstant.showNetworkAlertMessage(apiName: AppConstant.dashboardVirtualCardUrl)
                            }
                        }
                        break
                    case .failure(_):
                        AppConstant.showNetworkAlertMessage(apiName: AppConstant.dashboardVirtualCardUrl)
                        break
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func serviceCallToGetHealthTipsData(){
        if(AppConstant.hasConnectivity()) {//true connected
            AppConstant.showHUD()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            print("url===\(AppConstant.getHealthTipsUrl)")
            AFManager.request( AppConstant.getHealthTipsUrl, method: .get, parameters: nil, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
                     debugPrint("Health tips response===\(response)")
                    AppConstant.hideHUD()
                    switch(response.result) {
                    case .success(_):
                        debugPrint(response.result.value!)
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode != 200){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.serviceCallToGetHealthTipsData()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict!["Status"] as? String {
                                if(status == "1"){
                                    self.arrHealthTips.removeAll()
                                    if let arrHealthData = dict!["HealthtipsList"] as? [[String:Any]]{
                                        for dict in arrHealthData{
                                            let healthTipssBo = HealthTipsBo()
                                            if let path = dict["FullPath"] as? String{
                                                healthTipssBo.htmlPath = path
                                            }else{
                                                healthTipssBo.htmlPath = ""
                                            }
                                            if let title = dict["Title"] as? String{
                                                healthTipssBo.title = title
                                            }else{
                                                healthTipssBo.title = ""
                                            }
                                            if let shortDesc = dict["ShortDesc"] as? String{
                                                healthTipssBo.shortDesc = shortDesc
                                            }else{
                                                healthTipssBo.shortDesc = ""
                                            }
                                            if let imagePath = dict["ImagePath"] as? String{
                                                healthTipssBo.imagePath = imagePath
                                            }else{
                                                healthTipssBo.imagePath = ""
                                            }
                                            if let lastDate = dict["LastEditDate"] as? String{
                                                healthTipssBo.lastEditDate = lastDate
                                            }else{
                                                healthTipssBo.lastEditDate = ""
                                            }
                                            self.arrHealthTips.append(healthTipssBo)
                                        }
                                    }
                    
                                    self.collectionViewHealthTips.reloadData()
                                    
                                    if self.arrHealthTips.count == 0{
                                        self.heightConstraintHealthTipsView.constant = 0
                                        self.viewHealthTips.isHidden = true
                                        self.viewTitleHealthTips.isHidden = true
                                        self.viewLatestnews.isHidden = true
                                    }
                                }else{
                                    if let msg = dict!["Message"] as? String{
                                        self.displayAlert(message: msg )
                                    }
                                }
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        let error = response.result.error!
                        print("error.localizedDescription===\(error.localizedDescription)")
                        break
                        
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func apiCallToRegisterDeviceToken(){
            let apnsId = AppConstant.retrievFromDefaults(key: StringConstant.deviceToken)
            let voipId = AppConstant.retrievFromDefaults(key: StringConstant.voip_Token)
            //pstVoipToken
            let json = "{\"pstDeviceId\":\"\(apnsId)\",\"pstDeviceName\":\"\(StringConstant.iOS)\",\"pstVoipToken\":\"\(voipId)\"}"
            print("param===\(json)")
            let url = URL(string: AppConstant.update_device_token_url)!
            let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.setValue(AppConstant.retrievFromDefaults(key: StringConstant.authorization), forHTTPHeaderField: "Authorization")
            print("url===\(AppConstant.update_device_token_url)")
            if apnsId != "" {
                Alamofire.request(request).responseJSON {
                    (response) in
                    debugPrint(response)
                    
                    switch(response.result) {
                    case .success(_):
                        debugPrint(response.result.value!)
                        
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.apiCallToRegisterDeviceToken()
                                }
                            })
                        }else{
                            let dict = response.result.value as! [String : AnyObject]
                            //  debugPrint(dict)
                            
                            if let status = dict["Status"] as? String {
                                if(status == "1"){//success
                                    //Save in Defaults
                                    AppConstant.saveInDefaults(key: StringConstant.isVOIPTokenUpdated, value: StringConstant.YES)
                                    print("Device token saved in server")
                                    // AppConstant.saveInDefaults(key: StringConstant.isTokenSaved, value: StringConstant.YES)
                                    
                                }else {
                                    print("Failed to save device token in server")
                                }
                            }else{
                                //AppConstant.showNetworkAlertMessage(apiName: AppConstant.update_device_token_url)
                            }
                        }
                        
                        break
                        
                    case .failure(_):
                        break
                    }
                }
            }
        }
    
    func getPlanOption(){
        let cardNo = AppConstant.retrievFromDefaults(key: StringConstant.cardNo)
        if(AppConstant.hasConnectivity()) {
            AppConstant.showHUD()
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            print("Headers--- \(headers)")
            let json = "{\"pstCardNo\":\"\(cardNo)\"}"
            let url = URL(string: AppConstant.policy_detailsv2_url)!
            let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.allHTTPHeaderFields = headers
            request.setValue(AppConstant.retrievFromDefaults(key: StringConstant.authorization), forHTTPHeaderField: "Authorization")
            print("url===\(AppConstant.policy_detailsv2_url)")
            print("param===\(json)")
            AFManager.request(request).responseJSON {
                (response) in
                debugPrint(response)
                switch(response.result) {
                case .success(_):
                    AppConstant.showHUD()
                    let headerStatusCode : Int = (response.response?.statusCode)!
                    print("Status Code: \(headerStatusCode)")
                    if(headerStatusCode == 401){//Session expired
                        self.isTokenVerified(completion: { (Bool) in
                            if Bool{
                                self.getPlanOption()
                            }
                        })
                    }else{
                        let dataRes = response.result.value as! [String : AnyObject]
                        if let status = dataRes["Status"] as? String {
                            if(status == "1"){//success
                                let arrPolicyDeatils = dataRes["Policydetails"] as! [[String: Any]]
                                if(arrPolicyDeatils.count > 0)
                                {
                                    var options:[String] = []
                                    for dict in arrPolicyDeatils {
                                        let policyBo = PolicyDetailsBo()
                                        if let planCode = dict["PlanCode"] as? String{
                                            policyBo.planCode = planCode
                                            options.append(planCode)
                                            if let role = dict["Role"] as? String{
                                                policyBo.role = role
                                            }
                                            if let roleDesc = dict["RoleDesc"] as? String{
                                                policyBo.roleDesc = roleDesc
                                            }
                                            if let cardNo = dict["CardNo"] as? String{
                                                policyBo.cardNo = cardNo
                                            }else{
                                                policyBo.cardNo = ""
                                            }
                                            if let corpCode = dict["CorpCode"] as? String{
                                                policyBo.corpCode = corpCode
                                            }else{
                                                policyBo.corpCode = ""
                                            }
                                            if let policyNo = dict["PolicyNo"] as? String{
                                                policyBo.policyNo = policyNo
                                            }else{
                                                policyBo.policyNo = ""
                                            }
                                            if let payorCode = dict["PayorCode"] as? String{
                                                policyBo.payorCode = payorCode
                                            }else{
                                                policyBo.payorCode = ""
                                            }
                                        }
                                        self.arrPlanOption.append(policyBo)
                                    }
                                    _ = AppConstant.retrievFromDefaults(key: StringConstant.roleDesc)
                                    let cardNo = AppConstant.retrievFromDefaults(key: StringConstant.cardNo)
                                    if let result = self.arrPlanOption.first(where: {$0.cardNo == cardNo}) {
                                        self.lblSelectPlan.text = result.planCode
                                        AppConstant.saveInDefaults(key: StringConstant.cardNo, value: result.cardNo)
                                        AppConstant.saveInDefaults(key: StringConstant.planCode, value: result.planCode)
                                        AppConstant.saveInDefaults(key: StringConstant.policyNo, value: result.policyNo)
                                        AppConstant.saveInDefaults(key: StringConstant.payorCode, value: result.payorCode)
                                        AppConstant.saveInDefaults(key: StringConstant.role, value: result.role)
                                        AppConstant.saveInDefaults(key: StringConstant.roleDesc, value: result.roleDesc)

                                    }
                                    self.menu.dataSource = options
                                    if options.count > 1{
                                        self.heightPlanSelectionViewConstraint.constant = 20
                                        self.planSelectionView.isHidden = false
                                        self.heightWelcomeViewConstraint.constant = 130
                                    }
                                    //Service call to get dynamic Menu
                                    if AppConstant.isAppOpenedFromCallReceived == false{
                                        self.serviceCallToGetDynamicMenu()
                                    }
                                }
                            }
                            AppConstant.hideHUD()
                        }else{
                            AppConstant.hideHUD()
                        }
                        AppConstant.hideHUD()
                    }
                    break
                    
                case .failure(_):
                    AppConstant.hideHUD()
                    break
                }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    func getProfileImage(){
        if(AppConstant.hasConnectivity()) {//true connected
            let pstMemId = AppConstant.retrievFromDefaults(key: StringConstant.memId)
            let headers: HTTPHeaders = [
                "Authorization": AppConstant.retrievFromDefaults(key: StringConstant.authorization),
                "Accept": "application/json"
            ]
            let parameters: Parameters = [
                "pstMemId": pstMemId,
            ]
            //print(parameters)
            
            print("params===\(parameters)")
            print("url===\(AppConstant.postProfileImageUrl)")
            AFManager.request( AppConstant.postProfileImageUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers)
                .responseString { response in
//                    debugPrint(response)
                    switch(response.result) {
                    case .success(_):
                        let headerStatusCode : Int = (response.response?.statusCode)!
                        print("Status Code: \(headerStatusCode)")
                        if(headerStatusCode == 401){//Session expired
                            self.isTokenVerified(completion: { (Bool) in
                                if Bool{
                                    self.getProfileImage()
                                }
                            })
                        }else{
                            let dict = AppConstant.convertToDictionary(text: response.result.value!)
                            if let status = dict?["Status"] as? String {
                                if(status == "1"){
                                    if let profileImageUrl = dict?["ProfileImageUrl"] as? String{
                                        AppConstant.saveInDefaults(key: StringConstant.profileImageUrl, value: profileImageUrl)
                                        if profileImageUrl != ""{
                                            if let data = Data(base64Encoded: profileImageUrl) {
                                                let image = UIImage(data: data)
                                                self.imgViewUser.image = image
                                            }
                                        }
                                    }else{
                                        self.imgViewUser.image = UIImage.init(named: "userGray")
                                        AppConstant.saveInDefaults(key: StringConstant.profileImageUrl, value: "")
                                    }
                                    
                                }
                            }
                        }
                        break
                    case .failure(_):
                        break
                        
                    }
            }
        }else{
            self.displayAlert(message: "Please check your internet connection.")
        }
    }
    
    //MARK: RssFeed
    func readFromLocalXmlFile(){
        if let path = Bundle.main.url(forResource: "news-english", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
    }
    
    func loadFitnessRSS() {
        if(AppConstant.hasConnectivity()) {
            AppConstant.showHUD()
            self.arrNews.removeAll()
            Alamofire.request(AppConstant.fitnessUrl).response { response in

                if let data = response.data, let _ = String(data: data, encoding: .utf8) {
                    AppConstant.hideHUD()
                    let xml = SWXMLHash.parse(data)
                    print("title===\(xml["channel"])")
                    self.enumerate(indexer: xml)
                   
                }else{
                    AppConstant.hideHUD()
                }
            }
        }
    }
    
    func enumerate(indexer: XMLIndexer) {
        for child in indexer.children {
            enumerate(indexer: child)
        }
    }
    
    func loadRSS() {
        let roleDesc = AppConstant.retrievFromDefaults(key: StringConstant.roleDesc)

        if roleDesc == ""{
            return
        }
        
        if(AppConstant.hasConnectivity()) {
            AppConstant.showHUD()
            self.arrNewsBackup.removeAll()
            Alamofire.request(AppConstant.rssNewsUrl).response { response in
                if let data = response.data, let _ = String(data: data, encoding: .utf8) {
                    print("XML data\(data)")
                    self.isWHOApiLoaded = true
                    let xml = SWXMLHash.parse(data)
                    print("Manas")
                    let nodes = xml["rss"]["channel"]["item"]
                    self.newsCount = nodes.all.count
                    for node in nodes.all {
                        let newsbo = News()
                        if let title = node["title"].element?.text{
                            newsbo.title = title.html2String.trim()
                        }
                        if let description = node["description"].element?.text{
                            newsbo.desc = description.html2String.trim()
                        }
                        if let pubDate = node["pubDate"].element?.text{
                            newsbo.pubDate = pubDate.html2String.trim()
                        }
                        
                        self.arrNewsBackup.append(newsbo)
                    }
                    self.arrNews = self.arrNewsBackup
                    self.collectionViewHealthTips.reloadData()
                    AppConstant.hideHUD()
                }else{
                    AppConstant.hideHUD()
                }
            }
        }
    }
    
    //MARK: XML Parser Delegates
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            newstitle = String()
            desc = String()
            pubDate = String()
        }

        self.elementName = elementName
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let newsBo = News()
            newsBo.title = newstitle.html2String.trim()
            newsBo.desc = desc.html2String.trim()
            newsBo.pubDate = pubDate.html2String.trim()
            arrNews.append(newsBo)
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            if self.elementName == "title" {
                newstitle += data
            } else if self.elementName == "description" {
                desc += data
            } else if self.elementName == "pubDate" {
                pubDate += data
            }
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("Finished xml Parsing")
        AppConstant.hideHUD()
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        let pstCardNo : String = AppConstant.retrievFromDefaults(key: StringConstant.cardNo)
        if (segue.identifier == "policy_info"){
            let vc = segue.destination as! PolicyInfoViewController
            vc.policyBo = selectedPolicy
            vc.strCardNo = pstCardNo
            vc.strPolicyNo = selectedPolicy.policyNo
            vc.strHeaderImageName = self.selectedMenu.Image.replacingOccurrences(of: ".png", with: "") + "_white"
            vc.pageHeader = self.selectedMenu.FDESC
            return
        }else if (segue.identifier == "health_tips_details"){
            let vc = segue.destination as! HealthOptimizationTipsDetailsViewController
            vc.selectedHealthTips = selectedHealthTips
            return
        }
        else if (segue.identifier == "panel_providers"){
            let vc = segue.destination as! PanelProvidersViewController
            vc.pageTitle = self.selectedMenu.FDESC
            vc.strHeaderImageName = self.selectedMenu.Image.replacingOccurrences(of: ".png", with: "") + "_white"
            return
        }else if (segue.identifier == "dependent_screen"){
            let vc = segue.destination as! DependentViewController
            vc.memberBo = self.memberDetailsbo
            vc.className = self.className
            vc.pageTitle = className == StringConstant.selfDoctor ? "Self Doctor" : self.selectedMenu.FDESC
            vc.selectedPolicy = selectedPolicy
            vc.strHeaderImageName = self.selectedMenu.Image.replacingOccurrences(of: ".png", with: "") + "_white"
            return
        }else if (segue.identifier == "view_gl_letter"){
            let vc = segue.destination as! ViewGLLettersViewController
            vc.cardNo = pstCardNo
            vc.strHeaderImageName = self.selectedMenu.Image.replacingOccurrences(of: ".png", with: "") + "_white"
            vc.strHeader = self.selectedMenu.FDESC
            vc.pageTitle = "Principal"
            return
        }else if (segue.identifier == "viewGlLetterList"){
            let vc = segue.destination as! ViewGlLetterListViewController
            vc.cardNo = pstCardNo
            vc.pageTitle = "Principal"
            vc.strHeader = self.selectedMenu.FDESC
            vc.strHeaderImageName = self.selectedMenu.Image.replacingOccurrences(of: ".png", with: "") + "_white"
            return
        }else  if (segue.identifier == "select_policy"){
            let vc = segue.destination as! ChooseOptionViewController
            vc.delegate = self
            vc.isCustomObj = true
            vc.arrData = self.setDataSource(type: segue.identifier!)
            vc.type = segue.identifier!
            return
        }else if (segue.identifier == "sub_menu_screen"){
            let vc = segue.destination as! SubMenuViewController
            vc.isDynamicMenu = isDynamicMenu
            vc.arrMenus = self.selectedMenu.arrSubMenu
            vc.className = self.className
            vc.selectedPolicy = self.selectedPolicy
            vc.pageHeader = self.selectedMenu.FDESC
            vc.cellheight = menuCellheight
            vc.strHeaderImageName = self.selectedMenu.Image.replacingOccurrences(of: ".png", with: "") + "_white"
            return
        }else if (segue.identifier == "my_today_gl_status"){
            let vc = segue.destination as! MyTodayGLStatusViewController
            vc.strCardNo = pstCardNo
            vc.strHeaderImageName = self.selectedMenu.Image.replacingOccurrences(of: ".png", with: "") + "_white"
            vc.pageTitle = "Principal"
            vc.pageHeader = self.selectedMenu.FDESC
            return
        }else if (segue.identifier == "claim_list"){
            let vc = segue.destination as! ClaimListViewController
            vc.cardNo = pstCardNo
            vc.className = className
            let userType = AppConstant.retrievFromDefaults(key: StringConstant.userType)
            if userType != "D"
            {
                vc.strPageTitle = "Principal"
            }else{
                vc.strPageTitle = "Dependents"
            }
            vc.strPageHeader = self.selectedMenu.FDESC
            vc.strHeaderImageName = self.selectedMenu.Image.replacingOccurrences(of: ".png", with: "") + "_white"
            return
        }else if (segue.identifier == "dashboard"){
            let vc = segue.destination as! DashboardViewController
            vc.pageTitle = self.selectedMenu.FDESC
            vc.cardNo = pstCardNo
            vc.strHeaderImageName = self.selectedMenu.Image.replacingOccurrences(of: ".png", with: "") + "_white"
            return
        }else if (segue.identifier == "download_claim_forms"){
            let vc = segue.destination as! DownloadClaimFormsViewController
            vc.pageTitle = self.selectedMenu.FDESC
            return
        }else if (segue.identifier == "virtual_card_screen"){
            let vc = segue.destination as! VirtualCardViewController
            vc.strCardNo = pstCardNo
            vc.isFromHomePage = true
            let userType = AppConstant.retrievFromDefaults(key: StringConstant.userType)
            if userType != "D"
            {
                vc.pageTitle = "Principal"
            }else{
                vc.pageTitle = "Dependents"
            }
            return
        }else if (segue.identifier == "health_tips"){
            let vc = segue.destination as! HealthOptimizationTipsViewController
            vc.pageHeader = self.selectedMenu.FDESC
            vc.imgHeader = self.selectedMenu.Image.replacingOccurrences(of: ".png", with: "") + "_white"
            return
        }else if (segue.identifier == "myTodayHospitalAdmissionDischarge"){
            let vc = segue.destination as! MyTodayHospitalAdmissionDischargeViewController
            vc.titleHeader = self.selectedMenu.FDESC
            vc.imgHeader = self.selectedMenu.Image.replacingOccurrences(of: ".png", with: "") + "_white"
            return
        }else if (segue.identifier == "search_nric_policynumber"){
            let vc = segue.destination as! SearchNricOrPolicyNumberViewController
            vc.headerText = self.selectedMenu.FDESC
            vc.imgHeaderView = self.selectedMenu.Image.replacingOccurrences(of: ".png", with: "") + "_white"
            return
        }else if (segue.identifier == "newsDetails"){
            let vc = segue.destination as! RssFeedDetailsViewController
            vc.newsBo = selectedNewsBo
            
            return
        }else if (segue.identifier == "covid"){
            let vc = segue.destination as! CovidViewController
            vc.classname = className
            vc.headerTitle = self.selectedMenu.FDESC
            vc.headerImage = self.selectedMenu.Image.replacingOccurrences(of: ".png", with: "") + "_white"
            return
        }else if (segue.identifier == "magazinelisting"){
            let vc = segue.destination as! ListViewController
            vc.className = className
            vc.pageHeader = self.selectedMenu.FDESC
            vc.strHeaderImageName = self.selectedMenu.Image.replacingOccurrences(of: ".png", with: "") + "_white"
            return
        }
    }

}
extension CALayer {

  func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

    let border = CALayer()

    switch edge {
    case UIRectEdge.top:
        border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)

    case UIRectEdge.bottom:
        border.frame = CGRect(x:0, y: frame.height - thickness, width: frame.width, height:thickness)

    case UIRectEdge.left:
        border.frame = CGRect(x:0, y:0, width: thickness, height: frame.height)

    case UIRectEdge.right:
        border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)

    default: do {}
    }

    border.backgroundColor = color.cgColor

    addSublayer(border)
 }
}

extension UIViewController {
  func alert(message: String, title: String = "") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    alertController.view.tintColor = AppConstant.themeRedColor
    self.present(alertController, animated: true, completion: nil)
  }
}
