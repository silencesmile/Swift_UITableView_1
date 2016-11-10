//
//  ViewController.swift
//  521Travel_ UITableView
//
//  Created by youngstar on 16/11/1.
//  Copyright © 2016年 Young. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ctrlNames:[String]!
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 初始化数据
        ctrlNames = NSArray(contentsOfFile:
            Bundle.main.path(forResource: "521Travel", ofType:"plist")!) as? Array
        
        print("array\(ctrlNames)")
        
        // 创建表格
        tableView = UITableView.init(frame: CGRect(x:0, y:20, width:self.view.frame.size.width, height:self.view.frame.size.height - 20), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        // 通过初始化 去除多余的cell
        tableView.tableFooterView = UIView.init()
        
        // 重用单元格  注册cell
        tableView .register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view .addSubview(tableView)
        
        
//         通过代码自动将表格UITableView滚动条移动到尾部，只需要使用scrollToRowAtIndexPath方法即可
//        let secon = 0 //最后一个分组的索引（0开始，如果没有分组则为0）
//        let rows = 35 //最后一个分组最后一条项目的索引
//        let indexPath = NSIndexPath.init(row: rows, section: secon)
//        tableView?.scrollToRow(at: indexPath as IndexPath, at:UITableViewScrollPosition.bottom, animated: true)
        
        
        
        let frame = CGRect(x:0, y:0, width:self.view.bounds.size.width, height:30)
        let headerLabel = UILabel.init(frame: frame)
        headerLabel.backgroundColor = UIColor.yellow
        headerLabel.textColor = UIColor.red
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = .byWordWrapping
        headerLabel.text = "常见 UIKit 控件"
        headerLabel.textAlignment = NSTextAlignment.center
        headerLabel.font = UIFont.systemFont(ofSize: 15)
        tableView.tableHeaderView = headerLabel
        
    }
    
    // 创建分区
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 创建每个分区返回的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ctrlNames.count
    }
    
    // 创建各单元显示内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // 为了提供表格显示性能，已创建完成的单元需重复使用
        let identify:String = "cell"
        
        // 同一形式的单元格重复使用，在声明时已注册
        let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath)
        // cell的显示形式
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = ctrlNames[indexPath.row]
        
        return cell
    }
    
    // 输出选中按钮
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let didStr = ctrlNames[indexPath.row]
        
        print(didStr)
    }
    
    // 滑动删除必须实现的方法
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("删除cell")
        let index = indexPath.row
        ctrlNames .remove(at: index)
        
        tableView.deleteRows(at:[indexPath], with: UITableViewRowAnimation.right)
    }
    
    // 滑动删除
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
   // 修改删除按钮的文字
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "delete"
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

