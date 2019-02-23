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