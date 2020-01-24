//
//  KanjiTextViewController.swift
//  FuriganaConverter
//
//  Created by FVFWX0K3HV2H on 2020/01/23.
//  Copyright © 2020 阿部紘明. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit

class KanjiTextViewController: UIViewController, View {
    
    @IBOutlet weak var kanjiTextView: UITextView!
    @IBOutlet weak var pasteButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
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
        self.pasteButton.rx.tap
            .map { UIPasteboard.general.string }
            .errorOnNil()
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .map { [weak self] text -> MainReactor.Action  in
                self?.kanjiTextView.text = text
                return MainReactor.Action.paste(text)
            }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.resetButton.rx.tap.map { MainReactor.Action.reset }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.reset }
            .distinctUntilChanged()
            .filterNil()
            .bind { [weak self] _ in
                self?.kanjiTextView.text.removeAll()
            }
            .disposed(by: self.disposeBag)
    }
}
