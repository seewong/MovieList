//
//  DoublyLinkedListNode.swift
//  TubiMovies
//
//  Created by Chris Wong on 6/28/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import Foundation

final class DoublyLinkedListNode<K, V> {
    let key: K
    var val: V
    var prev: DoublyLinkedListNode<K, V>?
    var next: DoublyLinkedListNode<K, V>?

    init(key: K, val: V) {
        self.key = key
        self.val = val
    }
}

