#import "../NightshadeColors.h"
#import "SparkAppList.h"
 
%group Hooks

	%hook UITableView
		- (void)setBackgroundColor:(id)arg1 {
			return %orig; 
		}
	%end

	%hook _UIBarBackground
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor cellColor];
			return %orig(arg1); 
		}
	%end

	%hook T1StatusCell
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook T1ModuleFooterView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor cellColor];
			return %orig(arg1); 
		}
	%end

	%hook TFNHorizontalLabelCollectionView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor cellColor];
			return %orig(arg1); 
		}
	%end

	%hook T1BadgedTextCell
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook T1ActivityCell
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook T1DirectMessageInboxSummaryView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook T1TweetDetailsTweetComposerViewCell
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook TFNTableView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor cellColor];
			return %orig(arg1); 
		}
	%end

	%hook T1TabView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor cellColor];
			return %orig(arg1); 
		}

	%end

	%hook T1UserView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook T1TweetDetailsFooterItemCell
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook T1TweetDetailsRichTextCell
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook T1TweetDetailsActivityCell
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook T1PersistentComposeView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor cellColor];
			return %orig(arg1); 
		}
	%end

	%hook T1SocialProofCell
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook T1QuotedStatusCell
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook T1NativeVideoCell
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook T1MultiPhotoPreviewCell
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook T1ProfileUserInfoView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook T1SuggestsModuleHeaderView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook T1ProfileActionButtonsView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook TFNButtonBarView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor cellColor];
			return %orig(arg1); 
		}
	%end

	%hook UIView
		- (void)setBackgroundColor:(id)arg1 {
			if(arg1 == nil) {
				%orig;
			}else{
				if(![arg1 isEqual:[UIColor clearColor]]) {
					if(![arg1 isEqual:[UIColor cellColor]]) {
					    arg1 = [UIColor backgroundColor];
						return %orig(arg1); 
					}else{
						%orig;
					}
				}else{
					%orig;
				}
			}
		}
	%end
%end

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