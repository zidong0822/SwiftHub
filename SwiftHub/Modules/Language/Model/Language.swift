//
//  Language.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/22.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import Foundation
import ObjectMapper

private let languageKey = "CurrentLanguageKey"

struct Language: Mappable {
    
    var urlParam: String?
    var name: String?
    
    init?(map: Map) {}
    init() {}
    
    mutating func mapping(map: Map) {
        urlParam <- map["urlParam"]
        name <- map["name"]
    }
    
    func displayName() -> String {
        return (name.isNilOrEmpty == false ? name: urlParam) ?? ""
    }
}

extension Language {
    
    func save() {
        if let json = self.toJSONString() {
            UserDefaults.standard.set(json, forKey: languageKey)
        } else {
            print("Language can't be saved")
        }
    }
    
    static func currentLanguage() -> Language? {
        if let json = UserDefaults.standard.string(forKey: languageKey),
            let language = Language(JSONString: json) {
            return language
        }
        return nil
    }
    
    static func removeCurrentLanguage() {
        UserDefaults.standard.removeObject(forKey: languageKey)
    }
}

extension Language: Equatable {
    static func == (lhs: Language, rhs: Language) -> Bool {
        return lhs.urlParam == rhs.urlParam
    }
}
