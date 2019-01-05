//
//  ToolTipClass.swift
//  ToolTip
//
//  Created by Pulkit Rohilla on 12/03/18.
//  Copyright © 2018 PulkitRohilla. All rights reserved.
//

import UIKit

class ToolTipClass {

    static var mainView : UIView!
    static var isShown = false
    
    enum Direction : Int{
        
        case Right = 1,
        Left,
        Top,
        Bottom
    }
    
    class func showToolTip(forView view : UIView, withDescription description : String){
        
        if mainView != nil{
            
            mainView.removeFromSuperview()
        }
        
        let currentWindowScreen = UIApplication.shared.keyWindow
        mainView = UIView.init(frame: (currentWindowScreen?.frame)!)
        currentWindowScreen?.addSubview(mainView)
        
        mainView.alpha = 0
        mainView.backgroundColor = UIColor.clear
        mainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainView.isUserInteractionEnabled = false
        
        self.addToolTipWithDescription(description: description, view: view)
 
        UIView.animate(withDuration: 0.25, animations: {
            
            mainView.alpha = 1
            isShown = true
        })
        
    }
    
    class func addToolTipWithDescription(description: String, view : UIView){
        
        let descriptionView = UIView.init()
        descriptionView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        descriptionView.layer.cornerRadius = 6
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        let lblDescription = UILabel.init()
        lblDescription.numberOfLines = 0
        lblDescription.text = description
        lblDescription.textColor = UIColor.white
        lblDescription.backgroundColor = UIColor.clear
        lblDescription.font = UIFont.systemFont(ofSize: 12.0)
        lblDescription.textAlignment = .center
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionView.addSubview(lblDescription)
        
        let dictViews = ["lblDescription" : lblDescription] as [String : Any]
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[lblDescription]-8-|",
                                                                 options: .alignAllCenterX,
                                                                 metrics: nil,
                                                                 views: dictViews)
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[lblDescription]-8-|",
                                                                   options: .alignAllCenterY,
                                                                   metrics: nil,
                                                                   views: dictViews)
        
        descriptionView.addConstraints(verticalConstraints)
        descriptionView.addConstraints(horizontalConstraints)
        
        mainView.addSubview(descriptionView)
        
        lblDescription.setNeedsLayout()
        
        let globalFrame = view.convert(view.bounds.origin, to: nil)
        
        let pointX = globalFrame.x + view.frame.width/2
        let pointY = globalFrame.y + view.frame.height + 5
     
        let dictMetrics = ["PointX" : pointX,
                           "PointY" : pointY]
        
        let descriptionViewVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(PointY)-[descView]-(>=15)-|",
                                                                 options: NSLayoutFormatOptions.init(rawValue: 0),
                                                                 metrics: dictMetrics,
                                                                 views: ["descView" : descriptionView])
        
        mainView.addConstraint(NSLayoutConstraint.init(item: descriptionView,
                                                       attribute: .centerX,
                                                       relatedBy: .equal,
                                                       toItem: mainView,
                                                       attribute: .centerX,
                                                       multiplier: 1,
                                                       constant: 0))
        
//        let descriptionViewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(PointX)-[descView]-(>=15)-|",
//                                                                   options: NSLayoutFormatOptions.init(rawValue: 0),
//                                                                   metrics: dictMetrics,
//                                                                   views: ["descView" : descriptionView])
        
        mainView.addConstraints(descriptionViewVerticalConstraints)


//        mainView.addConstraints(descriptionViewHorizontalConstraints)
    }

    class func hide(){
        
        if mainView != nil {
            
            mainView.removeFromSuperview()
        }
        
        mainView = nil
        
        isShown = false
    }
}
