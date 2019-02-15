//
//  KTSandbox.swift
//  KTSandbox
//
//  Created by Fidetro on 2019/2/15.
//  Copyright © 2019 karim. All rights reserved.
//

import UIKit
import File
public class KTSandbox: NSObject {
    
    public static let share = KTSandbox()
    
    private lazy var window: UIWindow = {
        var window = UIWindow(frame: UIScreen.main.bounds)
        window.windowLevel = .statusBar
        window.rootViewController = KTSandboxViewController()
        window.isHidden = true
        return window
    }()
    
    private override init() { }
    
    public func enable() {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(panAction))
        gesture.edges = .right
        if let keyWindow = UIApplication.shared.keyWindow {
            keyWindow.addGestureRecognizer(gesture)
        }else{
            assertionFailure("keyWindow is nil")
        }
        
    }
    
    func close() {
        window.isHidden = true
    }
    
    @objc private func panAction() {
        window.isHidden = false
    }
    
}
