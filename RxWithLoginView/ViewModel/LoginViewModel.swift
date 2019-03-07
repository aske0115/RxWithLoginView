//
//  LoginViewModel.swift
//  RxWithLoginView
//
//  Created by GeunHwa Lee on 07/03/2019.
//  Copyright © 2019 GeunHwa Lee. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol LoginViewModelType {
//    associatedtype vmType
}

class LoginViewModel : LoginViewModelType{
//    typealias vmType = LoginViewModel
    //input
    var disposeBag = DisposeBag()
    lazy var idTextInput = BehaviorSubject(value: "")
    lazy var pwTextInput = BehaviorSubject(value: "")
    
    
    //output
    var emailValid = BehaviorSubject(value: false)
    var passwordValid = BehaviorSubject(value: false)
    
    
}
