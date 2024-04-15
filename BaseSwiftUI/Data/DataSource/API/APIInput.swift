//
//  APIInput.swift
//  clean_architechture
//
//  Created by phan.duong.ngoc on 2023/03/10.
//

import Alamofire

class APIInput: APIInputBase {
    override init(urlString: String,
                  parameters: [String: Any]?,
                  method: HTTPMethod,
                  requireAccessToken: Bool) {
        super.init(urlString: urlString,
                   parameters: parameters,
                   method: method,
                   requireAccessToken: requireAccessToken)
        self.urlString.append("?api_key=\(AppConfig.MovieDB.apiKey)")
    }
}
