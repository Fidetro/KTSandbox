//
//  KTSandboxViewModel.swift
//  KTSandbox
//
//  Created by Fidetro on 2019/2/15.
//  Copyright © 2019 karim. All rights reserved.
//

import UIKit
import File
class KTSandboxViewModel: NSObject {

    static func dequeueReusable(with tableView: UITableView,
                                indexPath: IndexPath,
                                files: [String],
                                selectFiles: [String],
                                rootPath: String) -> KTSandboxTableViewCell {
        let cell = KTSandboxTableViewCell.dequeueReusable(with: tableView)
        if indexPath.row == 0 {
            cell.textLabel?.text = ".."
            cell.backgroundColor = .white
        }else{
            let filename = files[indexPath.row-1]
            var isDirectory = ObjCBool(false)
            let _ = File.fileExists(atPaths: [rootPath,filename], isDirectory: &isDirectory)
            if isDirectory.boolValue {
                cell.textLabel?.text = "📁 \(filename)"
            }else{
                cell.textLabel?.text = filename
            }
            if selectFiles.contains(filename) {
                cell.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
            }else{
                cell.backgroundColor = .white
            }
        }
        

        
        
        return cell
    }
    
}
