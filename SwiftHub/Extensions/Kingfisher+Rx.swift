//
//  Kingfisher+Rx.swift
//  SwiftHub
//
//  Created by Harvey He on 2019/8/19.
//  Copyright © 2019 Harvey He. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

enum ContactsError: Error {
    case accessDenied
}

extension Reactive where Base: UIImageView {
    
    public var imageURL: Binder<URL?> {
        return self.imageURL(withPlaceholder: nil)
    }
    
    public func imageURL(withPlaceholder placeholderImage: UIImage?, options: KingfisherOptionsInfo? = []) -> Binder<URL?> {
        return Binder(self.base, binding: { (imageView, url) in
            imageView.kf.setImage(with: url,
                                  placeholder: placeholderImage,
                                  options: options,
                                  progressBlock: nil,
                                  completionHandler: { (result) in })
        })
    }
}

extension ImageCache: ReactiveCompatible {}

extension Reactive where Base: ImageCache {
    
    func retrieveCacheSize() -> Observable<Int> {
        return Single.create { single in
            self.base.calculateDiskStorageSize { (result) in
                do {
                    single(.success(Int(try result.get())))
                } catch {
                    single(.error(ContactsError.accessDenied))
                }
            }
            return Disposables.create { }
            }.asObservable()
    }
    
    public func clearCache() -> Observable<Void> {
        return Single.create { single in
            self.base.clearMemoryCache()
            self.base.clearDiskCache(completion: {
                single(.success(()))
            })
            return Disposables.create { }
            }.asObservable()
    }
}
