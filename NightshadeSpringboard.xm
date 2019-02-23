#import "NightshadeColors.h"
#import "SparkAppList.h"
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <PhotoLibrary/PLStaticWallpaperImageViewController.h>
#import <SpringBoardFoundation/SBFWallpaperParallaxSettings.h>

//Basically all of this needs to be re-written 

@interface NCNotificationShortLookView : UIView
@property(nonatomic, strong) UIImage *icon;
-(void)setBackgroundView:(id)arg1;
-(void)colorLabels:(UIView*)view color:(UIColor *)colorToUse;
-(UIColor *)getAverageColor:(UIImage *)icon transparency:(float)alpha;
@end

@interface MTPlatterHeaderContentView : UIView
@property(assign, nonatomic) CGFloat contentBaseline;
@property(nonatomic, strong) UIImage *icon;
-(void)setBackgroundView:(id)arg1;
-(void)colorLabels:(UIView *)parentView color:(UIColor *)colorToUse;
@end

@interface SBFloatingDockPlatterView : UIView
-(void)setBackgroundView:(id)arg1;
-(void)setFrame:(CGRect)arg1;
@end

@interface SBWallpaperEffectView : UIView
@end

@interface SBDockView : UIView
@property(retain, nonatomic) SBWallpaperEffectView *_backgroundView;
@end

@interface SBIconBlurryBackgroundView : UIView
@end

@interface SBFolderIconBackgroundView : SBIconBlurryBackgroundView
@end

@interface SBFolderBackgroundView : UIView
@end

@interface _MTBackdropView : UIView
@property (nonatomic, strong) UIColor *colorMatrixColor;
@end

@interface MTMaterialView : UIView
@end

@interface _UIBackdropEffectView :UIView
@end

@interface _UIVisualEffectSubview :UIView
@end

@interface WGWidgetPlatterView : UIView
@property(nonatomic, strong) UIImage *icon;
-(void)setBackgroundView:(id)arg1;
-(void)colorLabels:(UIView *)parentView color:(UIColor *)colorToUse;
@end
 
