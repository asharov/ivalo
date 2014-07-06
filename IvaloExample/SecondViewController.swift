//
//  SecondViewController.swift
//  IvaloExample
//
//  Created by Jaakko Kangasharju on 05/07/14.
//  Copyright (c) 2014 Jaakko Kangasharju. All rights reserved.
//

import UIKit
import Ivalo

class SecondViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let blueView = makeColorView(self.view, UIColor.blueColor())
        let redView = makeColorView(self.view, UIColor.redColor())
        let greenView = makeColorView(self.view, UIColor.greenColor())
        let yellowView = makeColorView(self.view, UIColor.yellowColor())

        view <-- |blueView| ~=~ 200
        view <-- -blueView- ~=~ 100
    }

}

