//
//  File.swift
//  
//
//  Created by Braden Scothern on 4/6/21.
//

import Foundation

public protocol BundleFinder: AnyObject {
    static var packageName: String { get }
    static var moduleName: String { get }
    static var packageModule: Bundle { get }
}

extension BundleFinder {
    fileprivate static var bundleName: String {
        "\(packageName)_\(moduleName).bundle"
    }
}

extension Bundle {
    private static var foundBundles: [String: Bundle] = [:]

    public static func package(finder: BundleFinder.Type) -> Bundle {
        #if !DEBUG
        return finder.packageModule
        #else
        if let bundle = foundBundles[finder.bundleName] {
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
            let bundlePath = candidate?.appendingPathComponent(finder.bundleName)
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                foundBundles[finder.packageName] = bundle
                return bundle
            }
        }
        fatalError("Unable to find bundle named: \(finder.bundleName)")
        #endif
    }
}
