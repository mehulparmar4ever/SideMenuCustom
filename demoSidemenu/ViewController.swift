//
//  ViewController.swift
//  demoSidemenu
//
//  Created by mehulmac on 23/03/17.
//  Copyright © 2017 mehulmac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnSide: UIButton!
    
    var screenWidth = UIScreen.main.bounds.size.width
    var screenHeight = UIScreen.main.bounds.size.height
    var yPosition = UIScreen.main.bounds.size.height

    var sideMenuVisible = false
//    var objSIdeMenuController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SIdeMenuController")//SIdeMenuController().self()
     var objSIdeMenuController = SIdeMenuController().self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.sideMenuVisible = false

        let right = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRight))
        right.direction = .right
        self.view.addGestureRecognizer(right)

        let left = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft))
        left.direction = .left
        self.view.addGestureRecognizer(left)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        screenWidth = UIScreen.main.bounds.size.width
        screenHeight = UIScreen.main.bounds.size.height
        yPosition = 64 + 44
        self.instantiateControllers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSideMenuClicked(_ sender: UIButton) {
        for view in self.view.subviews {
            if view.tag == 999 {
                if self.sideMenuVisible {
                    view.frame = CGRect(x: 0, y: self.yPosition, width: self.screenWidth, height: self.screenHeight)

                    UIView.animate(withDuration: 0.3, animations: {
                        view.frame = CGRect(x: -self.screenWidth, y: self.yPosition, width: self.screenWidth, height: self.screenHeight)
                    })
                } else {
                    UIView.animate(withDuration: 0.3, animations: {
                        view.frame = CGRect(x: 0, y: self.yPosition, width: self.screenWidth, height: self.screenHeight)
                    })
                }
                self.sideMenuVisible = !self.sideMenuVisible
            }
        }
    }

    // MARK: -
    // MARK: Helper methods
    func instantiateControllers() {
        objSIdeMenuController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SIdeMenuController") as! SIdeMenuController
        objSIdeMenuController.view.tag = 999
        objSIdeMenuController.view.frame = CGRect(x: -screenWidth, y: yPosition, width: screenWidth, height: screenHeight-64)
        self.view.addSubview(objSIdeMenuController.view)
    }
    func removeSubviews() {
        // remove the current subview loaded
        for view: UIView in self.view.subviews {
            if view.tag == 999 {
                view.removeFromSuperview()
            }
        }
    }
    
    func swipeLeft() {
        print("....")
        if self.sideMenuVisible {
            print("swipeLeft")
            self.btnSideMenuClicked(btnSide)
        }
    }
    
    func swipeRight() {
        print("....")
        if !self.sideMenuVisible {
            print("swipeRight")

            self.btnSideMenuClicked(btnSide)
        }
    }
}

