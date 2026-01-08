import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ImageResource {

    /// The "Image" asset catalog image resource.
    static let image = DeveloperToolsSupport.ImageResource(name: "Image", bundle: resourceBundle)

    /// The "Image 1" asset catalog image resource.
    static let image1 = DeveloperToolsSupport.ImageResource(name: "Image 1", bundle: resourceBundle)

    /// The "adizeroadiospro3" asset catalog image resource.
    static let adizeroadiospro3 = DeveloperToolsSupport.ImageResource(name: "adizeroadiospro3", bundle: resourceBundle)

    /// The "aitzoompegasus40" asset catalog image resource.
    static let aitzoompegasus40 = DeveloperToolsSupport.ImageResource(name: "aitzoompegasus40", bundle: resourceBundle)

    /// The "bondi8" asset catalog image resource.
    static let bondi8 = DeveloperToolsSupport.ImageResource(name: "bondi8", bundle: resourceBundle)

    /// The "clifton9" asset catalog image resource.
    static let clifton9 = DeveloperToolsSupport.ImageResource(name: "clifton9", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "Image" asset catalog image.
    static var image: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .image)
#else
        .init()
#endif
    }

    /// The "Image 1" asset catalog image.
    static var image1: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .image1)
#else
        .init()
#endif
    }

    /// The "adizeroadiospro3" asset catalog image.
    static var adizeroadiospro3: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .adizeroadiospro3)
#else
        .init()
#endif
    }

    /// The "aitzoompegasus40" asset catalog image.
    static var aitzoompegasus40: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .aitzoompegasus40)
#else
        .init()
#endif
    }

    /// The "bondi8" asset catalog image.
    static var bondi8: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .bondi8)
#else
        .init()
#endif
    }

    /// The "clifton9" asset catalog image.
    static var clifton9: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .clifton9)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "Image" asset catalog image.
    static var image: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .image)
#else
        .init()
#endif
    }

    /// The "Image 1" asset catalog image.
    static var image1: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .image1)
#else
        .init()
#endif
    }

    /// The "adizeroadiospro3" asset catalog image.
    static var adizeroadiospro3: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .adizeroadiospro3)
#else
        .init()
#endif
    }

    /// The "aitzoompegasus40" asset catalog image.
    static var aitzoompegasus40: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .aitzoompegasus40)
#else
        .init()
#endif
    }

    /// The "bondi8" asset catalog image.
    static var bondi8: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .bondi8)
#else
        .init()
#endif
    }

    /// The "clifton9" asset catalog image.
    static var clifton9: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .clifton9)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

