//
//  CustomAppBar.swift
//  SportsSpot
//
//  Created by AYA on 24/04/2024.
//

import UIKit

class CustomAppBar: UIView {
    
    @IBOutlet weak var backBtn: UIButton!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var appBarContainer: UIView!
    @IBOutlet weak var favouriteBtn: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
        
    }
    func setUp(){
        Bundle.main.loadNibNamed("CustomAppBar", owner: self)
        addSubview(appBarContainer)
        appBarContainer.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        appBarContainer.frame = self.bounds
        roundBottomCorners(radius: 25)
    }
    //view Rounded corner
    private func roundBottomCorners(radius: CGFloat) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: bounds,
                                      byRoundingCorners: [.bottomLeft, .bottomRight],
                                      cornerRadii: CGSize(width: radius, height: radius)).cgPath
        layer.mask = maskLayer
    }
}
