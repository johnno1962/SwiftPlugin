//
//  PluginAPI.swift
//  SwiftPlugin
//
//  Created by John Holdsworth on 11/02/2019.
//  Copyright © 2019 John Holdsworth. All rights reserved.
//

// class + instance methods to be implemented in the Plugin

open class PluginAPI {

    open class func getInstance() -> MyPlugin {
        fatalError("getInstanceMain")
    }

    open func incCounter() -> Int {
        fatalError("incCounterMain")
    }
}
