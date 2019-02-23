#import "../NightshadeColors.h"
#import "SparkAppList.h"

@interface FBRichTextLayer : UIView
@end

%group FacebookHooks

	%hook UITableView
		- (void)setBackgroundColor:(id)arg1 {
			return %orig; 
		}
	%end

	%hook FBTabBar
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor navColor];
			return %orig(arg1);
		}
	%end

	%hook UILabel
		- (void)setTextColor:(id)arg1 {
			arg1 = [UIColor textColor];
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

	%hook FBRichTextComponentView
		- (void)setForegroundColor:(id)arg1 {
			arg1 = [UIColor textColor];
			return %orig(arg1); 
		}
	%end

%end

%group MessengerHooks

	%hook MNLoadingView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook _UIVisualEffectSubview
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor navColor];
			return %orig(arg1); 
		}
	%end

	%hook UITabBarButton
		- (void)setTintColor:(id)arg1 {
			arg1 = [UIColor accentColor];
			return %orig(arg1); 
		}
	%end

	%hook FBWebRTCCallCell
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook FBRichTextLayer
		- (void)layoutSubviews {
			%orig;
			//self.layer.fillColor = [UIColor textColor].CGColor;
			self.layer.backgroundColor = [[UIColor textColor] CGColor];
		}
	%end

	%hook UIView
		- (void)setBackgroundColor:(id)arg1 {
			if([arg1 isEqual:[UIColor whiteColor]]) {
				arg1 = [UIColor backgroundColor];
				return %orig(arg1); 
			}else if([arg1 isEqual:[UIColor colorWithRed:0.800/255.0 green:0.816/255.0 blue:0.835/255.0 alpha:1]]){
				arg1 = [UIColor backgroundColor];
				return %orig(arg1); 
			}else{
				%orig;
			}
		}
	%end

	%hook UITableView
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

%end

%ctor {
	NSString *bundle = [[NSBundle mainBundle] bundleIdentifier];

	if([SparkAppList doesIdentifier:@"com.dylanduff.nightshadeprefs" andKey:@"whitelistedApps" containBundleIdentifier:bundle]){
    	if ([bundle isEqualToString:@"com.facebook.Facebook"]){
    		%init(FacebookHooks);
		}else if([bundle isEqualToString:@"com.facebook.Messenger"]){
			%init(MessengerHooks);
		}
    }

}