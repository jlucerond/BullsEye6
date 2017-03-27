//
//  AboutViewController.swift
//  BullsEye6
//
//  Created by Joe Lucero on 3/6/17.
//  Copyright © 2017 Joe Lucero. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak var webview: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html") {
            if let data = try? Data(contentsOf: url) {
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                webview.load(data, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
            }
        }
    }
    
    @IBAction func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }

}
