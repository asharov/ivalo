//
//  FirstViewController.swift
//  IvaloExample
//
//  Created by Jaakko Kangasharju on 05/07/14.
//  Copyright (c) 2014 Jaakko Kangasharju. All rights reserved.
//

import UIKit
import Ivalo

class FirstViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let blueView = UIView()
        blueView.backgroundColor = UIColor.blueColor()
        blueView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(blueView)

        view <-- Edge.Left +-+ blueView +-+ Edge.Right;
        self.view.addConstraint(NSLayoutConstraint(item: blueView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 0.0, constant: 100.0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

