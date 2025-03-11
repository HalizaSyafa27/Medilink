//
//  MyDatePickerViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 03/08/19.
//  Copyright © 2019 Oditek. All rights reserved.
//

import UIKit
//import HEDatePicker

protocol myDatePickerDelegate: class {
    func mydatePickerPickedDate(dt: Date)
}

class MyDatePickerViewController: UIViewController, HEDatePickerDelegate {
    
    @IBOutlet var datePicker: HEDatePicker!
    @IBOutlet var viewDatePicker: UIView!
    @IBOutlet var lblDatePickerTitle: UILabel!
    
    var selecteddate = Date()
    var minimumDate = Date()
    var maximumDate = Date()
    var StrTitle = "Choose Date"
    weak var delegate: myDatePickerDelegate?
    var selectedDateStr = ""
    var myDateFormatter = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDesign()
    }
    
    func initDesign(){
        viewDatePicker.layer.cornerRadius = 5.0
        viewDatePicker.clipsToBounds = true
        lblDatePickerTitle.text = StrTitle
        
        self.datePicker.delegate = self
        
        self.datePicker.pickerType = .date
        //self.datePicker.minimumDate = minimumDate
//        self.datePicker.maximumDate = maximumDate
        self.datePicker.identifier = .gregorian
        self.datePicker.locale = Locale(identifier: "en_US")
//        self.datePicker.identifier = .persian
//        self.datePicker.locale = Locale(identifier: "fa_IR")
        
        self.datePicker.font = UIFont.systemFont(ofSize: 19.0, weight: .medium)
        //UIFont.init(name: "Poppins-Medium", size: 22.0)!
        if selectedDateStr == ""{
            self.datePicker.setDate(Date(), animated: false)
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = myDateFormatter
            let date = dateFormatter.date(from: selectedDateStr)
            self.datePicker.setDate(date!, animated: false)
        }
        self.datePicker.reloadAllComponents()
        
    }
    
    //MARK: Date Picker Delegate
    func pickerView(_ pickerView: HEDatePicker, didSelectRow row: Int, inComponent component: Int) {
    }
    
    //MARK: Button Action
    
    @IBAction func cancelBtnAction (_ sender: UIButton) {
        self.remove()
    }
    
    @IBAction func doneBtnAction (_ sender: UIButton) {
        self.remove()
        print("Selected date === \(datePicker.date)")
        delegate?.mydatePickerPickedDate(dt: datePicker.date)
        
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
public extension UIViewController {
    
    /// Adds child view controller to the parent.
    ///
    /// - Parameter child: Child view controller.
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    /// It removes the child view controller from the parent.
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
