//
//  SearchViewController.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/15.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import UIKit

enum SearchTypeSegments: Int {
    case repositories, users
    
    var title: String {
        switch self {
        case .repositories: return R.string.localizable.searchRepositoriesSegmentTitle.key.localized()
        case .users: return R.string.localizable.searchUsersSegmentTitle.key.localized()
        }
    }
}

class SearchViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        
    }
}
