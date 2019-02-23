#import "NightshadeColors.h"
#import "SparkAppList.h"

@interface CNContactListViewCell
@property (nonatomic, copy, readwrite) UIView *view;
@end

@interface CKNavigationBarCanvasView
@property (retain, nonatomic)UIView *titleView;
@end
 
@interface _UINavigationBarLargeTitleView
@property (retain, nonatomic)UILabel *accessibilityTitleView;
@end

%group PhoneHooks

	%hook PHHandsetDialerView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook PHBottomBarButton
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor accentColor];
			return %orig(arg1); 
		}
	%end

	%hook CNContactHeaderDisplayView
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

%group MusicHooks

	%hook _UIBarBackground
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor cellColor];
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

%group SettingsHooks

	%hook WFAssociationStateView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor clearColor];
			return %orig(arg1); 
		}
	%end

	CGFloat inset = 16.0;
	CGFloat radius  = 5;

	%hook UITableView

	- (UIEdgeInsets)_sectionContentInset{
		if(GetPrefBool(@"kRoundedCornersEnabled")) {	
			UIEdgeInsets orig = %orig;
			if ((orig.left > 0 || orig.right > 0)){
				return orig;
			}
			return UIEdgeInsetsMake(orig.top, inset, orig.bottom, inset);
		}else{
			return %orig;
		}

	}

	- (void)_setSectionContentInset:(UIEdgeInsets)insets{
		if(GetPrefBool(@"kRoundedCornersEnabled")) {	
			%orig(UIEdgeInsetsMake(insets.top, inset, insets.bottom, inset));
		}else{
			return %orig;
		}
	}

	%end

	%hook UIGroupTableViewCellBackground

	- (UIBezierPath *)_roundedRectBezierPathInRect:(CGRect)rect withSectionLocation:(int)location forBorder:(BOOL)border cornerRadiusAdjustment:(CGFloat)cornerRadius{
		if(GetPrefBool(@"kRoundedCornersEnabled")) {	
			cornerRadius = radius - 2.5;
			return %orig(rect, location, border, cornerRadius);
		}else{
			return %orig;
		}
	}

	%end


%end

%group iTunesHooks

	%hook SKUISectionHeaderColectionViewCell
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook SKUIPageDividerColectionViewCell
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook SKUIButtonColectionViewCell
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook SKUIAccountButtonsView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

	%hook SKUIItemOfferButton
		- (void)setTintColor:(id)arg1 {
			arg1 = [UIColor accentColor];
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

	%hook SKUIAttributedStringView
		- (id)textColor{
			return [UIColor textColor]; 
		}
	%end
%end

%group PhotosHooks
	%hook PXRoundedCornerOverlayView
		-(id)overlayColor{
			return [UIColor backgroundColor];
		}
	%end
%end

%group ContactsHooks
	%hook CNContactHeaderDisplayView
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

%group CydiaHooks
	%hook CyteTableViewCellContentView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor cellColor];
			return %orig(arg1); 
		}
	%end
%end


%group NotesHooks
	%hook UILabel
		- (void)setTextColor:(id)arg1 {
			arg1 = [UIColor textColor];
			return %orig(arg1); 
		}
	%end
	%hook UISearchBar
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end	
	%hook NotesTextureView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end
	%hook ICNotesListTableViewCellWithImageView
		- (void)setBackgroundColor:(id)arg1 {	
				arg1 = [UIColor backgroundColor];
				return %orig(arg1); 
		}

	%end
	%hook _UINavigationBarLargeTitleView
		-(void)layoutSubviews{
			%orig;
			self.accessibilityTitleView.textColor = [UIColor textColor]; 
		}
	%end
	%hook UINavigationBar
		-(void)layoutSubviews{
			%orig;
			[self setTintColor:[UIColor accentColor]];
		}
	%end	
%end

