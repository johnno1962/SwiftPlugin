//
//  MyPlugin.swift
//  MyPlugin
//
//  Created by John Holdsworth on 10/02/2019.
//  Copyright © 2019 John Holdsworth. All rights reserved.
//

// Concrete implementation of the plugin

open class MyPlugin: PluginAPI {

    // The module name of plugin project must be the same as the parent project
    // so the class symbols match. This requires using the legacy build system.

    open var counter = 0

    open override class func getInstance() -> MyPlugin {
        print("getInstancePlugin")
        return MyPlugin()
    }

    open override func incCounter() -> Int {
        print("incCounterPlugin")
        counter += 1
        return counter
    }
}

