/*
 *  RTK.h
 *  RevTK
 *
 *  Created by John Bradley on 3/29/10.
 *  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
 *
 *  Define statement taken from: 
 * 
 * http://blog.mbcharbonneau.com/2008/10/27/better-logging-in-objective-c/
 *
 */

#define RTKLog( s, ... ) NSLog( @"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#define RTKLogO( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#define RTKBoolStr(b) (b ? @"YES" : @"NO")