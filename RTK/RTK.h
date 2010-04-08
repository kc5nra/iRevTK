//	RTK.h
//	RevTK
//
//	Created by John Bradley on 3/29/10.
//	Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//
//	RTKLog define statement modeled after: 
//	http://blog.mbcharbonneau.com/2008/10/27/better-logging-in-objective-c/
//

/**
 A helper macro that prints out useful line/source information in addition to a formatted string.
 Use this function outside the context of a object.  (This is safe to use inside or outside of a class)
 @param s a format string
 @param ... a variable list of arguments
 */
#define RTKLog( s, ... ) NSLog( @"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

/**
 A helper macro that prints out useful line/source information in addition to a formatted string.
 Use this function inside the context of a object.  Since this references 'self' you must be
 residing in a class when you perform this macro.
 @param ... a variable list of arguments
 */
#define RTKLogO( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

/**
 A Helper function that turns a boolean value into it's NSString* repsentation.
 @param b the BOOL to convert to it's string representation.
 */ 
#define RTKBoolStr(b) (b ? @"YES" : @"NO")