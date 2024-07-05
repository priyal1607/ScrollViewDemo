//
//  ViewController.swift
//  ScrollDemo
//
//  Created by Madhav Zala on 02/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var colView: UICollectionView!
    
    //Variables
    var arrBottom = ["0_front", "1_front", "2_front", "3_front", "4_front", "5_front", "6_front", "7_front", "8_front", "9_front"]
    var datasourceDelegate: BottomDatasourceDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupColView()
    }
    
    private func setupColView() {
        if datasourceDelegate == nil {
            datasourceDelegate = .init(arrData: arrBottom, delegate: self, col: colView, scrollView: mainScrollView)
        } else {
            datasourceDelegate.reload(arr: arrBottom)
        }
    }

}

extension ViewController: ColViewDelegate {
    
}
