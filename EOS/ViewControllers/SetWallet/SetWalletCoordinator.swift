//
//  SetWalletCoordinator.swift
//  EOS
//
//  Created DKM on 2018/7/20.
//  Copyright © 2018年 com.nbltrust. All rights reserved.
//

import UIKit
import ReSwift

protocol SetWalletCoordinatorProtocol {
    
    func pushToServiceProtocolVC()
    func importFinished()
}

protocol SetWalletStateManagerProtocol {
    var state: SetWalletState { get }
    func subscribe<SelectedState, S: StoreSubscriber>(
        _ subscriber: S, transform: ((Subscription<SetWalletState>) -> Subscription<SelectedState>)?
    ) where S.StoreSubscriberStateType == SelectedState
    
    func validForm(_ password:String, confirmPassword:String, hint:String) -> (Bool, String)
    func importLocalWallet(_ password:String, hint:String, completion: @escaping (Bool)->Void)
    func updatePassword(_ password:String, hint:String)
    
    func validPassword(_ password: String)
    func validComfirmPassword(_ password: String, comfirmPassword: String)
    func checkAgree(_ agree: Bool)
}

class SetWalletCoordinator: HomeRootCoordinator {
    
    lazy var creator = SetWalletPropertyActionCreate()
    
    var store = Store<SetWalletState>(
        reducer: SetWalletReducer,
        state: nil,
        middleware:[TrackingMiddleware]
    )
}

extension SetWalletCoordinator: SetWalletCoordinatorProtocol {
    
    func pushToServiceProtocolVC() {
        let vc = BaseWebViewController()
        vc.url = H5AddressConfiguration.REGISTER_PROTOCOL_URL
        vc.title = R.string.localizable.service_protocol()
        self.rootVC.pushViewController(vc, animated: true)
    }

    func importFinished() {
        let count = self.rootVC.viewControllers.count
        if count - 3 > 0, let vc = self.rootVC.viewControllers[count - 3] as? LeadInViewController {
            vc.coordinator?.state.callback.fadeCallback.value?()
        }
    }
}

extension SetWalletCoordinator: SetWalletStateManagerProtocol {
    var state: SetWalletState {
        return store.state
    }
    
    func subscribe<SelectedState, S: StoreSubscriber>(
        _ subscriber: S, transform: ((Subscription<SetWalletState>) -> Subscription<SelectedState>)?
        ) where S.StoreSubscriberStateType == SelectedState {
        store.subscribe(subscriber, transform: transform)
    }
    
    func validForm(_ password:String, confirmPassword:String, hint:String) -> (Bool, String) {
        return (true, "")
    }
    
    func importLocalWallet(_ password:String, hint:String, completion: @escaping (Bool)->Void) {
        WalletManager.shared.importPrivateKey(password, hint: hint, completion: completion)
    }
    
    func updatePassword(_ password:String, hint:String) {
        WalletManager.shared.updateWalletPassword(password, hint: hint)
        self.rootVC.popViewController()
    }
    
    func validPassword(_ password: String) {
        self.store.dispatch(SetWalletPasswordAction(isValid: WalletManager.shared.isValidPassword(password)))
    }
    
    func validComfirmPassword(_ password: String, comfirmPassword: String) {
        self.store.dispatch(SetWalletComfirmPasswordAction(isValid: WalletManager.shared.isValidComfirmPassword(password, comfirmPassword: comfirmPassword)))
    }
    
    func checkAgree(_ agree: Bool) {
        self.store.dispatch(SetWalletAgreeAction(isAgree: agree))
    }
}
