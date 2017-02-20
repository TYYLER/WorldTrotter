//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Tyler Bailey on 2/6/17.
//  Copyright © 2017 Tyler Bailey. All rights reserved.
//

import UIKit
import WebKit


class WebViewController: UIViewController{
    
    var webView : WKWebView!
    
    override func loadView()
    {
        setupWebPage()
    }
    
    func setupWebPage()
    {
        webView = WKWebView();
        view = webView;
        
        let url = URL(string: "https://www.bignerdranch.com");
        let urlRequest = URLRequest(url: url!);
        
        webView.load(urlRequest);
    }
}
