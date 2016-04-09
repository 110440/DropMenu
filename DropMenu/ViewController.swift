//
//  ViewController.swift
//  DropMenu
//
//  Created by tanson on 16/4/9.
//  Copyright © 2016年 tanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func showMenu(sender: AnyObject) {
        
        let btn = sender as! UIButton
        
        let image = UIImage(named: "icon.png")
        let menu = DropMenu(menuWidth: 150)
        menu.addMenuItem("title1",image: image)
        menu.addMenuItem("title2",image: image)
        menu.addMenuItem("title3",image: image)
        menu.addMenuItem("title4",image: image)
        menu.showMenuInView(self.view,atPoint: btn.center){ index in
            print(index)
        }
    }
}

