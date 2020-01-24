//
//  ViewController.swift
//  FuriganaConverter
//
//  Created by 阿部紘明 on 2020/01/22.
//  Copyright © 2020 阿部紘明. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class MainViewController: UIViewController, StoryboardView {
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    var disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = MainReactor(convertApi: ConvertAPI())
        
        self.addChild(KanjiTextViewController(reactor: self.reactor!))
        self.addChild(HiraganaTextViewController(reactor: self.reactor!))
        
        self.modeSegmentedControl.rx.selectedSegmentIndex.bind { index in
            for (i, child) in self.children.enumerated() {
                if i == index {
                    self.addChildViewController(viewController: child)
                } else {
                    self.removeChildViewController(viewController: child)
                }
            }
        }.disposed(by: self.disposeBag)
    }
    
    func bind(reactor: MainReactor) {
        
    }
    
    private func addChildViewController(viewController: UIViewController) {
        self.containerView.addSubview(viewController.view)
        viewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        viewController.didMove(toParent: self)
    }
    
    private func removeChildViewController(viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
    }
}

