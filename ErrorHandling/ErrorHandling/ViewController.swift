//
//  ViewController.swift
//  ErrorHandling
//
//  Created by taehy.k on 2021/08/09.
//

import UIKit

// MARK: - Login Error Type
// 빈 Error 프로토콜을 채택하여 사용한다.
enum loginErrorType: Error {
    case isNotCompleted             // 필드가 모두 채워지지 않았을때
    case isValidEmail               // 이메일 형식이 올바르지 않았을때
    case incorrectPasswordLength    // 비밀번호 길이가 올바르지 않았을때
}

class ViewController: UIViewController {
    
    // MARK: - Views
    
    let idTextField = CustomTextField(placeholder: "input id or email")
    let passwordTextField = CustomTextField(placeholder: "input password")
    let loginButton = CustomButton(backgroundColor: .systemYellow, title: "Login")

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: Configure

    private func setup() {
        view.addSubviews(loginButton, idTextField, passwordTextField)
        
        idTextField.widthAnchor.constraint(equalToConstant: 380).isActive = true
        idTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        idTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        idTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        
        passwordTextField.widthAnchor.constraint(equalToConstant: 380).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 20).isActive = true
        
        loginButton.widthAnchor.constraint(equalToConstant: 380).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func loginButtonTapped(_ sender: UIButton) {
        do {
            try login()
            Alert.showBasic(title: "Login Success", message: "로그인 성공", vc: self)
        } catch loginErrorType.isNotCompleted {
            Alert.showBasic(title: "Incomplete Form", message: "필드를 모두 채워주세요", vc: self)
        } catch loginErrorType.isValidEmail {
            Alert.showBasic(title: "Invalid Email Format", message: "이메일 형식을 지켜주세요", vc: self)
        } catch {
            Alert.showBasic(title: "Incorrect Password Length", message: "비밀번호를 8자리 이상 입력해주세요", vc: self)
        }
    }
    
    private func login() throws {
        guard let email = idTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        guard !email.isEmpty && !password.isEmpty else { throw loginErrorType.isNotCompleted }
        guard email.isVaildEmail else { throw loginErrorType.isValidEmail }
        guard password.count >= 8 else { throw loginErrorType.incorrectPasswordLength }
    }
}

