//
//  DoublyLinkedList.swift
//  TubiMovies
//
//  Created by Chris Wong on 6/28/19.
//  Copyright © 2019 Christopher Wong. All rights reserved.
//

import Foundation

final class DoublyLinkedList<K, V> {
    private var count = 0
    private var head: DoublyLinkedListNode<K, V>?
    private var tail: DoublyLinkedListNode<K, V>?


    func addHead( node: DoublyLinkedListNode<K, V>) {

        defer {
            head = node
            count += 1
        }
        guard let head = head else {
            tail = node
            return
        }
        head.prev = node
        node.prev = nil
        node.next = head
    }

    func removeLast() -> DoublyLinkedListNode<K, V>?  {
        guard let tail = self.tail else { return nil }

        let prev = tail.prev
        prev?.next = nil
        self.tail = prev
        if count == 1 {
            head = nil
        }
        count -= 1
        return tail
    }

    func moveToHead(_ node: DoublyLinkedListNode<K, V>) {
        guard node !== head else { return }

        let prev = node.prev
        let next = node.next
        prev?.next = next
        next?.prev = prev
        node.next = head
        node.prev = nil
        if node === tail {
            tail = prev
        }
        self.head = node
    }

}

