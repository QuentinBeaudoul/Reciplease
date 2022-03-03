//
//  SearchManager.swift
//  RSearch
//
//  Created by Quentin on 03/03/2022.
//

import Foundation
import UIKit
import RExtension

public final class SearchManager {
    
    public static let shared = SearchManager()
    private init() {}
    
    public func getViewController() -> UIViewController {
        let viewController = SearchViewController.makeFromStoryboard(in: Bundle(for: Self.self))
        viewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        return viewController
    }
}
