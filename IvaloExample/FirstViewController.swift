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
        let blueView = makeColorView(self.view, UIColor.blueColor())
        let redView = makeColorView(self.view, UIColor.redColor())
        let greenView = makeColorView(self.view, UIColor.greenColor())
        let yellowView = makeColorView(self.view, UIColor.yellowColor())

        view <-- Edge.Left +-+ blueView +-+ redView +-+ Edge.Right
            <-- Edge.Top +-+ blueView +-+ greenView
            <-- Edge.Left +-+ greenView +-+ yellowView +-+ Edge.Right
            <-- Edge.Top +-+ redView +-+ yellowView
            <-- |blueView| ~=~ 2 * |redView| ~=~ -redView- ~=~ 2 * -yellowView-
            <-- 2 * -blueView- ~=~ -greenView- ~=~ 2 * |redView| ~=~ |yellowView|
    }

}
