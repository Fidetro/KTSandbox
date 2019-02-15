//
//  KTSandboxTableViewCell.swift
//  KTSandbox
//
//  Created by Fidetro on 2019/2/15.
//  Copyright © 2019 karim. All rights reserved.
//

import UIKit

class KTSandboxTableViewCell: UITableViewCell {
    
    static let identifier = "kKTSandboxTableViewCellIdentifier"

    static func dequeueReusable(with tableView:UITableView) -> KTSandboxTableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: KTSandboxTableViewCell.identifier)
        if  let cell = reusableCell as? KTSandboxTableViewCell {
            return cell
        }else{
            let cell = KTSandboxTableViewCell.init(style: .default, reuseIdentifier: KTSandboxTableViewCell.identifier)
            return cell
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        snpLayoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: setup view
extension KTSandboxTableViewCell {
    func snpLayoutSubview() {
        
    }
}
