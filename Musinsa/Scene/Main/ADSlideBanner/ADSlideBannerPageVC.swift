//
//  ADSlideBannerPageVC.swift
//  Musinsa
//
//  Created by Mephrine on 2020/06/12.
//  Copyright © 2020 Mephrine. All rights reserved.
//

import UIKit

/**
 # (C) ADSlideBannerPageVC.swift
 - Author: Mephrine
 - Date: 20.06.12
 - Note: 광고 슬라이드 배너 페이지 ViewController
*/
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
    
    /**
    # configure
    - Author: Mephrine
    - Date: 20.06.12
    - Parameters:
        - strURL : 이미지 URL
    - Returns:
    - Note: 현재 페이지의 이미지뷰에 해당 URL 이미지 지정
    */
    func configure(_ strURL: String) {
        if let url = URL(string: strURL) {
            ivBanner.kf.setImage(with: url)
        }
    }
    
    /**
    # tapBtnBanner
    - Author: Mephrine
    - Date: 20.06.12
    - Parameters:
    - Returns:
    - Note: 현재 페이지를 클릭했을 때 실행되는 함수
    */
    @objc func tapBtnBanner() {
        viewModel?.goDetail()
    }
}
