#import "NightshadeColors.h"
#import "SparkAppList.h"
 
@interface UITableViewCellContentView
@end

@interface _UINavigationBarLargeTitleView
@property (retain, nonatomic)UILabel *accessibilityTitleView;
@end

@interface UIInterfaceActionGroupView : UIView
@end

@interface PSEditableTableCell : UIView
@end

@interface _UIAlertControllerInterfaceActionGroupView : UIInterfaceActionGroupView
@end

@interface _UIAlertControlleriOSActionSheetCancelBackgroundView : UIView
@end

%group Hooks

	%hook UITableView
		- (void)setBackgroundColor:(id)arg1 {
			if(arg1 == nil){
				%orig;
			}else{
				arg1 = [UIColor backgroundColor];
				return %orig(arg1); 
			}
		}

		- (void)setTextColor:(id)newTextColor {
			newTextColor = [UIColor textColor];
			return %orig(newTextColor); 
		}

	%end

	%hook UILabel
		- (void)setTextColor:(id)newTextColor {
			if (newTextColor == [UIColor colorWithRed:0.0f green:0.22f blue:122.0/255.0 alpha:1.0f]){
				newTextColor = [UIColor accentColor];
				return %orig(newTextColor);
			}else{
				newTextColor = [UIColor textColor];
				return %orig(newTextColor);
			}
 
		}
	%end

	%hook UITextField
		- (void)setTextColor:(id)newTextColor {
			newTextColor = [UIColor textColor];
			return %orig(newTextColor); 
		}
	%end

	%hook UIButtonLabel
		- (void)setTextColor:(id)arg1 {
			arg1 = [UIColor accentColor];
			return %orig(arg1); 
		}
	%end

	%hook UILayoutContainerView
		- (void)setBackgroundColor:(id)arg1 {
			if([arg1 isEqual:[UIColor whiteColor]]) {
			    arg1 = [UIColor backgroundColor];
				return %orig(arg1); 
			}else{
				%orig;
			}
		}
	%end

	%hook UIButton
		-(void)layoutSubviews{
			%orig;
			[self setTintColor:[UIColor accentColor]];
		}
	%end

	%hook UISegmentedControl
		-(void)layoutSubviews{
			%orig;
			[self setTintColor:[UIColor accentColor]];
		}
	%end

	%hook UISwitch
		-(void)layoutSubviews{
			%orig;
			[self setOnTintColor:[UIColor accentColor]];
		}
	%end

	%hook UITableViewCell
		-(void)layoutSubviews{
			%orig;
			//[self setTintColor:[UIColor accentColor]];
			MSHookIvar<UIColor*>(self, "_selectionTintColor") = [UIColor cellColor];

		}

		- (void)setBackgroundColor:(id)arg1 {
			if(arg1 == nil){
				%orig;
			}else{
				arg1 = [UIColor cellColor];
				return %orig(arg1); 
			}
		}

	%end

	%hook UITableViewCellContentView
		- (void)setBackgroundColor:(id)arg1 {
			if(arg1 == nil){
				%orig;
			}else{
				arg1 = [UIColor cellColor];
				return %orig(arg1); 
			}
		}

	%end

	%hook _UITableViewHeaderFooterViewBackground
		- (void)setBackgroundColor:(id)arg1 {
			if(arg1 == nil){
				%orig;
			}else{
				arg1 = [UIColor cellColor];
				return %orig(arg1); 
			}
		}
	%end

	%hook _UITableViewHeaderFooterViewLabel
		- (void)setTextColor:(id)arg1 {
			arg1 = [UIColor textColor];
			return %orig(arg1); 
		}
	%end

	%hook UITableViewLabel
		- (void)setTextColor:(id)arg1 {
			arg1 = [UIColor textColor];
			return %orig(arg1); 
		}
	%end

	%hook _UITableViewCellSeparatorView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor separatorColor];
			return %orig(arg1); 
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

	%hook _UINavigationBarContentView
		-(void)setTextColor:(id)arg1 {
			arg1 = [UIColor textColor];
			return %orig(arg1); 
		}
	%end

	%hook UINavigationBar
		-(void)layoutSubviews{
			%orig;
			[self setTintColor:[UIColor accentColor]];
		}
	%end

	%hook _UINavigationBarLargeTitleView
		-(void)layoutSubviews{
			%orig;
			self.accessibilityTitleView.textColor = [UIColor textColor]; 
		}
	%end

	%hook UITabBar
		-(void)layoutSubviews{
			%orig;
			[self setTintColor:[UIColor accentColor]];
		}

		- (void)setTextColor:(id)arg1 {
			arg1 = [UIColor textColor];
			return %orig(arg1); 
		}
	%end

	%hook UICollectionView
		- (void)setBackgroundColor:(id)arg1 {
			if(arg1 == nil){
				%orig;
			}else{
				arg1 = [UIColor backgroundColor];
				return %orig(arg1); 
			}
		}
	%end

	%hook CKLabel
		- (void)setTextColor:(id)arg1 {
			arg1 = [UIColor textColor];
			return %orig(arg1); 
		}
	%end

	%hook SKUISectionHeaderView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook SKUIAttributedStringView
		- (void)setTextColor:(id)arg1 {
			arg1 = [UIColor textColor];
			return %orig(arg1); 
		}
	%end

	//Statusbar Coloring
	%hook UIStatusBarStyleRequest
		-(UIColor *)foregroundColor{
			if (GetPrefBool(@"kStatusbarEnabled")){
				return([UIColor accentColor]);	
			}else{
				return %orig;
			}
		}
	%end

	%hook PSEditableTableCell
		-(UITextField *)_editableTextField {
		        UITextField* field = %orig;
		        field.textColor = [UIColor textColor];
		        return field;
		}
		-(void)didMoveToWindow{
		  %orig;
		  MSHookIvar<UITextField*>(self, "_editableTextField").textColor = [UIColor textColor];
		}
	%end

	//Alerts
	%hook _UIAlertControllerInterfaceActionGroupView

	- (void)layoutSubviews {
	    %orig;
	    
	    if(GetPrefBool(@"kAlertsEnabled")) {
		    UIView *filterView = self.subviews.firstObject.subviews.lastObject.subviews.lastObject;
		    filterView.backgroundColor = [UIColor navColor];
		    
		    UIView *labelHolder = self.subviews.lastObject.subviews.firstObject.subviews.firstObject;
		    for (UILabel *label in labelHolder.subviews) {
		        if ([label respondsToSelector:@selector(setTextColor:)]) {
		            label.textColor = UIColor.whiteColor;
		        }
		    }
		}
	}

	%end

	%hook _UIAlertControlleriOSActionSheetCancelBackgroundView

	- (void)layoutSubviews {
	    %orig;
	    
	    if(GetPrefBool(@"kAlertsEnabled")) {
		    UIView *knockoutView = self.subviews[1];
		    UIView *filterView = knockoutView.subviews.lastObject.subviews.lastObject;
		    UIView *whiteView = self.subviews.firstObject;
		    
		    filterView.backgroundColor = [UIColor navColor];
		    whiteView.backgroundColor = [UIColor navColor];
		}
	}

	%end	

	// ************************************************
	// ****************** Keyboard ********************
	// ************************************************


	// Dark keyboard
	%hook UIKBRenderConfig

	- (BOOL)lightKeyboard {
		BOOL light = %orig;
		if(GetPrefBool(@"kTweakEnabled") && GetPrefBool(@"kKeyboardEnabled")) {	
			light = NO;
		}
		return light;
	}

	%end

	// Dark PIN keypad
	%hook DevicePINKeypad

	- (id)initWithFrame:(CGRect)frame {
		id keypad = %orig();
		if(GetPrefBool(@"kTweakEnabled") && GetPrefBool(@"kKeyboardEnabled")) {	
			[keypad setBackgroundColor:[UIColor colorWithWhite:40.0/255 alpha:0.7]];
		}
		return keypad;
	}

	%end

%end

%ctor {
	NSString* bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];    

	NSArray<NSString *> *blacklistedApps = @[       
		@"com.atebits.Tweetie2",  
		@"com.tinyspeck.chatlyio",  
		@"com.facebook.Messenger",  
		@"com.christianselig.Apollo",   
		@"com.apple.mobilenotes",   
	    @"com.facebook.Facebook", 
	    @"com.saurik.cydia", 
	    @"com.apple.mobilesafari"           
	];
	
	if(GetPrefBool(@"kTweakEnabled")) {	
		if (![blacklistedApps containsObject:bundleIdentifier]){
			if([SparkAppList doesIdentifier:@"com.dylanduff.nightshadeprefs" andKey:@"whitelistedApps" containBundleIdentifier:bundleIdentifier]){
				%init(Hooks);  
			}			
		}
	}

}