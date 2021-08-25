//
//  StreamChat - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Views
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray6
        label.text = "Welcome to StreamChat"
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        return label
    }()
    
    private let streamImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "stream")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let loginView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your nickname"
        textField.backgroundColor = .white
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.setTitle("Login", for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginTextStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTextField, loginButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    // MARK: - Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        loginTextField.delegate = self
    }
    
    @objc private func login(_ sender: UIButton) {
        let chatRoomViewController = ChatRoomViewController()
        if let userName = loginTextField.text {
            chatRoomViewController.myUserName = userName
        }
        loginTextField.text = nil
        loginTextField.resignFirstResponder()
        navigationController?.pushViewController(chatRoomViewController, animated: false)
    }
    
    private func setUpViews() {
        navigationItem.title = "Login!"
        self.view.backgroundColor = .white
        self.view.addSubview(streamImageView)
        self.view.addSubview(loginTextStackView)
        self.view.addSubview(welcomeLabel)
        
        NSLayoutConstraint.activate([
            streamImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            streamImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            streamImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            streamImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            welcomeLabel.centerYAnchor.constraint(equalTo: streamImageView.centerYAnchor, constant: -100),
            welcomeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            welcomeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            
            loginTextStackView.centerYAnchor.constraint(equalTo: streamImageView.centerYAnchor),
            loginTextStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            loginTextStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
            
        ])
    }
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let chatRoomViewController = ChatRoomViewController()
        if let userName = loginTextField.text {
            chatRoomViewController.myUserName = userName
        }
        loginTextField.text = nil
        loginTextField.resignFirstResponder()
        navigationController?.pushViewController(chatRoomViewController, animated: false)
        return true
    }
}
