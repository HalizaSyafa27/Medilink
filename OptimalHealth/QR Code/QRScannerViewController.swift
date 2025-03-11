//
//  QRScannerViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 23/08/18.
//  Copyright © 2018 Oditek. All rights reserved.
//

import UIKit
import AVFoundation

@objc protocol QRScannerDelegate: class {
    @objc optional func detectedQRcodeValue(QrValue: String)
}

class QRScannerViewController: BaseViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet var lblInfo: UILabel!
    @IBOutlet var viewPreview: UIView!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet var lblHeader: UILabel!
    @IBOutlet var lblPageTitle: UILabel!
    @IBOutlet var imgViewHeader: UIImageView!
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var pageHeader = ""
    var pageTitle = ""
    var headerImage = ""
    weak var delegate: QRScannerDelegate?
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                      AVMetadataObject.ObjectType.code39,
                                      AVMetadataObject.ObjectType.code39Mod43,
                                      AVMetadataObject.ObjectType.code93,
                                      AVMetadataObject.ObjectType.code128,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.aztec,
                                      AVMetadataObject.ObjectType.pdf417,
                                      AVMetadataObject.ObjectType.itf14,
                                      AVMetadataObject.ObjectType.dataMatrix,
                                      AVMetadataObject.ObjectType.interleaved2of5,
                                      AVMetadataObject.ObjectType.qr]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Manage for iPhone X
        if AppConstant.screenSize.height >= 812{
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        lblHeader.text = pageHeader
        lblPageTitle.text = pageTitle
        imgViewHeader.image = UIImage.init(named: headerImage)
        self.preareForScan()
    }
    
    func preareForScan(){
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
        // as the media type parameter.
        let captureDevice = AVCaptureDevice.default(for: .video)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            
            if captureDevice == nil {
                self.displayAlert(message: StringConstant.noCameraMsg)
                _ = navigationController?.popViewController(animated: true)
                return
            }
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            // Detect all the supported bar code
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            viewPreview.layer.addSublayer(videoPreviewLayer!)
            lblInfo.bringSubviewToFront(viewPreview)
            
            // Start video capture
            captureSession?.startRunning()
            
            // Move the message label to the top view
            //view.bringSubviewToFront(messageLabel)
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                viewPreview.addSubview(qrCodeFrameView)
                viewPreview.bringSubviewToFront(qrCodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    
    
    //MARK: QR Scanner Delegate
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            // messageLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata (or barcode) then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                // Stop video capture
                captureSession?.stopRunning()
                print("QR value: \(metadataObj.stringValue!)")
                self.delegate?.detectedQRcodeValue!(QrValue: metadataObj.stringValue!)
                _ = navigationController?.popViewController(animated: true)
                return
            }
        }
    }
    
    func loadBeepSound() {
        //        let beepFilePath = Bundle.main.path(forResource: "beep", ofType: "mp3")
        //        let beepURL = URL(fileURLWithPath: beepFilePath ?? "")
        //        let error: Error?
        //
        //        let audioPlayer = try? AVAudioPlayer(contentsOf: beepURL)
        //        if error != nil {
        //            print("Could not play beep file.")
        //            print("\(error?.localizedDescription ?? "")")
        //        } else {
        //            audioPlayer?.prepareToPlay()
        //        }
    }
    
    //MARK: Button Action
    @IBAction func btnBackAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func BtnHomeAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

