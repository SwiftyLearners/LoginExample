//
//  ViewController.swift
//  ScrollView
//
//  Created by Aleksei Permiakov on 09.05.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var enteredEmail = ""
    private var enteredPassword = ""
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.keyboardDismissMode = .interactive
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var contentView = UIView()
    
    private lazy var loginTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = .systemTeal
        label.font = .systemFont(ofSize: 40, weight: .thin)
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.textContentType = .emailAddress
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.enablesReturnKeyAutomatically = true
        textField.delegate = self
        textField.addTarget(self, action: #selector(didChangeEmail), for: .allEditingEvents)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        textField.clearsOnBeginEditing = true
        textField.autocorrectionType = .no
        textField.returnKeyType = .go
        textField.enablesReturnKeyAutomatically = true
        textField.delegate = self
        textField.addTarget(self, action: #selector(didChangePassword), for: .allEditingEvents)
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemCyan
        config.cornerStyle = .medium
        config.title = "Login"
        button.configuration = config
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupKeyboardObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let bottomInset = keyboardFrame.height - view.safeAreaInsets.bottom
        
        scrollView.contentInset.bottom = bottomInset
        scrollView.verticalScrollIndicatorInsets.bottom = bottomInset
        scrollView.scrollRectToVisible(contentView.frame, animated: false)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    @objc private func didChangeEmail() {
        if let text = emailTextField.text {
            enteredEmail = text
            enableLoginButtonIfNeeded()
        }
    }
    
    @objc private func didChangePassword() {
        if let text = passwordTextField.text {
            enteredPassword = text
            enableLoginButtonIfNeeded()
        }
    }
    
    private func credentialsNotEmpty() -> Bool {
        !enteredEmail.isEmpty && !enteredPassword.isEmpty
    }
    
    private func enableLoginButtonIfNeeded() {
        loginButton.isEnabled = credentialsNotEmpty()
    }
    
    @objc private func loginButtonTapped() {
        print("login with email: \(enteredEmail), password: \(enteredPassword)")
        view.endEditing(true)
        let vc = UIViewController()
        vc.view.backgroundColor = .systemMint
        vc.title = "App Content"
        navigationController?.pushViewController(vc, animated: true)
    }
}

    // MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
            print("Switch to password text field")
        case passwordTextField:
            if credentialsNotEmpty() {
                loginButtonTapped()
            }
        default:
            return false
        }
        return true
    }
}

// MARK: ScrollViewDelegate
extension LoginViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 30 {
//            scrollView.backgroundColor = .red
        }
    }
}

extension LoginViewController {
    private func setupViews() {
        let screenHeight = UIScreen.main.bounds.height
        let inset: CGFloat = 22
        let height: CGFloat = 44
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [loginTitleLabel, emailTextField, passwordTextField, loginButton].forEach { contentView.addSubview($0) }
        [scrollView, contentView, loginTitleLabel, emailTextField, passwordTextField, loginButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            loginTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: screenHeight / 4),
            loginTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: loginTitleLabel.bottomAnchor, constant: 100),
            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            emailTextField.heightAnchor.constraint(equalToConstant: height),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: inset),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            passwordTextField.heightAnchor.constraint(equalToConstant: height),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: inset),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            loginButton.heightAnchor.constraint(equalToConstant: height),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
}
