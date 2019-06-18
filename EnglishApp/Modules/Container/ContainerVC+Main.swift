//
//  ContainerVC+extension.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

//--- MARK: Help Main
extension ContainerViewController {
    
    
    func removeViewController(controller: UIViewController) {
        controller.view.removeFromSuperview()
        controller.removeFromParent()
        controller.willMove(toParent: nil)
    }
    
    @objc func rootViewTapped() {
        hideMenu()
    }
    
    func addTapGesture() {
        self.vBlack.addGestureRecognizer(tapGesture)
    }
    
    func removeTapGesture() {
        self.vBlack.removeGestureRecognizer(tapGesture)
    }
}

extension ContainerViewController {
    func addFullToMain(controller: UIViewController) {
        DispatchQueue.main.async {
            self.vContentMain.subviews.forEach { subView in
                subView.removeFromSuperview()
            }
            
            self.removeViewController(controller: controller)
            self.addChild(controller)
            self.vContainerMain.addSubview(controller.view)
            
            controller.view.frame = self.vContainerMain.frame
            
            controller.viewWillAppear(true)
            controller.didMove(toParent: self)
            controller.viewWillAppear(true)
        }
    }
}


