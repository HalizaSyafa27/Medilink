//
//  KnowledgeWindowPopupViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 30/11/20.
//  Copyright © 2020 Oditek. All rights reserved.
//

import UIKit
import WebKit

class KnowledgeWindowPopupViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet weak var lblKnowledgeWindow: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    var knowledgeUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDesign()
    }
    
    func initDesign(){
        let attributedText = NSMutableAttributedString(string: "Knowledge", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        let attributedTxt = NSMutableAttributedString(string: " Window", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)])
        
        attributedText.append(attributedTxt)
        lblKnowledgeWindow.attributedText = attributedText
        
        webView.navigationDelegate = self
        
        print("url=== \(knowledgeUrl)")
        
        if let url = URL(string: knowledgeUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!){
            webView.load(URLRequest(url: url))
        }
        
    }
    
    //MARK: Button Action
    @IBAction func btnCloseAction(_ sender: Any) {
        self.removeFromParent()
        self.view.removeFromSuperview()
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
