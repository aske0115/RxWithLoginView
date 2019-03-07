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


class ViewController: UIViewController {

    
    var disposeBag:DisposeBag{
        return viewModel.disposeBag
    }
//    var idFieldSubject:PublishSubject<String>?
//    var pwFieldSubject:PublishSubject<String>?
    
    
//    private var validationTextField:BehaviorSubject<Any>?
    @IBOutlet weak var idTextField:UITextField!
    @IBOutlet weak var pwTextField:UITextField!
    
    @IBOutlet weak var loginButton:UIButton!
    
    
    lazy var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK: bind
    
    private func bindUI(){
        self.idTextField.rx.text.orEmpty
            .map(checkEmail)
            .subscribe(onNext: { [weak self] (b) in
                guard let `self` = self else { return }
                if !b{
                    self.idTextField.backgroundColor = .orange
                    if(self.idTextField.text!.count == 0) {
                        self.idTextField.placeholder = "Input EmailAddress"
                    }
                }else{
                    self.idTextField.backgroundColor = .clear
                }
            })
            .disposed(by: disposeBag)


        self.pwTextField.rx.text.orEmpty
            .map(checkPassword)
            .subscribe(onNext: { [weak self] (b) in
                guard let `self` = self else { return }
                if !b{
                    self.pwTextField.backgroundColor = .orange
                    if(self.pwTextField.text!.count == 0) {
                        self.pwTextField.placeholder = "Input Password"
                    }
                }else{
                    self.pwTextField.backgroundColor = .clear
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func checkEmail(_ email:String) -> Bool{
        return email.contains("@") && email.contains(".")
    }
    
    private func checkPassword(_ password:String) -> Bool{
        return password.count > 7
    }

    @IBAction func pressLoginButton(){
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SuccessLogin") as UIViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

