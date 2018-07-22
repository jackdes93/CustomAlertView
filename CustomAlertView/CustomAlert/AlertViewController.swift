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
    var btnAction: [AlertAction]?
    private let screenSize = UIScreen.main.bounds
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let btnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let alertView: UIView = {
        let screenSize = UIScreen.main.bounds
        var height = Int(screenSize.height * 0.25)
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
        label.font = UIFont.boldSystemFont(ofSize: 18)
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
        label.font = UIFont.init(name: "Helvetical", size: 12)
        label.textColor = .black
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     private var heightAnchorConstant: NSLayoutConstraint!
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.24)
        heightAnchorConstant = self.alertView.heightAnchor.constraint(equalToConstant: self.screenSize.height * 0.25)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func setupLayout() {
        self.addSubview(self.alertView)
        NSLayoutConstraint.activate([
            self.alertView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.alertView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.alertView.widthAnchor.constraint(equalToConstant: self.screenSize.width - 40),
            heightAnchorConstant!
         ])
        
        alertView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -10),
            mainStackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10)
        ])
        
        mainStackView.addArrangedSubview(lblTitleAlert)
        NSLayoutConstraint.activate([
            lblTitleAlert.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 0),
            lblTitleAlert.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 0),
            lblTitleAlert.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 0)
        ])
        
        mainStackView.addArrangedSubview(lblMessage)
    }
    
    func initializationAlertDefault(title: String?, message: String?) {
        self.setupLayout()
        if let title = title, let message = message {
            lblTitleAlert.text = title
            lblMessage.text = message
        }
    }

    func addAction(actionAlert: AlertAction) {
        mainStackView.addArrangedSubview(btnStackView)
        NSLayoutConstraint.activate([
            btnStackView.heightAnchor.constraint(equalToConstant: 48)
        ])
        btnStackView.addArrangedSubview(actionAlert)
    }
    
    func addSubViewIntoAlert(view: UIView) {
        heightAnchorConstant?.isActive = false
        self.alertView.heightAnchor.constraint(equalToConstant: self.screenSize.height * 0.25 + 200).isActive = true
        mainStackView.addArrangedSubview(view)
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
