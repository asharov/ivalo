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

    func makeColorView(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(view)
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let blueView = makeColorView(UIColor.blueColor())
        let redView = makeColorView(UIColor.redColor())
        let greenView = makeColorView(UIColor.greenColor())
        let yellowView = makeColorView(UIColor.yellowColor())

        view <-- Edge.Left +-+ blueView +-+ redView +-+ Edge.Right
        view <-- Edge.Top +-+ blueView +-+ greenView +-+ Edge.Bottom
        view <-- Edge.Left +-+ greenView +-+ yellowView +-+ Edge.Right
        view <-- Edge.Top +-+ redView +-+ yellowView +-+ Edge.Bottom

        view <-- |blueView| ~=~ |redView|
        view <-- |greenView| ~=~ |yellowView|
        view <-- -blueView- ~=~ -greenView-
        view <-- -redView- ~=~ -yellowView-
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

