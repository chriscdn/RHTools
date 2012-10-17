# RHTools

RHTools is a collection of useful objective-c categories and classes.

## NSDate+timesince.h

This category adds a `-timesince` method to `NSDate`, which compares the receiver to the current date and returns the interval in a human readable format format.  For example,

``` objective-c
NSDate *d = [NSDate dateWithTimeIntervalSinceNow:-30020];
NSString *ts = [d timesince]; // 8 hours, 20 minutes
```

The category also has a -timesinceWithDepth:` method, which controls how much precision you’d like in the output.  For example,

``` objective-c
NSDate *d = [NSDate dateWithTimeIntervalSinceNow:-30020];
NSString *ts = [d timesinceWithDepth:3]; // 8 hours, 20 minutes, 20 seconds
```

There is also a `-timesinceDate:withDepth:` method, which lets you compare the difference between any two arbitrary dates.

## Contact

[Christopher Meyer](https://github.com/chriscdn)  
[@chriscdn](http://twitter.com/chriscdn)

## License
RHManagedObject is available under the MIT license. See the LICENSE file for more info.