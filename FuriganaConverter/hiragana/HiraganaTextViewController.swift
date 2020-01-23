//
//  HiraganaTextViewController.swift
//  FuriganaConverter
//
//  Created by FVFWX0K3HV2H on 2020/01/23.
//  Copyright © 2020 阿部紘明. All rights reserved.
//

import UIKit
import SnapKit

class HiraganaTextViewController: UIViewController {
    
    @IBOutlet weak var hiraganaTextView: UITextView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
