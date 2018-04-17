//
//  ListViewModel.swift
//  Telstra
//
//  Created by Siavash on 17/4/18.
//  Copyright © 2018 Siavash. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SDWebImage

class ListViewModel {
    
    private var rows: [RowModel]?
    private var dataModelTitle: String?
    
    public let rowsUpdated: PublishSubject<[RowModel]?> = PublishSubject()
    public let titleUpdated: PublishSubject<String> = PublishSubject()
    
    func fetchData() {
        _ = DropboxApiClient.fetchData(for: ApiObject()).subscribe { [weak self] (event) in
            self?.rows = event.element?.rows?.filter({ // remove any item that has all the fields empty 
                return !($0.description == nil && $0.imageHref == nil && $0.title == nil)
            })
            self?.dataModelTitle = event.element?.title
            self?.rowsUpdated.onNext(self?.rows)
            self?.titleUpdated.onNext(self?.dataModelTitle ?? "")
        }
    }
    
    func getNumberOfRows() -> Int {
        return self.rows?.count ?? 0
    }
    
    func getTitle() -> String {
        return dataModelTitle ?? ""
    }
    
    func item(at indexPath: IndexPath) -> RowViewModel? {
        guard let rows = rows else { return nil }
        if indexPath.row < rows.count {
            let model = rows[indexPath.row]
            let vm = RowViewModel.init(title: model.title, description: model.description, imageHref: URL.init(string: model.imageHref ?? ""))
            return vm
            
        }
        return nil
    }
}

