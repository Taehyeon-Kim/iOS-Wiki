//
//  MainViewController.swift
//  MVVMSample2
//
//  Created by taehy.k on 2021/08/01.
//

import UIKit

class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let productsVC = storyboard.instantiateViewController(identifier: "SearchResultsViewController") as! SearchResultsViewController
        productsVC.title = "Products"
        productsVC.data = [
            ProductViewModel(product: Product(name: "Preflight Airport Parking", rating: 2.0, price: nil)),
            ProductViewModel(product: Product(name: "Adobe Experience Manager", rating: 4.0, price: nil)),
            ProductViewModel(product: Product(name: "RedBull Flugtag Pre-Flight", rating: 3.0, price: nil)),
            ProductViewModel(product: Product(name: "PreFlight", rating: 2.0, price: 4.99)),
            ProductViewModel(product: Product(name: "PAW Patrol pups Take Flight", rating: 2.0, price: 2.99))
        ]
        
        // Generate the DomainsVC and some domains
        let domainsVC = storyboard.instantiateViewController(withIdentifier: "SearchResultsViewController") as! SearchResultsViewController
        domainsVC.title = "Domains"
        domainsVC.data = [
            DomainViewModel(domain: Domain(domainName: "facebook.com", domainStatus: .Taken)),
            DomainViewModel(domain: Domain(domainName: "facebook.org", domainStatus: .Available)),
            DomainViewModel(domain: Domain(domainName: "facebook.net", domainStatus: .Available)),
            DomainViewModel(domain: Domain(domainName: "facebook.edu", domainStatus: .Other)),
        ]
        
        // Set the created VCs as the view controllers for our tabbar
        self.setViewControllers([productsVC, domainsVC], animated: false)
    }
}
