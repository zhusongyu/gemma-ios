//
//  BackupMnemonicWordCoordinator.swift
//  EOS
//
//  Created zhusongyu on 2018/9/14.
//  Copyright © 2018年 com.nbltrustdev. All rights reserved.
//

import UIKit
import ReSwift
import SwiftNotificationCenter
import Async

protocol BackupMnemonicWordCoordinatorProtocol {
    func pushToMnemonicWordContentVC()
}

protocol BackupMnemonicWordStateManagerProtocol {
    var state: BackupMnemonicWordState { get }
    
    func switchPageState(_ state:PageState)
}

class BackupMnemonicWordCoordinator: HomeRootCoordinator {
    var store = Store(
        reducer: BackupMnemonicWordReducer,
        state: nil,
        middleware:[TrackingMiddleware]
    )
    
    var state: BackupMnemonicWordState {
        return store.state
    }
            
    override func register() {
        Broadcaster.register(BackupMnemonicWordCoordinatorProtocol.self, observer: self)
        Broadcaster.register(BackupMnemonicWordStateManagerProtocol.self, observer: self)
    }
}

extension BackupMnemonicWordCoordinator: BackupMnemonicWordCoordinatorProtocol {
    func pushToMnemonicWordContentVC() {
        if let vc = R.storyboard.mnemonic.mnemonicContentViewController() {
            let coordinator = MnemonicContentCoordinator(rootVC: self.rootVC)
            vc.coordinator = coordinator
            self.rootVC.pushViewController(vc, animated: true)
        }
    }
}

extension BackupMnemonicWordCoordinator: BackupMnemonicWordStateManagerProtocol {
    func switchPageState(_ state:PageState) {
        Async.main {
            self.store.dispatch(PageStateAction(state: state))
        }
    }
}