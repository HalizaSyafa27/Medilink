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
    var selectedIndex: Int = 0

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
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewImageCollectionViewCell", for: indexPath) as! ViewImageCollectionViewCell
//        
//        let imgBo = self.arrImages[indexPath.row]
//        cell.imgViewDoc.image = imgBo.image
//        
//        
//        return cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewImageCollectionViewCell", for: indexPath) as! ViewImageCollectionViewCell

        let imgBo = self.arrImages[indexPath.row]
        cell.imgViewDoc.image = imgBo.image

        // Pastikan imgViewDoc bisa menerima gesture
        cell.imgViewDoc.isUserInteractionEnabled = true
        cell.imgViewDoc.tag = indexPath.row

        // Hapus gesture sebelumnya agar tidak dobel
        cell.imgViewDoc.gestureRecognizers?.forEach { cell.imgViewDoc.removeGestureRecognizer($0) }

        // Tambahkan gesture untuk membuka ZoomImageViewController
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap(_:)))
        cell.imgViewDoc.addGestureRecognizer(tapGesture)

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
    
    @objc func handleImageTap(_ sender: UITapGestureRecognizer) {
//        let tappedIndex = sender.view?.tag ?? 0
//            showZoomImageViewController(for: tappedIndex)
        let tappedIndex = sender.view?.tag ?? 0
            print("Gambar di ViewDocumentViewController dengan index \(tappedIndex) diklik") // Debugging
            showZoomImageViewController(for: tappedIndex)
    }

    func showZoomImageViewController(for index: Int) {
//        selectedIndex = index  // ✅ Simpan index sebelum membuka ZoomImageViewController
//        let zoomVC = storyboard?.instantiateViewController(withIdentifier: "ZoomImageViewController") as! ZoomImageViewController
//        zoomVC.selectedImage = arrImages[index].image
//        self.present(zoomVC, animated: true, completion: nil)
//        selectedIndex = index
        print("Segue ke showZoomImage dipanggil dari ViewDocumentViewController") 
        performSegue(withIdentifier: "showZoomImage", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("visible cell is: \(indexPath.row)")
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if segue.identifier == "viewDoc" {
            let vc = segue.destination as! ViewDocumentViewController
            vc.arrImages = arrImages
            vc.pageHeader = pageHeader
            vc.scrolledToIndex = selectedIndex
            print("Segue ke ViewDocumentViewController dengan index: \(selectedIndex)")
        } else if segue.identifier == "showZoomImage" {
            let zoomVC = segue.destination as! ZoomImageViewController
            zoomVC.selectedImage = arrImages[selectedIndex].image
            print("Segue ke ZoomImageViewController dengan index: \(selectedIndex)")
        }
    }

}
