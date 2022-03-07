//
//  Request.swift
//  RSearch
//
//  Created by Quentin on 07/03/2022.
//

import Foundation

class RequestParams {
    let type: String
    let searchQueue: String
    let appId: String
    let appKey: String

    init(search: String, appId: String = Constantes.appId, appKey: String = Constantes.appKey) {
        type = "public"
        searchQueue = search
        self.appId = appId
        self.appKey = appKey
    }

    func buildParameters() -> [String: Any] {
        return ["type": type, "q": searchQueue, "app_id": appId, "app_key": appKey]
    }
}
