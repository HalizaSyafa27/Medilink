//
//  JitsiMeetingViewController.swift
//  OptimalHealth
//
//  Created by Oditek on 02/06/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit
import JitsiMeetSDK
//import JitsiMeet

class JitsiMeetingViewController: BaseViewController {

    @IBOutlet weak var txtFldMeetingRoom: UITextField!
    
    fileprivate var jitsiMeetView: JitsiMeetView?
    fileprivate var pipViewCoordinator: PiPViewCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        let rect = CGRect(origin: CGPoint.zero, size: size)
        pipViewCoordinator?.resetBounds(bounds: rect)
    }
    
    //MARK: Button Action
    @IBAction func btnBackAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnJoinAction (_ sender: UIButton) {
        if(self.txtFldMeetingRoom.text?.trim() == ""){
            self.displayAlert(message: "Meeting Room can not be blank")
        }else{
            self.view.endEditing(true)
            let room: String = txtFldMeetingRoom.text!
            if(room.count < 1) {
                return
            }
            
            // create and configure jitsimeet view
            let jitsiMeetView = JitsiMeetView()
            jitsiMeetView.delegate = self
            self.jitsiMeetView = jitsiMeetView
            let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
//                builder.welcomePageEnabled = false
                builder.room = room
            }
            
            //setup view controller
            let vc = UIViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.view = jitsiMeetView

            // join room and display jitsi-call
            jitsiMeetView.join(options)
            present(vc, animated: true, completion: nil)
            
            /*
            // Enable jitsimeet view to be a view that can be displayed
            // on top of all the things, and let the coordinator to manage
            // the view state and interactions
            pipViewCoordinator = PiPViewCoordinator(withView: jitsiMeetView)
            pipViewCoordinator?.configureAsStickyView(withParentView: self.view)

            // join room and display jitsi-call
            jitsiMeetView.join(options)
            // animate in
            jitsiMeetView.alpha = 0
            pipViewCoordinator?.show()*/
            
        }
    }
    
    fileprivate func cleanUp() {
        if(jitsiMeetView != nil) {
            dismiss(animated: true, completion: nil)
            jitsiMeetView = nil
            
            jitsiMeetView?.removeFromSuperview()
            pipViewCoordinator = nil
        }
    }
    
    func crearTextField(){
        self.txtFldMeetingRoom.text = ""
    }
    
    func pipJitsi(){
        cleanUp()

        // create and configure jitsimeet view
        let jitsiMeetView = JitsiMeetView()
        jitsiMeetView.delegate = self
        self.jitsiMeetView = jitsiMeetView
        let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
//            builder.welcomePageEnabled = true
        }
        jitsiMeetView.join(options)

        // Enable jitsimeet view to be a view that can be displayed
        // on top of all the things, and let the coordinator to manage
        // the view state and interactions
        pipViewCoordinator = PiPViewCoordinator(withView: jitsiMeetView)
        pipViewCoordinator?.configureAsStickyView(withParentView: view)

        // animate in
        jitsiMeetView.alpha = 0
//        pipViewCoordinator?.show()
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

extension JitsiMeetingViewController: JitsiMeetViewDelegate {
    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        cleanUp()
        self.crearTextField()
    }
    
    func enterPicture(inPicture data: [AnyHashable : Any]!) {
        DispatchQueue.main.async {
            self.pipViewCoordinator?.enterPictureInPicture()
        }
    }
}
