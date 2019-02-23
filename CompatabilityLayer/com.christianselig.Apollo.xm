#import "../NightshadeColors.h"
#import "SparkAppList.h"

%group Hooks

	%hook _ASDisplayView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

%end



%ctor {
	NSString *bundle = [[NSBundle mainBundle] bundleIdentifier];

	if([SparkAppList doesIdentifier:@"com.dylanduff.nightshadeprefs" andKey:@"whitelistedApps" containBundleIdentifier:bundle]){
    	if ([bundle isEqualToString:@"com.christianselig.Apollo"]){
    		%init(Hooks);
		}
    }

}