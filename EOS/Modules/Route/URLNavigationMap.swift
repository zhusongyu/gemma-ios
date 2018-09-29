//
//  URLNavigationMap.swift
//  EOS
//
//  Created by koofrank on 2018/9/25.
//  Copyright © 2018 com.nbltrustdev. All rights reserved.
//

import Foundation
import URLNavigator

/// example: openPage("cybexapp://eto/home")
struct URLNavigationMap {
    static func initialize(navigator: NavigatorType) {
        navigator.handle("gemma://transfer") { (url, values, context) -> Bool in
            app_coodinator.pushVC(TransferCoordinator.self, animated: true, context: TransferContext.deserialize(from: values))
            return true
        }
        
    }
}