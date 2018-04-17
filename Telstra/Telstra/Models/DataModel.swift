//
//  DataModel.swift
//  Telstra
//
//  Created by Siavash on 17/4/18.
//  Copyright © 2018 Siavash. All rights reserved.
//

import Foundation

struct DataModel: Decodable {
    let title: String?
    let rows: [RowModel]?
}
