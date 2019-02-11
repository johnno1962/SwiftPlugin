//
//  AppDelegate.swift
//  SwiftPluginApp
//
//  Created by John Holdsworth on 11/02/2019.
//  Copyright © 2019 John Holdsworth. All rights reserved.
//

import Cocoa

// Class MyPlugin from bundle is overlayed onto this placeholder class

open class MyPlugin: PluginAPI {}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

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

        let bundlePath = Bundle.main.path(forResource: "MyPlugin", ofType: "bundle")!
        let pluginPath = Bundle(path: bundlePath)!.executablePath!

        let cl = LoadPlugin(onto: MyPlugin.self, dylib: pluginPath)

        let i = cl.getInstance()
        print(i.incCounter())
        print(i.incCounter())
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

