//
//  Date + Extensions.swift
//  Example
//
//  Created by Rizvan on 16/06/2019.
//  Copyright © 2019 R13App. All rights reserved.
//

import Foundation

extension Date {
    
    var toString: String {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dataFormatter.locale = Locale.current
        return dataFormatter.string(from: self)
    }
}
