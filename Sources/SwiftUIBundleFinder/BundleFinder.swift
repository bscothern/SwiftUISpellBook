//
//  BundleFinder.Value.swift
//  SwiftUISpellBook
//
//  Created by Braden Scothern on 4/6/21.
//  Copyright © 2020-2024 Braden Scothern. All rights reserved.
//

import Foundation

public protocol BundleFinder: AnyObject {
    static var packageName: String { get }
    static var moduleName: String { get }
    static var packageModule: Bundle { get }
}

extension Bundle {
    static let lock: NSRecursiveLock = .init()
    nonisolated(unsafe) private static var _foundBundles: [String: Bundle] = [:]
    private static var foundBundles: [String: Bundle] {
        get {
            lock.withLock { _foundBundles }
        }
        set {
            lock.withLock { _foundBundles = newValue }
        }
        _modify {
            lock.lock()
            defer {
                lock.unlock()
            }
            yield &_foundBundles
        }
    }

    public static func bundleFinder(_ finder: BundleFinder.Type) -> Bundle {
        #if !DEBUG
        return finder.packageModule
        #else

        let bundleName = "\(finder.packageName)_\(finder.moduleName).bundle"

        if let bundle = foundBundles[bundleName] {
            return bundle
        }

        let candidates = [
            // Main app bundle
            Bundle.main.resourceURL,

            // Framework bundle location
            Bundle(for: finder.self).resourceURL,

            // CLI
            Bundle.main.bundleURL,

            // iOS Previews
            Bundle(for: finder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),

            // macOS Previews
            Bundle(for: finder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent(),
        ]

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName)
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                foundBundles[finder.packageName] = bundle
                return bundle
            }
        }
        fatalError("Unable to find bundle: \(bundleName)")
        #endif
    }
}
