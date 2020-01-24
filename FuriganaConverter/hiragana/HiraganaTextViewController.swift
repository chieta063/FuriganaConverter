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

class HiraganaTextViewController: UIViewController, View {
    
    @IBOutlet weak var hiraganaTextView: UITextView!
    
    var disposeBag = DisposeBag()
    
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
    }
    
    func bind(reactor: MainReactor) {
        reactor.state.map { $0.convertedText }
            .distinctUntilChanged()
            .filter { text in
                !text.isEmpty
            }
            .bind { [weak self] text in
                self?.hiraganaTextView.text = text
            }
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.reset }
            .distinctUntilChanged()
            .filterNil()
            .bind { [weak self] _ in
                self?.hiraganaTextView.text.removeAll()
            }
            .disposed(by: self.disposeBag)
    }
}
