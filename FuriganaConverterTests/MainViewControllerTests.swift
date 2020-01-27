//
//  FuriganaConverterTests.swift
//  FuriganaConverterTests
//
//  Created by 阿部紘明 on 2020/01/22.
//  Copyright © 2020 阿部紘明. All rights reserved.
//

import XCTest
import Rswift
@testable import FuriganaConverter

class MainViewControllerTests: XCTestCase {
    
    var navigationController: UINavigationController!
    var mainViewController: MainViewController!

    override func setUp() {
        let storyboard = R.storyboard.main()
        self.navigationController = storyboard.instantiateInitialViewController()
        self.mainViewController = self.navigationController.viewControllers.first as? MainViewController
        
        _ = self.mainViewController.view
    }

    override func tearDown() {
        
    }
    
    func test_貼り付けボタンを押したらテキストがペーストされること() {
        let kanjiViewController = self.mainViewController.children.first as! KanjiTextViewController
        UIPasteboard.general.string = "漢字を含む文字列"
        kanjiViewController.pasteButton.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(kanjiViewController.kanjiTextView.text, "漢字を含む文字列")
    }
}
