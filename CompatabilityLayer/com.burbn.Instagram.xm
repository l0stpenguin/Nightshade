#import "../NightshadeColors.h"
#import "SparkAppList.h"

%group InstagramHooks

	%hook IGFeedItemHeader
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1);
		}
	%end

	%hook IGTabBar
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor cellColor];
			return %orig(arg1);
		}
	%end

	%hook IGMainAppHeaderView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor navColor];
			return %orig(arg1);
		}
	%end

	%hook IGProfileAvatarStatsView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1);
		}
	%end

	%hook IGProfileBioView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1);
		}
	%end

	%hook IGLabelSupplementaryView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1);
		}
	%end	

	%hook UIView
		- (void)setBackgroundColor:(id)arg1 {
			if([arg1 isEqual:[UIColor whiteColor]]) {
			    arg1 = [UIColor backgroundColor];
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
    	if ([bundle isEqualToString:@"com.burbn.instagram"]){
    		%init(InstagramHooks);
		}
    }

}