%group SpringBoardHooks

	%hook _UIVisualEffectSubview
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [arg1 colorWithAlphaComponent:0.01f];
			return %orig(arg1); 
		}
	%end

	%hook UILabel
		- (void)setTextColor:(id)newTextColor {
			if(GetPrefBool(@"kNotificationTintEnabled")) {  	
				newTextColor = [UIColor textColor];
			  	return %orig(newTextColor);
			}else{
				%orig;
			}
		}
	%end  
	%hook UITextView
		- (void)setTextColor:(id)newTextColor {
			if(GetPrefBool(@"kNotificationTintEnabled")) {  	
				newTextColor = [UIColor textColor];
			  	return %orig(newTextColor);
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
	%hook UITableViewCell
		-(void)layoutSubviews{
			%orig;
			[self setTintColor:[UIColor accentColor]];
		}

		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor cellColor];
			return %orig(arg1); 
		}
	%end
	%hook _UITableViewCellSeparatorView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor separatorColor];
			return %orig(arg1); 
		}
	%end
	%hook UITableViewCellContentView
		- (void)setBackgroundColor:(id)arg1 {
			arg1 = [UIColor cellColor];
			return %orig(arg1); 
		}

	%end

	// ************************************************
	// ****************** Widgets *********************
	// ************************************************


	%hook WGWidgetPlatterView
	-(void)setIcon:(id)arg1{
	    %orig;

    	const CGFloat width = [UIScreen mainScreen].bounds.size.width;
	    if(GetPrefBool(@"kWidgetTintEnabled")) {
	       
	        UIView *bg=[[UIView alloc]initWithFrame:CGRectMake(0,0,width,1500)];
			UIVisualEffect *blurEffect;

	        if ([[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"kWidgetBlurStyle"] isEqual:@"dark"]){
	        	blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];  
	        }else{
				blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];     
	        }

	        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
	        blurEffectView.frame = bg.bounds;

	        [bg addSubview:blurEffectView];

	        //The color view
	        UIView *colorView =[[UIView alloc]initWithFrame:bg.frame];
	        [colorView setBackgroundColor:[UIColor navColor]];
	        //[colorView setBackgroundColor: [[UIColor navColor] colorWithAlphaComponent:0.4f]];
	        
	        bg.clipsToBounds= YES;

	        [bg addSubview:colorView];
	        [self setBackgroundView:bg];
	        [self colorLabels:(UIView *)self.superview.superview  color:[UIColor textColor]];


	    }
	}
	%new

	- (void)colorLabels:(UIView *)parentView color:(UIColor *)colorToUse{

	    if([parentView isKindOfClass:[objc_getClass("MTMaterialView") class]]){
	      MTMaterialView *bg = (MTMaterialView *)parentView;
	      bg.layer.opacity = 0;
	      return;
	    }

	    if([parentView isKindOfClass:[objc_getClass("UILabel") class]]){
	      	UILabel *label = (UILabel *)parentView;
	      	label.layer.opacity = 0;

	    	return;
	    }

	    for (UIView *subview in parentView.subviews){
	        [self colorLabels:subview color:colorToUse];
	    }

	}
	%end

	// ************************************************
	// ****************** Banners *********************
	// ************************************************


	//iOS 12 stand-in

	%hook NCNotificationOptions
	- (BOOL)prefersDarkAppearance {
		return YES;
	}
	%end

	%hook NCNotificationShortLookView
	-(void)setIcon:(id)arg1{
	    %orig;

	    const CGFloat width = [UIScreen mainScreen].bounds.size.width;
	    if(GetPrefBool(@"kNotificationTintEnabled")) {
	        
	        UIView *bg=[[UIView alloc]initWithFrame:CGRectMake(0,0,width,1500)];
			UIVisualEffect *blurEffect;
			
	        if ([[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"kNotificationBlurStyle"] isEqual:@"dark"]){
	        	blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];  
	        }else{
				blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];     
	        }

	       	UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
	        blurEffectView.frame = bg.bounds;
	        [bg addSubview:blurEffectView];

			UIView *colorView =[[UIView alloc]initWithFrame:bg.frame];
			[colorView setBackgroundColor:[UIColor navColor]];

	        bg.clipsToBounds= YES;	

	        [bg addSubview:colorView];
	        [self setBackgroundView:bg];
	        [self colorLabels:(UIView *)self.superview.superview  color:[UIColor textColor]];

	    }
	}

	%new

	- (void)colorLabels:(UIView *)parentView color:(UIColor *)colorToUse{

	    if([parentView respondsToSelector:@selector(setTextColor:)]){
	      UILabel *labelView = (id)parentView;
	      labelView.textColor = [UIColor textColor];
	    }

	    if([parentView isKindOfClass:[objc_getClass("MTMaterialView") class]]){
	      MTMaterialView *bg = (MTMaterialView *)parentView;
	      bg.layer.opacity = 0;
	      return;
	    }

	    for (UIView *subview in parentView.subviews){
	        [self colorLabels:subview color:[UIColor textColor]];
	    }
	}
	%end

	// ************************************************
	// ****************** Dock ************************
	// ************************************************
	/*
	%hook _SBTintView
		-(void)setBackgroundColor:(id)arg1 {
			if(GetPrefBool(@"kDockBackgroundEnabled")) {	
				arg1 = [UIColor backgroundColor];
				return %orig(arg1); 
			}else{
				%orig;
			}
		}

	%end
	*/

	// ************************************************
	// ****************** Folders **********************
	// ************************************************

	%hook SBFolderIconBackgroundView

	- (void)setWallpaperBackgroundRect:(CGRect)rect forContents:(CGImageRef)contents withFallbackColor:(CGColorRef)fallbackColor {
		if(GetPrefBool(@"kFolderBackgroundEnabled")) {
	    	//self.backgroundColor = [UIColor navColor];
	    	UIColor *color = [UIColor navColor];
	    	[color colorWithAlphaComponent:0.8f];
			[self setBackgroundColor:color];
		}else{
			%orig;
		}

	}

	%end
	
	%hook SBFolderBackgroundView

	- (void)layoutSubviews {
		%orig;
		if(GetPrefBool(@"kFolderBackgroundEnabled")) {
		    UIView *tintView = [self valueForKey:@"_tintView"];
		    tintView.backgroundColor = [UIColor navColor];
		}
	}

	%end

%end


%end

%ctor {

	NSString *bundle = [[NSBundle mainBundle] bundleIdentifier];

	if(GetPrefBool(@"kTweakEnabled")) {	
	    if ([bundle isEqualToString:@"com.apple.springboard"]){
	    		%init(SpringBoardHooks);
		}
	}

	// ************************************************
	// ****************** Wallpapers ******************
	// ************************************************	
	/*
	if(GetPrefBool(@"kScheduledWallsEnabled")) {
		PLWallpaperMode wallpaperMode = PLWallpaperModeLockScreen;
		
		if(GetPrefBool(@"kTweakEnabled")){
			NSString *imagePath = @"/Library/PreferenceBundles/NightshadePrefs.bundle/night.JPG";
			UIImage *wallImage = [UIImage imageWithContentsOfFile:imagePath];	

			PLStaticWallpaperImageViewController *wallpaperViewController = [[PLStaticWallpaperImageViewController alloc] initWithUIImage:wallImage];
			wallpaperViewController.saveWallpaperData = YES;
		    
		    uintptr_t address = (uintptr_t)&wallpaperMode;
		    object_setInstanceVariable(wallpaperViewController, "_wallpaperMode", *(PLWallpaperMode **)address);
		    
		    [wallpaperViewController _savePhoto];	
		}else{
			NSString *imagePath = @"/Library/PreferenceBundles/NightshadePrefs.bundle/day.JPG";
			UIImage *wallImage = [UIImage imageWithContentsOfFile:imagePath];		

			PLStaticWallpaperImageViewController *wallpaperViewController = [[PLStaticWallpaperImageViewController alloc] initWithUIImage:wallImage];
			wallpaperViewController.saveWallpaperData = YES;
		    
		    uintptr_t address = (uintptr_t)&wallpaperMode;
		    object_setInstanceVariable(wallpaperViewController, "_wallpaperMode", *(PLWallpaperMode **)address);
		    
		    [wallpaperViewController _savePhoto];			
		}

	}
	*/

}

