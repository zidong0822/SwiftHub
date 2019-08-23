//
//  LanguageCellViewModel.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/22.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LanguageCellViewModel: DefaultTableViewCellViewModel {
    
    let language: String
    var currentLanguage: String
    init(with language: String, currentLanguage: String) {
        self.language = language
        self.currentLanguage = currentLanguage
        super.init()
        title.accept(displayName(forLanguage: language))
    }
}

func displayName(forLanguage language: String) -> String {
    let local = Locale(identifier: language)
    if let displayName = local.localizedString(forIdentifier: language) {
        return displayName.capitalized(with: local)
    }
    return String()
}
