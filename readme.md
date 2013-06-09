# RHTools

RHTools is a collection of useful Objective-C categories and classes.  All use ARC and can be globally added to your project by importing `RHTools.h` in your prefix header.

## NSArray+rhextensions

This category adds a `-firstObject` method to `NSArray`.  It's a convenience method to fetch the first object of an `NSArray` without having to first check if the array is empty.  Just like the `-lastObject` method, it will also return `nil` if the array is empty.

## NSDictionary+rhextensions

This category adds a `-objectForKey:defaultValue:` method to `NSDictionary`.  It is the same as `-objectForKey:`, but returns the `defaultValue` if the value is `[NSNull null]`, `nil`, or not found.

## NSDate+formatter

This category adds date formatting directly to the `NSDate` class, which prevents the need to instantiate an `NSDateFormatter` object each time you want to format a date for display.  The category creates and caches two `NSDateFormatter` objects (one with time and one without), which can be reused in your app.  This is a good thing since you'll likely be using the same date format throughout your app anyway.  For example:

``` objective-c
NSString *now = [[NSDate date] formatWithLocalTimeZone];    // "Today, 12:45 AM" (assuming GMT+2)
NSString *utcnow = [[NSDate date] formatWithUTCTimeZone];   // "Yesterday, 10:45 PM"
```

The formatter is configured with defaults that you may or may not like, but you can change any of the options directly on the formatter.  For example, to globally disable relative formatting you could add the following to the `-application:didFinishLaunchingWithOptions:` method of your app delegate:

``` objective-c
[[NSDate formatter] setDoesRelativeDateFormatting:NO];
```

There are also methods to format the date without the time component.  For example:

``` objective-c
NSString *day    = [[NSDate date] formatWithLocalTimeZoneWithoutTime];   // "Today"
NSString *utcday = [[NSDate date] formatWithUTCTimeZoneWithoutTime];     // "Yesterday" (assuming GMT+2 just after midnight)
```

Similarily, you can access the formatter directly to change the formatter properties:

``` objective-c
[[NSDate formatterWithoutTime] setDoesRelativeDateFormatting:NO];
```

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

Blocks are released when the user taps a button.  This means you can reference `self` or `sheet` within your blocks without worrying about retain cycles.  This is on the condition that a `-show` method is called after allocating.

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

Blocks are released when the user taps a button.  This means you can reference `self` or `alert` within your blocks without worrying about retain cycles.  This is on the condition that `-show` is called after allocating.

## RHBarButtonItem

`RHBarButtonItem` is a subclass of `UIBarButtonItem` and adds block handling to the button.  For example:

``` objective-c
self.navigationItem.rightBarButtonItem = [RHBarButtonItem itemWithTitle:@"Edit" block:^{
	// ...
}];
```

Blocks are not released when the user taps the button since it's quite likely the user may tap the button multiple times.  For that reason any reference to `self` within the block must be done with a weak reference.

## RHSwitch

`RHSwitch` is a subclass of `UISwitch` and adds block handling to the switch action.  For example:

``` objective-c
// Instantiate an instance of RHSWitch with an initial "ON" state
RHSwitch *toggle = [[RHSwitch alloc] initWithBlock:^(BOOL state) {
	// do something with the new "state"		
} state:YES];

// You can then add it as a subview (after setting the frame.origin):
[self.view addSubview:toggle];

// ... or use it with a tableView cell
[cell setAccessoryView:toggle];

// You can also use it with a NIB by defining the class as RHClass in Interface Builder and setting the block in viewDidLoad:
[toggle setBlock:^(BOOL state) {
	// do something with the new "state"		
}];
```

`RHSwitch` adds a workaround to prevent the block from being called if the switch is tapped twice in rapid succession.  The block is retained so be sure to only use weak references to `self` or `toggle` within the block.

## RHImagePickerController

*coming soon...*

## RHTapGestureRecognizer

`RHTapGestureRecognizer` is a subclass of `UITapGestureRecognizer` and adds block handling to the gesture.

The block is retained so be sure to only use weak references within the block.

## Contact

profile: [Christopher Meyer](https://github.com/chriscdn)  
e-mail: [chris@schwiiz.org](mailto:chris@schwiiz.org)  
twitter: [@chriscdn](http://twitter.com/chriscdn)

## License
All source available under the MIT license. See the LICENSE file for more info.