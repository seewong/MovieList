//
//  DetailCacheManager.swift
//  TubiMovies
//
//  Created by Chris Wong on 6/28/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import Foundation

class DetailCache<K: Hashable, V> {
    fileprivate let maxSize: Int
    public var currentSize: Int = 0
    fileprivate let linkedList: DoublyLinkedList<K, V>
    fileprivate var dict: [K: DoublyLinkedListNode<K, V>]

    init(size: Int) {
        let checkedSize = max(0, size)
        self.maxSize = checkedSize
        self.linkedList = DoublyLinkedList()
        //Does not have to reallocate
        self.dict = [K: DoublyLinkedListNode<K, V>](minimumCapacity: checkedSize)
    }

    func add(key: K, val: V) {
        if let node = self.dict[key] {
            //Hit
            node.val = val
            self.linkedList.moveToHead(node)
        } else {
            //Miss
            let node = DoublyLinkedListNode(key: key, val: val)

            if self.currentSize < self.maxSize {
                self.dict[key] = node
                self.linkedList.addHead(node: node)

                self.currentSize += 1
            } else {
                if let tail = self.linkedList.removeLast() {
                    dict.removeValue(forKey: tail.key)
                }

                self.linkedList.addHead(node: node)
                self.dict[key] = node
            }
        }
    }

    func get(key: K) -> V? {
        guard let node = self.dict[key] else { return nil }
        self.linkedList.moveToHead(node)
        return node.val
    }

    func isValid(key: K) -> Bool {
        return self.dict[key] != nil
    }
}
