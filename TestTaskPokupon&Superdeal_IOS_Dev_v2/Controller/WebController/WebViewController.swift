//
//  WebViewController.swift
//  TestTaskPokupon&Superdeal_IOS_Dev_v2
//
//  Created by Dmitry Grusha on 15.04.2018.
//  Copyright © 2018 Dmitry Grusha. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: currentSvnUrl) else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    @IBAction func dismiss(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }

}
