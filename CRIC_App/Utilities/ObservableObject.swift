//
//  ObservableObject.swift
//  CRIC_App
//
//  Created by BJIT on 24/11/1401 AP.
//

import Foundation

class ObservableObject<T> {
    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    private var listener: ((T) -> Void)?
    func bind(listener: @escaping (T) -> Void) {
        self.listener = listener
    }
}
