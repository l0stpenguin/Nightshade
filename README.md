# Nightshade

------

[NightshadeLite](https://repo.packix.com/package/com.dylanduff.nightshade/) is a system wide open source darkmode for iOS with both free and premium options available, the free stuff being open source here.

### Adding to the Compatability Layer

------

When THEOS compiles nightshade it will compile every .xm file inside of the CompatabilityLayer, by using the NightshadeColors.h file you can access the users active color pallete, and overide the universal UIKit hooks if necesarry.


There are a few partially written already for reference but the basic implementation boils down to as following;

Import the required headers 
```
#import "../NightshadeColors.h"
#import "SparkAppList.h"
```
Check if app is enabled  
```
%ctor {
	NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];

    if(GetPrefBool(@"kTweakEnabled")) {	
		if([SparkAppList doesIdentifier:@"com.dylanduff.nightshadeprefs" andKey:@"whitelistedApps" containBundleIdentifier:bundleIdentifier]){
			if ([bundleIdentifier isEqualToString:@"com.atebits.Tweetie2"]){
			   	%init(Hooks);
			}		
		}
	}

}
```

Run Hooks
```
%group Hooks

	%hook _UIBarBackground
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor cellColor];
			return %orig(arg1); 
		}
	%end

}
%end
```

