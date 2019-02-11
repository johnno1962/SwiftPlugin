//
//  AppDelegate.swift
//  SwiftPluginApp
//
//  Created by John Holdsworth on 11/02/2019.
//  Copyright © 2019 John Holdsworth. All rights reserved.
//

import Cocoa

// Class MyPlugin from bundle is overlayed onto this placeholder class

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

        // version not reliant on plugin class having same mangled name
        func LoadPlugin<T>(onto: T.Type, dylib: String) -> T.Type {
            guard let handle = dlopen(dylib, RTLD_NOW) else {
                fatalError("Could not open \(dylib) \(String(cString: dlerror()))")
            }

            guard let principalClass = dlsym(handle, "principalClass") else {
                fatalError("Could not locate principalClass function")
            }

            let replacement = unsafeBitCast(principalClass,
                    to: (@convention (c) () -> UnsafeRawPointer).self)
            return unsafeBitCast(replacement(), to: T.Type.self)
        }

        print("Hello, World!")

        // find path to dylib
        let bundlePath = Bundle.main.path(forResource: "MyPlugin", ofType: "bundle")!
        let pluginPath = Bundle(path: bundlePath)!.executablePath!

        // get class (type) object for plugin class
        let clazz = LoadPlugin(onto: PluginAPI.self, dylib: pluginPath)

        let instance = clazz.getInstance()
        print(instance.incCounter())
        print(instance.incCounter())
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

