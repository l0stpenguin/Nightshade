#import "../NightshadeColors.h"
#import "SparkAppList.h"

%group SlackHooks

	%hook SMUMessageCellView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook UILabel
		- (void)setTextColor:(id)arg1 {
			arg1 = [UIColor textColor];
			return %orig(arg1);
		}
	%end

	%hook _UIBarBackground
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor cellColor];
			return %orig(arg1); 
		}
	%end

	%hook UIView
		- (void)setBackgroundColor:(id)arg1 {
			if([arg1 isEqual:[UIColor whiteColor]]) {
			    arg1 = [UIColor cellColor];
				return %orig(arg1); 
			}else{
				%orig;
			}
		}
	%end

%end

%ctor {
	NSString *bundle = [[NSBundle mainBundle] bundleIdentifier];

	if([SparkAppList doesIdentifier:@"com.dylanduff.nightshadeprefs" andKey:@"whitelistedApps" containBundleIdentifier:bundle]){
    	if ([bundle isEqualToString:@"com.tinyspeck.chatlyio"]){
    		%init(SlackHooks);
		}
    }

}