//
//  PaymentsRecordsCellView.swift
//  EOS
//
//  Created by DKM on 2018/7/9.
//  Copyright © 2018年 com.nbltrust. All rights reserved.
//

import UIKit

class PaymentsRecordsCellView: UIView {
    
    @IBOutlet weak var state: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var transferState: UILabel!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var transferStateView: UIView!
    
    
    var data : Any?{
        didSet{
            
        }
    }
    
    
    func setup(){
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromXIB()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromXIB()
        setup()
    }
    
    
    
    func updateHeight(){
        layoutIfNeeded()
        self.height = dynamicHeight()
        invalidateIntrinsicContentSize()
    }
    
    fileprivate func dynamicHeight() -> CGFloat {
        let view = self.subviews.last?.subviews.last
        return (view?.frame.origin.y)! + (view?.frame.size.height)!
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: dynamicHeight())
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
    }
    
    
    
    
    func loadFromXIB(){
        let bundle = Bundle(for: type(of: self))
        let nib = UINib.init(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
}
