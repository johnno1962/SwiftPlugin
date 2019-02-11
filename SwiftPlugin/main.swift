//
//  main.swift
//  SwiftPlugin
//
//  Created by John Holdsworth on 10/02/2019.
//  Copyright © 2019 John Holdsworth. All rights reserved.
//

import Foundation

func LoadPlugin<T>(onto: T.Type, dylib: String) -> T.Type {
    guard let handle = dlopen(dylib, RTLD_NOW) else {
        fatalError("Could not open \(dylib) \(String(cString: dlerror()))")
    }

    var info = Dl_info()
    dladdr(unsafeBitCast(onto, to: UnsafeRawPointer?.self), &info)
    guard let replacement = dlsym(handle, info.dli_sname) else {
        fatalError("Could not locate class \(String(cString: info.dli_sname))")
    }

    return unsafeBitCast(replacement, to: T.Type.self)
}

print("Hello, World!")

var info = Dl_info()
dladdr(&info, &info)

let pluginPath = URL(fileURLWithPath: String(cString: info.dli_sname)).deletingLastPathComponent()
    .appendingPathComponent("MyPlugin.bundle/Contents/MacOS/MyPlugin").path

// Class MyPlugin from bundle is overlayed onto this placeholder class

open class MyPlugin: PluginAPI {}

let cl = LoadPlugin(onto: MyPlugin.self, dylib: pluginPath)

let i = cl.getInstance()
print(i.incCounter())
print(i.incCounter())
