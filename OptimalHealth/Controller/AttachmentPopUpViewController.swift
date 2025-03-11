//
//  AttachmentPopUpViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 03/02/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit

@objc protocol ChooseMenuDelegate: class {
    @objc optional func selectedDocumentPickerPopup(tag : Int)
}

class AttachmentPopUpViewController: UIViewController {

    @IBOutlet weak var viewAttachment: UIView!
    @IBOutlet weak var viewDocument: UIView!
    @IBOutlet weak var viewGallery: UIView!
    @IBOutlet weak var viewCamera: UIView!
    
    weak var delegate: ChooseMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setViewAction()

    }
    
    func setViewAction(){
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(self.dismissAttachmentViewGesture))
        self.viewAttachment.addGestureRecognizer(dismiss)
        
    }
    
   @objc func dismissAttachmentViewGesture(gesture: UIGestureRecognizer) {
            dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnMenuSelectedAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        delegate?.selectedDocumentPickerPopup!(tag : sender.tag)
    }
    
    
}
