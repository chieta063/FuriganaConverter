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
import UITextView_Placeholder
import Swinject
import SwinjectAutoregistration

class KanjiTextViewController: UIViewController, View {
    
    @IBOutlet weak var kanjiTextView: UITextView!
    @IBOutlet weak var pasteButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    static let container = Container(parent: MainViewController.container) { container in
        container.autoregister(KanjiTextViewController.self, initializer: KanjiTextViewController.init)
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
        self.kanjiTextView.placeholder = R.string.placeHolders.kanji()
        self.pasteButton.layer.cornerRadius = 8
    }
    
    func bind(reactor: MainReactor) {
        self.pasteButton.rx.tap
            .map { UIPasteboard.general.string }
            .filterNil()
            .map { [weak self] text -> MainReactor.Action  in
                self?.kanjiTextView.text = text
                return MainReactor.Action.paste(text)
            }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
}
