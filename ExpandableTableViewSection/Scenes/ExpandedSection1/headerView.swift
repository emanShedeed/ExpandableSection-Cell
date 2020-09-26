//
//  headerView.swift
//  ExpandableTableViewSection
//
//  Created by gody on 9/11/20.
//  Copyright © 2020 gody. All rights reserved.
//

import UIKit

protocol headerViewProtcol {
    func headerViewPressed(atSection:Int)
}

class headerView: UIView {
    var delegate : headerViewProtcol?
    var secIndex:Int?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(btn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var btn:UIButton = {
        let btn = UIButton(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height))
        btn.backgroundColor=#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        btn.titleLabel?.textColor = .black
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(headerViewPressed), for: .touchUpInside)
        return btn
    }()
    @objc func headerViewPressed(){
        if let index = secIndex{
            delegate?.headerViewPressed(atSection: index)
        }
    }
}
