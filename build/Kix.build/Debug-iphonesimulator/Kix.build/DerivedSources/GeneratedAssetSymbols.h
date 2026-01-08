#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "Image" asset catalog image resource.
static NSString * const ACImageNameImage AC_SWIFT_PRIVATE = @"Image";

/// The "Image 1" asset catalog image resource.
static NSString * const ACImageNameImage1 AC_SWIFT_PRIVATE = @"Image 1";

/// The "adizeroadiospro3" asset catalog image resource.
static NSString * const ACImageNameAdizeroadiospro3 AC_SWIFT_PRIVATE = @"adizeroadiospro3";

/// The "aitzoompegasus40" asset catalog image resource.
static NSString * const ACImageNameAitzoompegasus40 AC_SWIFT_PRIVATE = @"aitzoompegasus40";

/// The "bondi8" asset catalog image resource.
static NSString * const ACImageNameBondi8 AC_SWIFT_PRIVATE = @"bondi8";

/// The "clifton9" asset catalog image resource.
static NSString * const ACImageNameClifton9 AC_SWIFT_PRIVATE = @"clifton9";

#undef AC_SWIFT_PRIVATE
