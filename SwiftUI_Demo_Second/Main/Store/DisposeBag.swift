//
//  DisposeBag.swift
//  SwiftUI_Demo_Second
//
//  Created by LFZ on 2020/2/25.
//  Copyright © 2020 LFZ. All rights reserved.
//

import Combine

class DisposeBag {
    private var values: [AnyCancellable] = []
    func add(_ value: AnyCancellable) {
        // 加锁
        values.append(value)
    }
}

extension AnyCancellable {
    func add(to bag: DisposeBag) {
        bag.add(self)
    }
}

