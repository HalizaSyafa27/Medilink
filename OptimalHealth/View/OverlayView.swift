//
//  OverlayView.swift
//  OptimalHealth
//
//  Created by cuscsoftware on 10/12/21.
//  Copyright © 2021 Oditek. All rights reserved.
//

import UIKit
@objc protocol OkDelegate: AnyObject {
    @objc optional func selectedOk(action: String)
}

class OverlayView: UIViewController {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    weak var delegate: OkDelegate?
    @IBOutlet weak var lblMessages: UILabel!
    @IBOutlet weak var OK: UIButton!
    var actionString:String = StringConstant.NO
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        let msg = AppConstant.retrievFromDefaults(key: StringConstant.messageAlert)
        lblMessages.text = msg
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if actionString == StringConstant.dependentStoryboard{
            self.delegate?.selectedOk!(action: StringConstant.YES)
        }
    }
    
    @IBAction func onOKAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        if actionString == StringConstant.dependentStoryboard{
            self.delegate?.selectedOk!(action: StringConstant.YES)
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}



