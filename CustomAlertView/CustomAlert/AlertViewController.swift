//
//  AlertViewController.swift
//  CustomAlertView
//
//  Created by Đái Phương Bình on 7/20/18.
//  Copyright © 2018 Đái Phương Bình. All rights reserved.
//

import UIKit

class AlertViewController: UIView {
    // MARK: Variable
    private let screenSize = UIScreen.main.bounds
    private var confirgurationHandler: ((UITextField) -> Void)?
    open var textFields: [UITextField] = [UITextField]()
    private let txFStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let btnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    private let alertView: UIView = {
        let screenSize = UIScreen.main.bounds
        var height = Int(screenSize.height * 0.3)
        var width = Int(screenSize.width - 40)
        var view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lblTitleAlert: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lblMessage: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.init(name: "Helvetical", size: 10)
        label.textColor = .black
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var heightAnchorConstant: NSLayoutConstraint!
    private var bottomAnchorMessage: NSLayoutConstraint!
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.24)
        heightAnchorConstant = self.alertView.heightAnchor.constraint(greaterThanOrEqualToConstant: self.screenSize.height * 0.3)
        bottomAnchorMessage = lblMessage.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -80)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: Layout
    private func autoLayoutWithoutStackView() {
        self.addSubview(self.alertView)
        NSLayoutConstraint.activate([
            self.alertView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.alertView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.alertView.widthAnchor.constraint(equalToConstant: self.screenSize.width - 40),
            heightAnchorConstant!
        ])
        
        alertView.addSubview(lblTitleAlert)
        NSLayoutConstraint.activate([
            lblTitleAlert.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 10),
            lblTitleAlert.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 5),
            lblTitleAlert.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -5)
        ])
        
        alertView.addSubview(lblMessage)
        NSLayoutConstraint.activate([
            lblMessage.topAnchor.constraint(equalTo: lblTitleAlert.bottomAnchor, constant: 10),
            lblMessage.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 10),
            lblMessage.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10),
            bottomAnchorMessage!
        ])
        
        alertView.addSubview(btnStackView)
        NSLayoutConstraint.activate([
            btnStackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 5),
            btnStackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -5),
            btnStackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -10),
            btnStackView.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func initializationAlertDefault(title: String?, message: String?) {
        self.autoLayoutWithoutStackView()
        if let title = title, let message = message {
            lblTitleAlert.text = title
            lblMessage.text = message
        }
        
    }

    func addAction(actionAlert: AlertAction) {
        btnStackView.addArrangedSubview(actionAlert)
    }
    
    func addSubViewIntoAlert(view: UIView) {
        bottomAnchorMessage.isActive = false
        alertView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: lblMessage.bottomAnchor, constant: 10),
            view.bottomAnchor.constraint(equalTo: btnStackView.topAnchor, constant: -10),
            view.heightAnchor.constraint(equalToConstant: 180),
            view.centerXAnchor.constraint(equalTo: alertView.centerXAnchor)
        ])
    }
    
    func addTextFieldToAlert(confirgationHandler: ((UITextField) -> Void)?) {
        bottomAnchorMessage.isActive = false
        alertView.addSubview(txFStackView)
        NSLayoutConstraint.activate([
            txFStackView.topAnchor.constraint(equalTo: lblMessage.bottomAnchor, constant: 10),
            txFStackView.bottomAnchor.constraint(equalTo: btnStackView.topAnchor, constant: -10),
            txFStackView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor)
        ])
        
        let txtField = UITextField()
        txFStackView.addArrangedSubview(txtField)
        textFields.append(txtField)
        confirgationHandler!(txtField)
    }
    
    // MARK: Action
    
    public func show() {
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = screenSize.height + (screenSize.height / 2)
        animation.toValue = screenSize.height / 2
        animation.duration = 0.6

        alertView.layer.add(animation, forKey: nil)
        
        let pulsingAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulsingAnimation.fromValue = 0
        pulsingAnimation.toValue = 1
        pulsingAnimation.duration = 0.8
        
        alertView.layer.add(pulsingAnimation, forKey: nil)
    }
    
    public func dimissView() {
        for view in alertView.subviews {
            alertView.willRemoveSubview(view)
        }
        self.removeFromSuperview()
    }
}

