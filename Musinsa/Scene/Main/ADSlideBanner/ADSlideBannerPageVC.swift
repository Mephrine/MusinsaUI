//
//  ADSlideBannerPageVC.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/12.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

final class ADSlideBannerPageVC: BaseVC, ViewControllerProtocol {
    var viewModel: ADSlideBannerPageVM?
    
    @IBOutlet weak var ivBanner: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initView() {
        // 버튼 생성
        let btnPage = UIButton(frame: CGRect.zero)
        btnPage.backgroundColor = .clear
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBtnBanner))
        btnPage.addGestureRecognizer(tapGesture)
        
        self.view.addSubview(btnPage)
        btnPage.makeConstSuperView()
        
        self.ivBanner.contentMode = .scaleAspectFill
    }
    
    func configure(_ strURL: String) {
        if let url = URL(string: strURL) {
            ivBanner.kf.setImage(with: url)
        }
    }
    
    @objc func tapBtnBanner() {
        viewModel?.goDetail()
    }
}
