//
//  NotificationMessagesViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 9/5/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import CoreData

class NotificationMessagesViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet var notificationTableView: UITableView!
    @IBOutlet var lblNoDataAvailable: UILabel!
    @IBOutlet var btnDeleteAll: UIButton!
    @IBOutlet var btnDeleteHeightConstraint: NSLayoutConstraint!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet var lbltitle: UILabel!
    @IBOutlet var imgViewTitle: UIImageView!
    @IBOutlet var viewMessagesSeparator: UIView!
    @IBOutlet var viewAdvisorySeparator: UIView!
    @IBOutlet var lblMessageUnreadCount: UILabel!
    @IBOutlet var lblAdvisoryUnreadCount: UILabel!
    //var itemInfo: IndicatorInfo = "Notification (1)"
    
    var arrMessages = [PushMessages]()
    var type: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDesign()
    }
    
    func initDesign(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.retriveDataFromDatabase), name: NSNotification.Name(rawValue: StringConstant.updateNotificationCount), object: nil)
        
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        //self.lbltitle.text = type == "2" ? "ADVISORY" : "MESSAGES"
        //self.imgViewTitle.image  = type == "2" ? UIImage.init(named: "medical-advisory-white") : UIImage.init(named: "message_icon_white")
        
        //retrive messages from database
        retriveDataFromDatabase()
        //updateReadStatusForAllMessages()
        viewMessagesSeparator.isHidden = false
        viewAdvisorySeparator.isHidden = true
        
        //Message Count
        lblMessageUnreadCount.layer.cornerRadius = lblMessageUnreadCount.frame.size.width / 2
        lblMessageUnreadCount.clipsToBounds = true
        
        //Health Advisory Count
        lblAdvisoryUnreadCount.layer.cornerRadius = lblAdvisoryUnreadCount.frame.size.width / 2
        lblAdvisoryUnreadCount.clipsToBounds = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        updateReadCount()
    }
    
    //MARK: Coredata Methods
    @objc func retriveDataFromDatabase(){
        self.arrMessages.removeAll()
        
        let userId = AppConstant.retrievFromDefaults(key: StringConstant.email)
        let fetchRequest: NSFetchRequest<PushMessages> = PushMessages.fetchRequest()
        if type == "2"{
            let predicate = NSPredicate(format: "userId = %@ AND type = %@", argumentArray: [userId, type])
            fetchRequest.predicate = predicate
        }else{
            let predicate = NSPredicate(format: "userId = %@ AND type != 2", argumentArray: [userId])
            fetchRequest.predicate = predicate
        }
        
        
        do {
            let sort = NSSortDescriptor(key: "insertedDate", ascending: false)
            fetchRequest.sortDescriptors = [sort]
            let messages = try CoreDataManager.context.fetch(fetchRequest)
            
            self.arrMessages = messages
        } catch {}
        
//        let set = NSSet(array: self.arrMessages)
//        self.arrMessages = set.allObjects as! [PushMessages]
        self.notificationTableView.reloadData()
        
        self.lblNoDataAvailable.isHidden = arrMessages.count == 0 ? false : true
        self.notificationTableView.isHidden = arrMessages.count == 0 ? true : false
        self.btnDeleteHeightConstraint.constant = arrMessages.count == 0 ? 0 : 40
        self.btnDeleteAll.isHidden = arrMessages.count == 0 ? true : false
        
        showUnreadCount()
        
    }
    
    func deleteAllData(_ entity:String) {
        //PushMessages
        let userId = AppConstant.retrievFromDefaults(key: StringConstant.email)
        
        var predicate = NSPredicate(format: "userId = %@ AND type = %@", argumentArray: [userId, type])
        
        if type != "2"{
            predicate = NSPredicate(format: "userId = %@ AND type != 2", argumentArray: [userId])
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        do {
            let results = try CoreDataManager.context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                CoreDataManager.context.delete(objectData)
            }
            
            retriveDataFromDatabase()
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    //MARK: Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationMessagesTableViewCell", for: indexPath as IndexPath) as! NotificationMessagesTableViewCell
        cell.selectionStyle = .none
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(showAlertToDelete(btn:)), for: .touchUpInside)
        
        let msgBo = self.arrMessages[indexPath.row]
        
        if msgBo.msg == nil{
            msgBo.msg = ""
        }
        if msgBo.id == nil{
            msgBo.id = ""
        }
        if msgBo.date == nil{
            msgBo.date = ""
            cell.lbldate.text = ""
        }else{
            cell.lbldate.text = AppConstant.formattedDateFromString(dateString: msgBo.date!, withFormat: StringConstant.dateFormatter7, ToFormat: StringConstant.dateFormatter6)
            if (cell.lbldate.text == "") {
                cell.lbldate.text = AppConstant.formattedDateFromString(dateString: msgBo.date!, withFormat: StringConstant.dateFormatter14, ToFormat: StringConstant.dateFormatter6)
            }
        }
        
        if msgBo.readStatus == true{//Read
            cell.viewContainer.backgroundColor = AppConstant.readMsgBgColor
        }else{//Unread
            cell.viewContainer.backgroundColor = AppConstant.unreadMsgBgColor
        }
        
        cell.lblMessage.text = msgBo.msg!
        
        return cell
    }
    
    // MARK: - Button Action
    @IBAction func btnTabAction(_ sender: UIButton) {
        updateReadCount()
        if sender.tag == 2{//Advisory
            type = "2"
            viewMessagesSeparator.isHidden = true
            viewAdvisorySeparator.isHidden = false
        }else{//Messages
            type = ""
            viewMessagesSeparator.isHidden = false
            viewAdvisorySeparator.isHidden = true
        }
        
        retriveDataFromDatabase()
        
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnHomeAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnDeleteAllMessagesAction(_ sender: Any) {
        showAlertToDelete(btn: btnDeleteAll)
    }
    
    @objc func showAlertToDelete(btn: UIButton){
        let alert = UIAlertController(title: btn.tag == -1 ? StringConstant.deleteAllMsg : StringConstant.deleteMsg, message: "", preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = AppConstant.themeRedColor
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
            
            if btn.tag == -1 {
                self.deleteAllData("PushMessages")
            }else{
                //Delete From database
                let messageBo = self.arrMessages[btn.tag]
                CoreDataManager.context.delete(messageBo)
                
                do {
                    CoreDataManager.saveContext()
                } catch let error as NSError {
                    print("Error While Deleting Note: \(error.userInfo)")
                }
                
                self.retriveDataFromDatabase()
            }
            
        })
        alert.addAction(yesAction)
        alert.preferredAction = yesAction
        
        alert.view.tintColor = AppConstant.themeRedColor
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateReadCount(){
        for items in self.arrMessages{
            if items.type == type{
                items.readStatus = true
            }
        }
        CoreDataManager.saveContext()
        
    }
    
    func showUnreadCount(){
        var arrUnreadMessages = [PushMessages]()
        let userId = AppConstant.retrievFromDefaults(key: StringConstant.email)
                let fetchRequest: NSFetchRequest<PushMessages> = PushMessages.fetchRequest()
                let predicate = NSPredicate(format: "userId = %@", argumentArray: [userId, type])
                fetchRequest.predicate = predicate
                
                do {
                    let sort = NSSortDescriptor(key: "insertedDate", ascending: false)
                    fetchRequest.sortDescriptors = [sort]
                    let messages = try CoreDataManager.context.fetch(fetchRequest)
                    
                    arrUnreadMessages = messages
                    
                } catch {}
        
        var unreadMsgCount = 0
        var unreadAdvisoryCount = 0
        print("count \(self.arrMessages.count)")
        for items in arrUnreadMessages{
            print(items.readStatus)
            if items.readStatus == false{
                if items.type == "2"{//Advisory
                    unreadAdvisoryCount = unreadAdvisoryCount + 1
                }else{
                    unreadMsgCount = unreadMsgCount + 1
                }
            }
        }
                
        self.lblMessageUnreadCount.text = unreadMsgCount == 0 ? "" : "\(unreadMsgCount)"
        self.lblAdvisoryUnreadCount.text = unreadAdvisoryCount == 0 ? "" : "\(unreadAdvisoryCount)"
        self.lblMessageUnreadCount.isHidden = unreadMsgCount == 0 ? true : false
        self.lblAdvisoryUnreadCount.isHidden = unreadAdvisoryCount == 0 ? true : false
    }
    
    // MARK: - Memory Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension UIButton {
    func setTitleWithoutAnimation(title: String?) {
        UIView.setAnimationsEnabled(false)

        setTitle(title, for: .normal)

        layoutIfNeeded()
        UIView.setAnimationsEnabled(true)
    }
}
