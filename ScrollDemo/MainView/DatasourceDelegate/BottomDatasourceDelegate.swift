//
//  BottomDatasourceDelegate.swift
//  ScrollDemo
//
//  Created by Madhav Zala on 02/07/24.
//

import UIKit
import CenteredCollectionView

@objc protocol ColViewDelegate: NSObjectProtocol {
    @objc optional func didSelect(colView: UICollectionView, atIndexPath: IndexPath)
    @objc optional func willDisplay(colView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath)
    @objc optional func coldidScroll(scrollView: UICollectionView)
}

class BottomDatasourceDelegate: NSObject {
    let SCREEN_WIDTH = CGFloat(UIScreen.main.bounds.size.width)
    let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    typealias T = String
    typealias col = UICollectionView
    typealias del = ColViewDelegate
    
    internal var arrSource: [T]
    internal var colvw: col
    internal var scrView: UIScrollView
    internal var delegate: del
    
    let cellPercentWidth: CGFloat = 0.7
    var lastContentOffsetX: CGFloat = 0.0
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    
    //MARK:- Initializers
    required init(arrData: [T], delegate: ColViewDelegate, col: UICollectionView, scrollView: UIScrollView) {
        arrSource = arrData
        colvw = col
        self.delegate = delegate
        self.scrView = scrollView
        super.init()
        setupCol()
    }
    
    fileprivate func setupCol(){
        
        centeredCollectionViewFlowLayout = (colvw.collectionViewLayout as! CenteredCollectionViewFlowLayout)
        colvw.decelerationRate = UIScrollView.DecelerationRate.fast
        
        centeredCollectionViewFlowLayout.itemSize = CGSize(
            width: colvw.bounds.width * cellPercentWidth,
            height: SCREEN_HEIGHT*0.23
        )
        centeredCollectionViewFlowLayout.minimumLineSpacing = 20
        let nib = UINib(nibName: "BottomCVC", bundle: nil)
        colvw.register(nib, forCellWithReuseIdentifier: "BottomCVC")
        colvw.dataSource = self
        colvw.delegate = self
        colvw.reloadData()
    }
    
    func reload(arr:[T]){
        arrSource = arr
        colvw.reloadData()
    }
}

extension BottomDatasourceDelegate:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.didSelect?(colView: colvw, atIndexPath: indexPath)
    }
    
}
extension BottomDatasourceDelegate:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomCVC", for: indexPath) as! BottomCVC
        cell.img.image = UIImage(named: arrSource[indexPath.row]) 
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let colContentX = colvw.contentOffset.x
        let scrlContentY = scrView.contentOffset.x
        if let current = centeredCollectionViewFlowLayout.currentCenteredPage {
            if current == 0 {
                scrView.contentOffset = CGPoint(x: colvw.contentOffset.x+59, y: 0)
            } else {
                scrView.contentOffset = CGPoint(x: colvw.contentOffset.x - scrView.contentOffset.x, y: 0)
            }
        }
        print(colvw.contentOffset.x, scrView.contentOffset.x)
    }
    
}
