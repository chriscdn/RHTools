# RHTools

RHTools is a collection of useful Objective-C categories and classes.

## NSDate+timesince.h

This category adds a `-timesince` method to `NSDate`, which compares the receiver to the current date and returns the interval in a human readable format.  For example,

``` objective-c
NSDate *d = [NSDate dateWithTimeIntervalSinceNow:-30020];
NSString *ts = [d timesince]; // 8 hours, 20 minutes
```

The category also has a `-timesinceWithDepth:` method, which controls how much precision you'd like in the output.  For example:

``` objective-c
NSDate *d = [NSDate dateWithTimeIntervalSinceNow:-30020];
NSString *ts = [d timesinceWithDepth:3]; // 8 hours, 20 minutes, 20 seconds
```

There is also a `-timesinceDate:withDepth:` method, which lets you compare the difference between any two arbitrary dates.

## NSDate+formatter.h

This category adds date formatting directly to the `NSDate` class, which prevents the need to instantiate an `NSDateFormatter` object each time you want to format a date for display.  The category creates and caches a single `NSDateFormatter` for you, which can be reused over and over again in your app.  This is a good thing since you'll likely be using the same date formatting through your app anyway.  For example:

``` objective-c
NSString *now = [[NSDate date] formatWithLocalTimeZone]; // Today, 11:45 AM
NSString *utcnow = [[NSDate date] formatWithUTCTimeZone]; // Today, 9:45 AM
```

The formatter is configured with defaults that you may or may not like.  You can change any of the options directly on the formatter.  For example, to disable relative formatting you could add the following to the `-application:didFinishLaunchingWithOptions:` method of your app delegate:

``` objective-c
[[NSDate formatter] setDoesRelativeDateFormatting:NO];
```

This will change the formatting behaviour anytime the c

## Contact

[Christopher Meyer](https://github.com/chriscdn)  
[@chriscdn](http://twitter.com/chriscdn)

## License
RHManagedObject is available under the MIT license. See the LICENSE file for more info.