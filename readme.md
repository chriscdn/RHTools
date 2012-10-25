# RHTools

RHTools is a collection of useful Objective-C categories and classes.  All use ARC.

## NSDate+timesince

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

## NSDate+formatter

This category adds date formatting directly to the `NSDate` class, which prevents the need to instantiate an `NSDateFormatter` object each time you want to format a date for display.  The category creates and caches a single `NSDateFormatter` object for you, which can be reused over and over again in your app.  This is a good thing since you'll likely be using the same date formatting throughout your app anyway.  For example:

``` objective-c
NSString *now = [[NSDate date] formatWithLocalTimeZone]; // Today, 11:45 AM
NSString *utcnow = [[NSDate date] formatWithUTCTimeZone]; // Today, 9:45 AM
```

The formatter is configured with defaults that you may or may not like, but you can change any of the options directly on the formatter.  For example, to disable relative formatting you could add the following to the `-application:didFinishLaunchingWithOptions:` method of your app delegate:

``` objective-c
[[NSDate formatter] setDoesRelativeDateFormatting:NO];
```

This is a global change that will affect the output of the formatter whenever you use it after making the change.

## RHActionSheet

`RHActionSheet` is a subclass of `UIActionSheet` and adds block handling to the buttons.  For example:

``` objective-c
RHActionSheet *sheet = [RHActionSheet actionSheetWithTitle:@"Title"];

[sheet addButtonWithTitle:@"Save" block:^{
	// ...
}];

[sheet addDestructiveButtonWithTitle:@"Delete" block:^{
	// ...
}];

[sheet addCancelButton];

[sheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
```

Blocks are released when the user taps a button.  This means you can reference `self` or `sheet` within your blocks without worrying about retain cycles.  This is on the condition that a `show` method is called after allocating.

## RHAlertView

`RHAlertView` is a subclass of `UIAlertView` and adds block handling to the buttons.  For example:

``` objective-c
RHAlertView *alert = [RHAlertView alertWithTitle:@"Title" message:@"Would you like to save?"];

[alert addButtonWithTitle:@"Save" block:^{
	// ...
}];

[alert addCancelButton];
[alert show];
```

Blocks are released when the user taps a button.  This means you can reference `self` or `alert` within your blocks without worrying about retain cycles.  This is on the condition that `show` is called after allocating.

## RHBarButtonItem

`RHBarButtonItem` is a subclass of `UIBarButtonItem` and adds block handling to the button.  For example:

``` objective-c
self.navigationItem.rightBarButtonItem = [RHBarButtonItem itemWithTitle:@"Edit" block:^{
	// ...
}];
```

Blocks are not released when the user taps the button since it's quite likely the user may tap the button a second time.  For that reason any reference to `self` within the block must be done with a weak reference.

## Contact

[Christopher Meyer](https://github.com/chriscdn)  
[@chriscdn](http://twitter.com/chriscdn)

## License
RHManagedObject is available under the MIT license. See the LICENSE file for more info.