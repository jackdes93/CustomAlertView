//
//  alertAction.swift
//  CustomAlertView
//
//  Created by Đái Phương Bình on 7/20/18.
//  Copyright © 2018 Đái Phương Bình. All rights reserved.
//

import UIKit

enum AlertActionStyle {
    case Default
    case Cancel
    
    func colorText() -> UIColor {
        switch self {
        case .Default:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        case .Cancel:
            return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    func backgroundColor() -> UIColor {
        switch self {
        case .Default:
            return UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
        case .Cancel:
            return UIColor(red: 186/255, green: 37/255, blue: 39/255, alpha: 1)
        }
    }
}

class AlertAction: UIButton {
    var handler: (() -> Void)?
    
    func initializationAction(title: String, styleAction: AlertActionStyle, handler: @escaping () -> Void)  {
        self.handler = handler
        self.setTitle(title, for: .normal)
        self.setTitleColor(styleAction.colorText(), for: .normal)
        self.backgroundColor = styleAction.backgroundColor()
        self.addTarget(self, action: #selector(executeHandle), for: .touchUpInside)
    }
    
    @objc private func executeHandle() {
        handler?()
    }
  
}
