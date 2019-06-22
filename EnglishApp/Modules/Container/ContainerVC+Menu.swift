//
//  ContainerVC+Menu.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/30/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit
/******************** LOGIC **********************/
//extension ContainerViewController: LeftMenuViewControllerDelegate {
//    func itemLeftMenuSelected(item: Any) {
//        guard let _item = item as? MenuType else { return }
//        hideMenu()
//        switch _item {
//        case .home:
//            addSmallToMain(controller: vcHome)
//        case .room:
//            addSmallToMain(controller: vcListRoom)
//        case .scene:
//            addSmallToMain(controller: vcListScene)
//        case .logout:
//            CognitoService.shared.logoutUser()
//        }
//
//    }
//}

/******************** UI **********************/
//--- MARK: handle Left menu
extension ContainerViewController {
    
    func addBlackView() {
        if !self.vContentMain.subviews.contains(vBlack) {
            self.vContentMenu.addSubview(vBlack)
        }
        
        vBlack.isHidden = true
        vBlack.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    func addMenuViewController(vcMenu: UIViewController) {
        // add menu
        addChild(vcMenu)
        
        self.vContentMenu.addSubview(vcMenu.view)
        
        vcMenu.view.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0)
        
        
        
        vcMenu.view.widthAnchor.constraint(equalTo: vContainerMain.widthAnchor, multiplier: 4/5, constant: 0).isActive = true
        
        vcMenu.didMove(toParent: self)
        vcMenu.view.isHidden = true
        vcMenu.viewWillAppear(true)
        
        vContentMenu.isHidden = true
        vcMenu.view.isHidden = true
    }
    
    func showMenu() {
        vBlack.isHidden = false
        let vcMenu = vcLeftMenu
        addTapGesture()
        vContentMenu.isHidden = false
        vcMenu?.view.isHidden = false
        vcMenu?.viewWillAppear(true)
        vcLeftMenu.view.isHidden = false
        showLeftMenu()
    }
    
    func hideMenu() {
        
        hideLeftMenu()
    }
}

// Helper Animation
extension ContainerViewController {
    private func showLeftMenu() {
        
        widthMenu = 4 * self.vContainerMain.frame.width / 5
        vcLeftMenu.view.frame = CGRect(x: -widthMenu, y: 0, width: widthMenu, height: self.vBlack.frame.height)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.vcLeftMenu.view.frame = CGRect(x: 0, y: 0, width: self.widthMenu, height: self.vBlack.frame.height)
        }) { _ in
            
        }
        
        moveMainContentRight()
    }
    
    private func hideLeftMenu() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.vcLeftMenu.view.frame = CGRect(x: -self.widthMenu, y: 0, width: self.widthMenu, height: self.vBlack.frame.height)
        }) { _ in
            self.vcLeftMenu.view.isHidden = true
            self.vContentMenu.isHidden = true
            self.removeTapGesture()
            self.vBlack.isHidden = true
        }
        moveMainContentLeft()
    }
    
    func moveMainContentLeft() {
        UIView.animate(withDuration: 0.3 , delay: 0, options: .curveEaseOut, animations: {
            self.vContentMain.frame = CGRect(x: self.minXContent, y: self.vContentMain.frame.minY, width: self.vContentMain.frame.width, height: self.vContentMain.frame.height)
        }) { _ in
            
        }
    }
    
    func moveMainContentRight() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.vContentMain.frame = CGRect(x: self.widthMenu + 7, y: self.vContentMain.frame.minY, width: self.vContentMain.frame.width, height: self.vContentMain.frame.height)
        }) { _ in
            
        }
    }
    
}
