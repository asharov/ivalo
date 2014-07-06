//
//  Helper.swift
//  Ivalo
//
//  Created by Jaakko Kangasharju on 06/07/14.
//  Copyright (c) 2014 Jaakko Kangasharju. All rights reserved.
//

import UIKit

func makeColorView(superview: UIView, color: UIColor) -> UIView {
    let view = UIView()
    view.backgroundColor = color
    view.setTranslatesAutoresizingMaskIntoConstraints(false)
    superview.addSubview(view)
    return view
}
