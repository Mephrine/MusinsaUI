//
//  ADSlideBannerPageVC.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/12.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

class ADSlideBannerPageVC: UIViewController {
    @IBOutlet weak var ivBanner: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure(strURL: String) {
        if let url = URL(string: strURL) {
            ivBanner.kf.setImage(with: url)
        }
    }
}
