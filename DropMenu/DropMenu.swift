//
//  DropMenu.swift
//  DropMenu
//
//  Created by tanson on 16/4/9.
//  Copyright © 2016年 tanson. All rights reserved.
//

import Foundation
import UIKit

private let menuHeight:CGFloat = 40
private let c1 = UIColor.blackColor()
private let c2 = UIColor(red:29.0/255.0, green: 29.0/255.0, blue:29.0/255.0, alpha: 1)

class DropMenu: UIView ,UITableViewDataSource,UITableViewDelegate{
    
    var selectAction:( (index:Int)->Void )?
    lazy var tableView:UITableView = {
        let view = UITableView(frame:CGRectZero)
        view.dataSource = self
        view.delegate   = self
        view.backgroundColor = UIColor.clearColor()
        view.rowHeight = menuHeight
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.blackColor().CGColor
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.clipsToBounds = false
        view.separatorColor = c1
        view.bounces = false
        return view
    }()
    
    var tableViewWidth:CGFloat
    var showPoint:CGPoint = CGPointZero
    var hOffset:CGFloat = 10
    
    class menuItem {
        var title:String
        var image:UIImage?
        init(title:String,image:UIImage?){
            self.title = title
            self.image = image
        }
    }
    var menuItems = [menuItem]()
    
    var tableViewFrame:CGRect{
        let size = UIScreen.mainScreen().bounds.size
        let y = self.showPoint.y
        let x = self.showPoint.x - self.tableViewWidth/2
        let right = self.showPoint.x + self.tableViewWidth/2
        let left  = self.showPoint.x - self.tableViewWidth/2
        let rightOffset = (size.width - right) > 0 ? 0:abs(size.width - right)+hOffset
        let leftOffset  = left < 0 ? abs(left)+hOffset:0
        
        let frame = CGRect(x: (x + leftOffset - rightOffset), y: y, width: self.tableViewWidth, height: CGFloat(self.menuItems.count)*menuHeight)
        return frame
    }
    
    init(menuWidth:CGFloat){
        let frame = UIScreen.mainScreen().bounds
        self.tableViewWidth = menuWidth > frame.size.width ? frame.size.width:menuWidth
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.addSubview(self.tableView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addMenuItem(title:String,image:UIImage? = nil){
        let item = menuItem(title: title, image: image)
        self.menuItems.append(item)
    }
    
    func showMenuInView(view:UIView,atPoint:CGPoint,offset:CGFloat = 10,action:(Index:Int)->Void ){
        self.showPoint = atPoint
        self.selectAction = action
        self.tableView.frame = self.tableViewFrame
        view.addSubview(self)
        self.tableView.alpha = 0
        UIView.animateWithDuration(0.4) { [weak self]() -> Void in
            guard let sSelf = self else{return}
            sSelf.tableView.alpha = 1
        }
    }
    
    //MARK: tableViewDelegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil{
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
            cell?.contentView.backgroundColor = c2
            cell?.textLabel?.textColor = UIColor.whiteColor()
            cell?.separatorInset = UIEdgeInsetsZero
            cell?.layoutMargins = UIEdgeInsetsZero
            cell?.preservesSuperviewLayoutMargins = false
            cell?.selectionStyle = .None
        }
        let item = self.menuItems[indexPath.row]
        cell?.textLabel?.text  = item.title
        cell?.imageView?.image = item.image
        
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectAction?(index:indexPath.row)
        self.removeFromSuperview()
    }
    
    //
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.removeFromSuperview()
    }
}