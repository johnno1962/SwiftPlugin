//
//  MyPlugin.swift
//  MyPlugin
//
//  Created by John Holdsworth on 10/02/2019.
//  Copyright © 2019 John Holdsworth. All rights reserved.
//

import Foundation

open class MyPlugin {

    // Initial methods used in the parent class must appear in the same order
    // and the module name of plugin project must be the same as the parent
    // project. This requires using the legacy build system at the moment.

    open class func getInstance() -> MyPlugin {
        print("getInstancePlugin")
        return MyPlugin()
    }

    open func incCounter() -> Int {
        print("incCounterPlugin")
        counter += 1
        return counter
    }

    open var counter = 0
}

