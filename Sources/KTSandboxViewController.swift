//
//  KTSandboxViewController.swift
//  KTSandbox
//
//  Created by Fidetro on 2019/2/15.
//  Copyright © 2019 karim. All rights reserved.
//

import UIKit
import File



class KTSandboxViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    enum Mode {
        case normal
        case selected
    }
    
    var mode : Mode = .normal
    var selectFiles = [String]()
    var files = [String]()
    var rootPath = NSHomeDirectory()
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        return tableView
    }()
    
    lazy var closeBtn: UIButton = {
        var button = UIButton()
        button.setTitle("关闭", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return button
    }()
    
    lazy var selectBtn: UIButton = {
        var button = UIButton()
        button.setTitle("选择", for: .normal)
        button.setTitle("取消", for: .selected)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(selectAction(sender:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        do{
            files = try File.contentsOfDirectory(atPath: [rootPath])
            tableView.reloadData()
            
        }catch{}
    }
    @objc func selectAction(sender: UIButton) {
        if mode == .normal {
           mode = .selected
            sender.isSelected = false
            sender.setTitle("全选", for: .normal)
            selectFiles.removeAll()
        }else{
            if sender.isSelected {
                mode = .normal
                sender.setTitle("选择", for: .normal)
                selectFiles.removeAll()
                tableView.reloadData()
            }else{
                selectFiles.removeAll()
                selectFiles.append(contentsOf: files)
                tableView.reloadData()
            }
            sender.isSelected = !sender.isSelected
        }
    }
    
    @objc func closeAction() {
        mode = .normal
        selectFiles.removeAll()
        selectBtn.setTitle("选择", for: .normal)
        selectBtn.isSelected = false
        tableView.reloadData()
        KTSandbox.share.close()
    }
    
    @objc func panAction() {
        guard selectFiles.count != 0 else{
            return
        }
        var items = [URL]()
        
        for file in selectFiles {
           let url = URL(fileURLWithPath: file)
            items.append(url)
        }
        
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        if #available(iOS 11.0, *) {
            activityVC.excludedActivityTypes = [.mail,.markupAsPDF,.saveToCameraRoll,.copyToPasteboard]
        } else {
            activityVC.excludedActivityTypes = [.mail,.saveToCameraRoll,.copyToPasteboard]
        }
        present(activityVC, animated: true, completion: nil)
    }
    
}

// MARK: setup view
extension KTSandboxViewController {
    func setupViews() {
        let leftSpace = CGFloat(50.0)
        let topSpace = CGFloat(100.0)
        
        tableView.frame = CGRect(x: leftSpace, y: topSpace, width: UIScreen.main.bounds.size.width-leftSpace*2.0, height: UIScreen.main.bounds.size.height-topSpace*2.0)
        view.addSubview(tableView)
        closeBtn.frame = CGRect.init(x: 0, y: topSpace-30.0, width: leftSpace, height: 30)
        closeBtn.frame.origin.x = UIScreen.main.bounds.size.width-leftSpace*2.0
        view.addSubview(closeBtn)
        selectBtn.frame = CGRect.init(x: leftSpace, y: topSpace-30.0, width: leftSpace, height: 30)
        view.addSubview(selectBtn)
        
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(panAction))
        gesture.edges = .left
        view.addGestureRecognizer(gesture)
    }
}

// MARK: view delegate
extension KTSandboxViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = KTSandboxViewModel.dequeueReusable(with: tableView,
                                                      indexPath: indexPath,
                                                      files: files,
                                                      selectFiles: selectFiles,
                                                      rootPath: rootPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.row == 0 {
            if mode == .selected {
             return
            }
            
            if rootPath == NSHomeDirectory() {
                return
            }
            for (index,c) in rootPath.reversed().enumerated() {
                if c == "/" {
                    if let backPath = rootPath[0..<(rootPath.count-index-2)] {
                        do{
                            rootPath = backPath
                            files = try File.contentsOfDirectory(atPath: [rootPath])
                            tableView.reloadData()
                        }catch{}
                        break
                    }
                }
            }
        }else{
            let filename = files[indexPath.row-1]
            if mode == .selected {
                if let index = selectFiles.firstIndex(of: filename) {
                    selectFiles.remove(at: index)
                }else{
                    selectFiles.append(filename)
                }
                tableView.reloadData()
                return
            }
            
            do{
                selectFiles.removeAll()
                files = try File.contentsOfDirectory(atPath: [rootPath,filename])
                rootPath = rootPath + "/" + filename
                tableView.reloadData()
            }catch{}
        }
        
    }
    
}
