#import "../NightshadeColors.h"
#import "SparkAppList.h"
 
@interface _UIWebViewScrollView
@property (nonatomic, copy, readwrite) UIColor *backgroundColor;
@end

@interface _UIVisualEffectFilterView
@property (nonatomic, copy, readwrite) UIColor *backgroundColor;
@end

@interface CyteTableViewCellContentView
@property (nonatomic, copy, readwrite) UIColor *backgroundColor;
@end

@interface UITableViewIndex
@property (nonatomic, copy, readwrite) UIColor *indexBackgroundColor;
@end

@interface SourceCell
@property (nonatomic, copy, readwrite) UIColor *backgroundColor;
@end

@interface _UITableViewCellSeparatorView
@property (nonatomic, copy, readwrite) UIColor *backgroundColor;
@end


%group Hooks

	%hook SourcesController
	- (void)viewDidLoad {
		%orig;
		if(DarkModeEnabled == YES) {
			UITableView *tableView = MSHookIvar<UITableView *>(self, "list_");
			tableView.backgroundColor = [UIColor backgroundColor];
		}

	}
	%end

	%hook SourceCell
	- (void) layoutSubviews {
		%orig;
		if(DarkModeEnabled == YES) {
			self.backgroundColor = [UIColor cellColor];
		}
	}
	%end

	%hook _UITableViewCellSeparatorView
	- (void) layoutSubviews {
		%orig;
		if(DarkModeEnabled == YES) {
			self.backgroundColor = [UIColor seperatorColor];
		}
	}
	%end

	%hook ChangesController
	- (void)viewDidLoad {
		%orig;
		if(DarkModeEnabled == YES) {
			UITableView *tableView = MSHookIvar<UITableView *>(self, "list_");
			tableView.backgroundColor = darkModeColor;

			CyteTableViewCellContentView *cyteCell = MSHookIvar<CyteTableViewCellContentView *>(self, "list_");
			cyteCell.backgroundColor = [UIColor backgroundColor];

		}
	}
	%end

	%hook CyteTableViewCellContentView
	- (void) setFrame:(CGRect)frame {
		%orig;
		if(DarkModeEnabled == YES) {
			self.backgroundColor = [UIColor backgroundColor];
		}
	}
	%end

	%hook UITableViewIndex
	- (void) layoutSubviews {
		%orig;
		if(DarkModeEnabled == YES) {
			self.indexBackgroundColor = [UIColor backgroundColor];
		}
	}
	%end

	%hook InstalledController
	- (void)viewDidLoad {
		%orig;
		if(DarkModeEnabled == YES) {
			UITableView *tableView = MSHookIvar<UITableView *>(self, "list_");
			tableView.backgroundColor = [UIColor backgroundColor];
		}
	}
	%end

	%hook SearchController
	- (void)viewDidLoad {
		%orig;
		if(DarkModeEnabled == YES) {
			UITableView *tableView = MSHookIvar<UITableView *>(self, "list_");
			tableView.backgroundColor = [UIColor backgroundColor];
		}
	}
	%end

	%hook _UIWebViewScrollView
	- (void) layoutSubviews {
		%orig;	
			self.backgroundColor = [UIColor backgroundColor];

	}
	%end

	%hook Cydia
	- (void)applicationDidFinishLaunching:(UIApplication *)application {
		%orig;
		if(DarkModeEnabled == YES) {
			[UINavigationBar appearance].barTintColor = [UIColor accentColor];
			[UISearchBar appearance].barTintColor = [UIColor accentColor];
			[UITabBar appearance].barTintColor = [UIColor accentColor];
		}
	}
	%end

	%hook _UIVisualEffectSubview
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor navColor];
			return %orig(arg1); 
		}
	%end

	%hook _UIBarBackground
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor navColor];
			return %orig(arg1); 
		}
	%end	

%end

%ctor {
	NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];

    if(GetPrefBool(@"kTweakEnabled")) {	
		if([SparkAppList doesIdentifier:@"com.dylanduff.nightshadeprefs" andKey:@"whitelistedApps" containBundleIdentifier:bundleIdentifier]){
			if ([bundleIdentifier isEqualToString:@"com.saurik.Cydia"]){
			   	%init(Hooks);
			}		
		}
	}

}