//
//  SettingsSection.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/16.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import UIKit
import RxDataSources
enum SettingsSection {
    case setting(title:String , items:[SettingsSectionItem])
}

enum SettingsSectionItem {
    
    //偏好设置
    case nightModeItem(viewModel: SettingSwitchCellViewModel)
    case themeItem(viewModel: SettingCellViewModel)
    case languageItem(viewModel: SettingCellViewModel)
    case removeCacheItem(viewModel: SettingCellViewModel)
}

extension SettingsSectionItem: IdentifiableType {
    typealias Identity = String
    var identity: Identity {
        switch self {
        case .nightModeItem(let viewModel): return viewModel.title.value ?? ""
        case .themeItem(let viewModel),
             .languageItem(let viewModel),
             .removeCacheItem(let viewModel): return viewModel.title.value ?? ""
        }
    }
}

extension SettingsSectionItem: Equatable {
    static func == (lhs: SettingsSectionItem, rhs: SettingsSectionItem) -> Bool {
        return lhs.identity == rhs.identity
    }
}

extension SettingsSection: AnimatableSectionModelType, IdentifiableType {
    typealias Item = SettingsSectionItem
    
    typealias Identity = String
    var identity: Identity { return title }
    
    var title: String {
        switch self {
        case .setting(let title, _): return title
        }
    }
    
    var items: [SettingsSectionItem] {
        switch  self {
        case .setting(_, let items): return items.map {$0}
        }
    }
    
    init(original: SettingsSection, items: [Item]) {
        switch original {
        case .setting(let title, let items): self = .setting(title: title, items: items)
        }
    }
}

