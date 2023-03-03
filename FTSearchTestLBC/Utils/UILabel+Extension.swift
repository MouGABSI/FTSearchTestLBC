//
//  UILabel+Extension.swift
//  FTSearchTestLBC
//
//  Created by Mouldi GABSI on 03/03/2023.
//

import UIKit
extension UILabel {
    func setDynamicTextColor() {
        if #available(iOS 13.0, *) {
            self.textColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
                return traitCollection.userInterfaceStyle == .dark ? .white : .black
            }
        } else {
            self.textColor = .white
        }
    }
}
