//
//  WebpageViewController.swift
//  ChemicalElements
//
//  Created by John on 9/24/19.
//  Copyright © 2019 Abraham Shenghur. All rights reserved.
//

import UIKit
import WebKit


class WebpageViewController: UIViewController, WKNavigationDelegate {
    
    var webpageTitle = ""
    var theURLPassedInFromOrigin: String?
    var urlToUseForOpeningWebpage: String?
    
    var isPageLoading = true
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var previousWebpage: UIBarButtonItem!
    @IBOutlet weak var nextWebpage: UIBarButtonItem!
    @IBOutlet weak var stopLoading: UIBarButtonItem!
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func previousWebpageTapped(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    @IBAction func nextWebpageTapped(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    @IBAction func stopLoadingButton(_ sender: UIBarButtonItem) {
        if !isPageLoading {
            setToolbarWhileLoading()
        } else {
            setToolbarWhenStopped()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()
        loadURL()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.title = webpageTitle
        previousWebpage.isEnabled = false
        nextWebpage.isEnabled = false
        stopLoading.isEnabled = true
    }
    
    
    func setToolbarWhileLoading() {
        var items = toolbar.items
        items![1] = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.stop, target: self, action: #selector(stopLoadingButton(_:)))
        isPageLoading = true
        toolbar.setItems(items, animated: true)
    }

    func stopLoadingWebView() {
        webView.stopLoading()
    }
    
    
    @objc func setToolbarWhenStopped() {
        var items = toolbar.items
        items![1] = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(reloadWebView))
        toolbar.setItems(items, animated: true)
        isPageLoading = false
    }
    
    @objc func reloadWebView() {
        setToolbarWhileLoading()
        webView.reload()
    }

    
    func setupWebView() {
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        activityIndicator.startAnimating()
    }

    func loadURL() {
        if let elementHyperlink = self.theURLPassedInFromOrigin {
            urlToUseForOpeningWebpage = elementHyperlink
        }
        
        if let elementURL = urlToUseForOpeningWebpage {
            let validURL = URL(string: elementURL)
            let request = URLRequest(url: validURL!)
            webView.load(request)
            
        } else {
            let alert = UIAlertController(title: "URL Status", message: "Invalid URL", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action) in
                self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicator.startAnimating()
        setToolbarWhileLoading()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.canGoBack {
            previousWebpage.isEnabled = true
        } else {
            previousWebpage.isEnabled = false
        }
        
        if webView.canGoForward {
            nextWebpage.isEnabled = true
        } else {
            nextWebpage.isEnabled = false
        }
        activityIndicator.stopAnimating()
        setToolbarWhenStopped()
    }
}

