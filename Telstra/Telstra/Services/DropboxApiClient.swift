//
//  DropboxApiClient.swift
//  Telstra
//
//  Created by Siavash on 17/4/18.
//  Copyright © 2018 Siavash. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct DropboxApiClient {
    
    static func fetchData(for apiObject: ApiObject) -> Observable<DataModel> {
        return Observable.create({ observer in
            guard let url = apiObject.baseUrl else {
                return Disposables.create {
                    observer.onError(ApiError.genericError(description: ""))
                }
            }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        // the encoding for this JSON is wrong hence the below re-encoding
                        guard let reEncodedData = (String(data: data, encoding: String.Encoding.isoLatin1)?.data(using: String.Encoding.utf8)) else {
                            observer.onError(ApiError.jsonEncodingError)
                            return
                        }
                        let responseObject = try decoder.decode(DataModel.self, from: reEncodedData)
                        observer.onNext(responseObject)
                    } catch let anError {
                        observer.onError(anError)
                    }
                }
                }.resume()
            
            return Disposables.create()
        })
    }
}
