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
    
//    var idFieldSubject:PublishSubject<String>?
//    var pwFieldSubject:PublishSubject<String>?
    
    
//    private var validationTextField:BehaviorSubject<Any>?
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
        self.idTextField.rx.text.orEmpty
            .bind(to:self.emailBehavior)
            .disposed(by: disposeBag)
        
        self.pwTextField.rx.text.orEmpty
            .bind(to:self.passwordBehavior)
            .disposed(by: disposeBag)
        bindResult()
    }
    
    
    private func bindResult(){
        Observable.combineLatest(
            self.emailBehavior.map(checkEmail),
            self.passwordBehavior.map(checkPassword)
            , resultSelector: { $0 && $1})
            .subscribe(onNext:{ result in
                self.loginButton.isEnabled = result
            }).disposed(by: disposeBag)
    }
    private func checkEmail(_ email:String) -> Bool{
        if email.count == 0{
            self.idTextField.placeholder = "input Email"
        }
        return email.count > 0 && email.contains("@") && email.contains(".")
    }
    
    private func checkPassword(_ password:String) -> Bool{
        if password.count == 0{
            self.pwTextField.placeholder = "input Password"
        }
        return password.count > 7
    }

    @IBAction func pressLoginButton(){
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SuccessLogin") as UIViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