%group MessageHooks
	%hook CKNavigationBarCanvasView
		-(void)layoutSubviews{
			%orig;
			self.titleView.backgroundColor = [UIColor clearColor]; 
		}
	%end
	%hook UICollectionView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor clearColor];
			return %orig(arg1); 
		}
	%end
	%hook CKGradientReferenceView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end
	%hook CKBrowserSwitcherFooterView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor cellColor];
			return %orig(arg1); 
		}
	%end	
	%hook UIView
		- (void)setBackgroundColor:(id)arg1 {
			if([arg1 isEqual:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8]]) {
			    arg1 = [UIColor navColor];
				return %orig(arg1); 
			}else{
				%orig;
			}
		}
	%end
%end

%group MapsHooks
	%hook _MKUILabel
		- (void)setTextColor:(id)arg1 {
			arg1 = [UIColor textColor];
			return %orig(arg1); 
		}
	%end

	%hook BlurredStatusBar
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor navColor];
			return %orig(arg1); 
		}
	%end

%end

%group FilesHooks

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

%group AppStoreHooks

	%hook UIView
		- (void)setBackgroundColor:(id)arg1 {
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
	%end

%end

%group TVHooks

	%hook _TVLabel
		- (void)setTextColor:(id)arg1 {
			arg1 = [UIColor textColor];
			return %orig(arg1); 
		}
	%end

%end

%group FilzaHooks

	%hook BottomBar
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor cellColor];
			return %orig(arg1); 
		}
	%end

%end

%group WalletHooks

	%hook PKPassGroupStackView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end

%end

%group NewsHooks

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

%group MailHooks

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

%group CalendarHooks
	%hook CompactYearViewYearHeader
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end
	%hook CompactYearMonthView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor backgroundColor];
			return %orig(arg1); 
		}
	%end
	%hook UIScrollView
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

	if(GetPrefBool(@"kTweakEnabled")) {	
	    if([SparkAppList doesIdentifier:@"com.dylanduff.nightshadeprefs" andKey:@"whitelistedApps" containBundleIdentifier:bundle]){
	    	if ([bundle isEqualToString:@"com.apple.mobilephone"]){
	    		%init(PhoneHooks);
	    	}else if([bundle isEqualToString:@"com.apple.Music"]){
				%init(MusicHooks);
			}else if([bundle isEqualToString:@"com.apple.Preferences"]){
				%init(SettingsHooks);
			}else if([bundle isEqualToString:@"com.apple.MobileStore"]){
				%init(iTunesHooks);
			}else if([bundle isEqualToString:@"com.apple.mobileslideshow"]){
				%init(PhotosHooks);
			}else if([bundle isEqualToString:@"com.apple.MobileAddressBook"]){
				%init(ContactsHooks);
			}else if([bundle isEqualToString:@"com.apple.MobileSMS"]){
				%init(MessageHooks);
			}else if([bundle isEqualToString:@"com.apple.Maps"]){
				%init(MapsHooks);
			}else if([bundle isEqualToString:@"com.apple.mobilecal"]){
				%init(CalendarHooks);
			}else if([bundle isEqualToString:@"com.apple.DocumentsApp"]){
				%init(FilesHooks);
			}else if([bundle isEqualToString:@"com.apple.AppStore"]){
				%init(AppStoreHooks);
			}else if([bundle isEqualToString:@"com.apple.tv"]){
				%init(TVHooks);
			}else if([bundle isEqualToString:@"com.apple.Passbook"]){
				%init(WalletHooks);
			}else if([bundle isEqualToString:@"com.apple.news"]){
				%init(NewsHooks);
			}else if([bundle isEqualToString:@"com.apple.mobilemail"]){
				%init(MailHooks);
			}else if([bundle isEqualToString:@"com.saurik.Cydia"]){
				%init(CydiaHooks);
			}else if([bundle isEqualToString:@"com.tigisoftware.Filza"]){
				%init(FilzaHooks);
			}else if([bundle isEqualToString:@"com.apple.mobilenotes"]){
				%init(NotesHooks);
			}  
	    }
	}



}