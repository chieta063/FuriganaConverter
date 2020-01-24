//
//  ConertAPI.swift
//  FuriganaConverter
//
//  Created by 阿部紘明 on 2020/01/24.
//  Copyright © 2020 阿部紘明. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire

class ConvertAPI {
    private let baseUrl: String = "https://labs.goo.ne.jp/api/hiragana"
    private let session = URLSession.shared
    private let appId = "aa4e89b0f7cb58f8b93a7acee62f37ac7fd305a0f145540f0ad0ddee56c49188"
    
    enum ConvertAPiError: Error {
        case jsonParseError
    }
    
    func convertToHiragana(sentence: String) -> Observable<String> {
        return session.rx.json(
            .post,
            self.baseUrl,
            parameters: [
                "app_id":self.appId,
                "sentence":sentence,
                "output_type":"hiragana"
            ],
            headers: ["Content_Type":"application/json"]
        )
        .flatMap { response in
            return Observable.just(response).map { response in
                if let json = response as? [String : String], let converted = json["converted"] {
                    return converted
                }
                throw ConvertAPiError.jsonParseError
            }
        }
        .observeOn(MainScheduler.instance)
    }
}
