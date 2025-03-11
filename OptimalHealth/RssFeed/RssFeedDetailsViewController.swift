//
//  RssFeedDetailsViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 07/05/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit

class RssFeedDetailsViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPublishedOn: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    
    var newsBo = News()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDesign()
    }
    
    func initDesign(){
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topViewHeightConstraint.constant = 92
        }
        lblTitle.text = newsBo.title.html2String
        lblPublishedOn.text = AppConstant.convertDateToString(strDate: newsBo.pubDate.html2String.trim(), currDateFormat: StringConstant.dateFormatter10, requiredDateFormat: StringConstant.dateFormatter11)
        lblDesc.text = newsBo.desc.html2String.trim()
    }
    
    // MARK: - Button Action
    @IBAction func backBtnAction (_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
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
