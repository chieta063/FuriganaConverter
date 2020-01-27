//
//  MainReactorTests.swift
//  FuriganaConverterTests
//
//  Created by 阿部紘明 on 2020/01/27.
//  Copyright © 2020 阿部紘明. All rights reserved.
//

import XCTest
import RxBlocking
@testable import FuriganaConverter

class ConvertAPITest: XCTestCase {
    
    let api = ConvertAPI()

    override func setUp() {
        
    }

    override func tearDown() {
        
    }

    func test_MainReactorのconvertを実行したらふりがなが返ってくること() {
        let result = try? self.api.convertToHiragana(sentence: "漢字を含む文字列").toBlocking().first()
        XCTAssertEqual(result, "かんじを ふくむ もじれつ")
    }
}
