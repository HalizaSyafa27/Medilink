//
//  ViewMapPopUpViewController.swift
//  OptimalHealth
//
//  Created by Chinmaya Sahu on 8/17/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit

class ViewMapPopUpViewController: BaseViewController {
    
    @IBOutlet var popUpView: UIView!
    @IBOutlet var googleView: UIView!
    @IBOutlet var wazeView: UIView!
    @IBOutlet var cancelBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        initDesigns()
        
    }
    
    func initDesigns() {
        popUpView.layer.cornerRadius = 5
        popUpView.clipsToBounds = true
        
        let tapGoogle = UITapGestureRecognizer(target: self, action: #selector(self.openGoogleMapAction(_sender:)))
        self.googleView.isUserInteractionEnabled = true
        self.googleView.addGestureRecognizer(tapGoogle)
        
        let tapWaze = UITapGestureRecognizer(target: self, action: #selector(self.openWazeMapAction(_sender:)))
        self.wazeView.isUserInteractionEnabled = true
        self.wazeView.addGestureRecognizer(tapWaze)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Action
    @IBAction func cancelBtnAction (_ sender: UIButton) {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.view.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished)
            {
                self.willMove(toParent: nil)
                self.removeFromParent()
                self.view.removeFromSuperview()
            }
        })
    }
    
    @objc func openGoogleMapAction (_sender: UIGestureRecognizer) {
        if ((AppConstant.selectedPanelProvider.latitude != "") && (AppConstant.selectedPanelProvider.longitude != "")) {
            performSegue(withIdentifier: "google_map", sender: self)
            self.willMove(toParent: nil)
            self.removeFromParent()
            self.view.removeFromSuperview()
        }else {
            self.displayAlert(message: StringConstant.mapLocationMsg)
        }
    }
    
    @objc func openWazeMapAction (_sender: UIGestureRecognizer) {
        if ((AppConstant.selectedPanelProvider.latitude != "") && (AppConstant.selectedPanelProvider.longitude != "")) {
            openWaze()
            self.willMove(toParent: nil)
            self.removeFromParent()
            self.view.removeFromSuperview()
        }else {
            self.displayAlert(message: StringConstant.mapLocationMsg)
        }
    }
    
    func openWaze(){
        if UIApplication.shared.canOpenURL(URL(string: "waze://")!) {
            // Waze is installed. Launch Waze and start navigation
            let urlStr: String = "waze://?ll=\(AppConstant.selectedPanelProvider.latitude),\(AppConstant.selectedPanelProvider.longitude)&navigate=yes"
            UIApplication.shared.open(URL(string: urlStr)!)
            print(urlStr)
            //UIApplication.shared.openURL(URL(string: urlStr)!)
        }
        else {
            // Waze is not installed. Launch AppStore to install Waze app
            performSegue(withIdentifier: "waze_map", sender: self)
            
        }
    }
    
    //MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "google_map") {
            //let vc = segue.destination as! ViewGoogleMapViewController
            return
        }
        else if (segue.identifier == "waze_map") {
            //let vc = segue.destination as! ViewWazeMapViewController
            return
        }
    }

    
}
