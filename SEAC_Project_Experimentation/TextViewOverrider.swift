//
//  TextViewOverrider.swift
//  SEAC_Project_Experimentation
//
//  Created by Student on 7/16/19.
//  Copyright © 2019 SEAC_Organization. All rights reserved.
//

import UIKit

class TextViewOverrider: UITextView {
    
    private lazy var _isScrollEnabled: Bool = false
    override var isScrollEnabled: Bool {
        get {return _isScrollEnabled}
        set { _isScrollEnabled = isScrollEnabled}
    }
}
