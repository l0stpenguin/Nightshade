#include <CSColorPicker/CSColorPicker.h>

#define PLIST_PATH @"/User/Library/Preferences/com.dylanduff.nightshadeprefs.plist"
#define THEME_PATH @"/User/Library/Nightshade/Themes/"
#define DEFAULTS_PATH @"/Library/PreferenceBundles/NightshadePrefs.bundle/defaults.plist"

inline bool GetPrefBool(NSString *key){
	return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}

inline NSString *GetPrefVal(NSString *key){
	return [[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key];
}
 
inline NSString *GetHexStringForPrefernceKey(NSString *key) {
	if(GetPrefVal(@"kTheme")){
		if([GetPrefVal(@"kTheme")isEqualToString:@"None"]){
			NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] ? : [NSDictionary new];
			return prefs[key];
		}else{
			NSString *FINAL_THEME_PATH = [THEME_PATH stringByAppendingString:[GetPrefVal(@"kTheme") stringByAppendingString:@".plist"]];
			NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:FINAL_THEME_PATH] ? : [NSDictionary new];
			return prefs[key];
		}	
	}else if(GetPrefVal(@"kBackgroundColor")){
		NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] ? : [NSDictionary new];
		return prefs[key];	
	}else{
		NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:DEFAULTS_PATH] ? : [NSDictionary new];
		return prefs[key];			
	}
} 

@implementation UIColor (Extensions)

+ (UIColor *)backgroundColor {return [UIColor colorFromHexString:GetHexStringForPrefernceKey(@"kBackgroundColor")];}
+ (UIColor *)cellColor {return [UIColor colorFromHexString:GetHexStringForPrefernceKey(@"kCellColor")];}
+ (UIColor *)textColor {return  [UIColor colorFromHexString:GetHexStringForPrefernceKey(@"kTextColor")];}
+ (UIColor *)navColor {return [UIColor colorFromHexString:GetHexStringForPrefernceKey(@"kNavColor")];}
+ (UIColor *)separatorColor{return [UIColor colorFromHexString:GetHexStringForPrefernceKey(@"kSeperatorColor")];}
+ (UIColor *)accentColor{return [UIColor colorFromHexString:GetHexStringForPrefernceKey(@"kAccentColor")];}

@end

