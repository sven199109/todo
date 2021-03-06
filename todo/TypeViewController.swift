//
//  TypeViewController.swift
//  todo
//
//  Created by sven liu on 16/8/7.
//  Copyright © 2016年 sven liu. All rights reserved.
//

import UIKit

class TypeViewController: UITableViewController {
    var typeList = [TypeItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        todoModel.sortLists()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return super.numberOfSectionsInTableView(tableView)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoModel.typeList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let typeItem = todoModel.typeList[indexPath.row]
        let cellIdentifier = "typeCell"
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        cell.textLabel!.text = typeItem.name
        cell.imageView!.image = UIImage(named: typeItem.icon)

        if typeItem.items.count == 0 {
            cell.detailTextLabel?.text = "还没有添加任务"
        } else {
            let count = typeItem.countUncheckedItems()
            if count == 0 {
                cell.detailTextLabel?.text = "全部搞定"
            } else {
                cell.detailTextLabel?.text = "还有\(count)个任务要完成"
            }
        }
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let type = todoModel.typeList[indexPath.row]
        self.performSegueWithIdentifier("showTodoList", sender: type)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        todoModel.typeList.removeAtIndex(indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "编辑", handler: { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            let typeItem = todoModel.typeList[indexPath.row]
            let navigation = self.tabBarController?.viewControllers?[1] as! UINavigationController
            let typeDetail = navigation.viewControllers.first as? TypeDetailViewController
            typeDetail?.onEditType(typeItem)
            self.tabBarController?.selectedIndex = 1
        })
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "删除", handler: { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            todoModel.typeList.removeAtIndex(indexPath.row)
            let indexPaths = [indexPath]
            tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        })
        editAction.backgroundColor = UIColor.lightGrayColor()
        deleteAction.backgroundColor = UIColor.redColor()
        todoModel.saveData()
        return [deleteAction, editAction]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! TodoListController
        controller.todoList = sender as? TypeItem
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
