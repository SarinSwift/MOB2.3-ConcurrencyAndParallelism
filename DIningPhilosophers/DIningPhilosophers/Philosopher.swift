//
//  Philosopher.swift
//  DIningPhilosophers
//
//  Created by Sarin Swift on 6/22/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import Foundation


// associate a couple of forks to each Philosopher
struct Philosopher {
    var philosopherIndex: Int
    var forkPair: ForkPair
    
    var leftIndex = -1
    var rightIndex = -1
    
    init(philosopherIndex: Int) {
        leftIndex = philosopherIndex
        rightIndex = philosopherIndex - 1
        
        if rightIndex < 0 {
            rightIndex += ViewController.numberOfPhilosophers
        }
        
        self.philosopherIndex = philosopherIndex
        self.forkPair = ForkPair(leftIndex: leftIndex, rightIndex: rightIndex)
        
        print("Philosopher: \(philosopherIndex), left: \(leftIndex), right: \(rightIndex)")
    }
    
    func run() {
        while true {
            // start eating
            print("acquiring lock for philosopher: \(philosopherIndex), left: \(leftIndex), right: \(rightIndex)")
            forkPair.pickup()
            print("start eating philospher: \(philosopherIndex)")
            
            sleep(2)
            
            // finished eating
            print("releasing lock for philosopher: \(philosopherIndex), left: \(leftIndex), right: \(rightIndex)")
            forkPair.putDown()
        }
    }
}
