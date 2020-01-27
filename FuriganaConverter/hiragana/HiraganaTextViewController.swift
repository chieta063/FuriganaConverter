//
//  HiraganaTextViewController.swift
//  FuriganaConverter
//
//  Created by FVFWX0K3HV2H on 2020/01/23.
//  Copyright © 2020 阿部紘明. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import ReactorKit
import UITextView_Placeholder
import Swinject
import SwinjectAutoregistration

class HiraganaTextViewController: UIViewController, View {
    
    @IBOutlet weak var hiraganaTextView: UITextView!
    
    var disposeBag = DisposeBag()
    
    static let container = Container(parent: MainViewController.container) { container in
        container.autoregister(HiraganaTextViewController.self, initializer: HiraganaTextViewController.init)
    }
    
    init(reactor: MainReactor) {
        super.init(nibName: nil, bundle: nil)
        self.rx.methodInvoked(#selector(viewDidLoad))
            .bind { [weak self] _ in
                self?.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hiraganaTextView.placeholder = R.string.placeHolders.hiragana()
    }
    
    func bind(reactor: MainReactor) {
        reactor.state.map { $0.convertedText }
            .filter { text in
                !text.isEmpty
            }
            .bind { [weak self] text in
                self?.hiraganaTextView.text = text
            }
            .disposed(by: self.disposeBag)
    }
}
