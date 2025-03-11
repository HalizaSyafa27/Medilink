//
//  ViewDocumentViewController.swift
//  OptimalHealth
//
//  Created by OdiTek Solutions on 31/05/19.
//  Copyright © 2019 Oditek. All rights reserved.
//

import UIKit

class ViewDocumentViewController: UIViewController, UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {
    
    @IBOutlet weak var viewDocCollectionView: UICollectionView!
    @IBOutlet var pageController: UIPageControl!
    @IBOutlet var navBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblPageHeader: UILabel!
    
    var arrImages = [UploadImageBo]()
    var currentVisiblePolicyCell = 0
    var prevPolicyCell:Int = 0
    var pageHeader: String = ""
    var scrolledToIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        initDesign()
    }
    
    func initDesign(){
        //Manage for iPhone X
        if (AppConstant.screenSize.height >= 812) {
            navBarHeightConstraint.constant = AppConstant.navBarHeight
            topBarHeightConstraint.constant = AppConstant.navBarHeight
        }
        
        self.viewDocCollectionView.isPagingEnabled = true
        //Set Page Indicator
        self.pageController.numberOfPages = arrImages.count
        lblPageHeader.text = pageHeader.uppercased()
        currentVisiblePolicyCell = scrolledToIndex
        self.pageController.currentPage = scrolledToIndex
        
        
        let layout = viewDocCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.minimumLineSpacing = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.viewDocCollectionView.scrollToItem(at: .init(row: self.currentVisiblePolicyCell, section: 0), at: .right, animated: false)
        })

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        pageController.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    
    //MARK: Button Action
    @IBAction func btnCloseAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Collection View Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewImageCollectionViewCell", for: indexPath) as! ViewImageCollectionViewCell
        
        let imgBo = self.arrImages[indexPath.row]
        cell.imgViewDoc.image = imgBo.image
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(collectionView.bounds.width)
        let height = Int(collectionView.bounds.height)
        print("cell size  = \(self.viewDocCollectionView.frame.size)")
        //return self.viewDocCollectionView.frame.size
        
        //Manage for iPhone X
        if (AppConstant.screenSize.height >= 812) {
            return CGSize(width: AppConstant.screenSize.width - 24, height: AppConstant.screenSize.height - (49 + 144))
        }else{
            return CGSize(width: AppConstant.screenSize.width - 24, height: AppConstant.screenSize.height - (49 + 122))
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = viewDocCollectionView.contentOffset
        visibleRect.size = viewDocCollectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        guard let indexPath = viewDocCollectionView.indexPathForItem(at: visiblePoint) else { return }
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let visibleIndex = Int(targetContentOffset.pointee.x / viewDocCollectionView.frame.width)
        print("visiblee cell is: \(visibleIndex)")
        print("velocity : \(scrollView.contentSize)")
        print("previous cell is: \(prevPolicyCell)")
        
        currentVisiblePolicyCell = visibleIndex
        self.pageController.currentPage = currentVisiblePolicyCell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("visible cell is: \(indexPath.row)")
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
