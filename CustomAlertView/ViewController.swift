//
//  ViewController.swift
//  CustomAlertView
//
//  Created by Đái Phương Bình on 7/20/18.
//  Copyright © 2018 Đái Phương Bình. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let btnAction: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 160, height: 48))
        button.setTitle("Show", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Hello World!!!"
        label.textAlignment = .center
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var alertView: AlertViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
       
        self.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 30)
        ])
        
        self.view.addSubview(btnAction)
        NSLayoutConstraint.activate([
            btnAction.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnAction.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            btnAction.widthAnchor.constraint(equalToConstant: 160),
            btnAction.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    
    // MARK: Action
    @objc private func handleTap() {
       alertView = AlertViewController(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
       self.view.addSubview(alertView!)
        alertView?.initializationAlertDefault(title: "Success", message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
        
//        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 240, height: 100))
//        image.image = UIImage(named: "image")
//        image.contentMode = .scaleAspectFit
//        image.translatesAutoresizingMaskIntoConstraints = false
//        alertView?.addSubViewIntoAlert(view: image)

        alertView?.addTextFieldToAlert(confirgationHandler: { (textField) in
            textField.placeholder = "Test"
        })
        
        
        
        let okAction = AlertAction()
        okAction.initializationAction(title: "OK", styleAction: .Default) {
            self.alertView?.dimissView()
            for text in (self.alertView?.textFields)! {
                print(text.text!)
            }
        }
        alertView?.addAction(actionAlert: okAction)
        
        let cancel = AlertAction()
        cancel.initializationAction(title: "Cancel", styleAction: .Cancel) {
            self.alertView?.dimissView()
             self.label.text = "Cancel"
        }
        alertView?.addAction(actionAlert: cancel)
        alertView?.show()
        
    }
  
}

