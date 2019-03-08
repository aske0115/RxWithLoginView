//
//  ViewController.swift
//  RxWithLoginView
//
//  Created by GeunHwa Lee on 07/03/2019.
//  Copyright © 2019 GeunHwa Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class BaseViewController:UIViewController{
    override func viewDidLoad() {
        setupUI()
        bindUI()
    }
    
    func setupUI(){
        
    }
    
    func bindUI(){
        
    }
    
}

class ViewController: BaseViewController {

    
    lazy var disposeBag:DisposeBag = DisposeBag()
    
    
    private let emailBehavior = BehaviorSubject(value: "")
    private let passwordBehavior = BehaviorSubject(value: "")
    
    private let emailValid = BehaviorSubject(value: false)
    private let passwordValid = BehaviorSubject(value: false)
    
    @IBOutlet weak var idTextField:UITextField!
    @IBOutlet weak var pwTextField:UITextField!
    
    @IBOutlet weak var loginButton:UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func setupUI() {
        
    }
    
    override func bindUI() {

        bindInput()
        bindOutput()
    }
    
    
    private func bindInput() {
        
        //emailTextField Validation(length)
        self.idTextField.rx.text.orEmpty
            .bind(to:emailBehavior)
            .disposed(by: disposeBag)
        

        //passwordTextField Validation(length)
        self.pwTextField.rx.text.orEmpty
            .bind(to:passwordBehavior)
            .disposed(by: disposeBag)

    }
    
    private func bindOutput() {
        
        //두개의 입력값 체크결과에 따른 동작 combineLatest
        Observable.combineLatest(emailBehavior.map(checkEmail), passwordBehavior.map(checkPassword), resultSelector: {$0 && $1})
            .subscribe(onNext: { [weak self] b in
                self?.loginButton.isEnabled = b
            })
        .disposed(by: disposeBag)
    }

    
    private func checkEmail(_ email:String) -> Bool {
        return email.count > 0 && email.contains("@") && email.contains(".")
    }
    
    private func checkPassword(_ password:String) -> Bool {
        return password.count > 7
    }

    @IBAction func pressLoginButton() {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SuccessLogin") as UIViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

