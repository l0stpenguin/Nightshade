#include "NightshadeScheduleController.h"
#import "SparkAppListTableViewController.h"


@implementation NightshadeScheduleController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"NightshadeScheduleSettings" target:self] retain];
	}

	return _specifiers;
}

- (void)viewDidLoad{

    [super viewDidLoad];

    // Add navbar icons

    UIImage *titleImage = [[UIImage alloc]
    initWithContentsOfFile:[[NSBundle bundleWithPath:@"/Library/PreferenceBundles/NightshadePrefs.bundle"] pathForResource:@"icon" ofType:@"png"]];

    UIImage *twitterImage = [[UIImage alloc]
    initWithContentsOfFile:[[NSBundle bundleWithPath:@"/Library/PreferenceBundles/NightshadePrefs.bundle"] pathForResource:@"twitter" ofType:@"png"]];
    twitterImage = [twitterImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

	self.navigationItem.titleView = [[UIImageView alloc] initWithImage:titleImage];

	UIBarButtonItem *birdButton = [[UIBarButtonItem alloc] initWithImage:twitterImage style:UIBarButtonItemStylePlain target:self action:@selector(openTwitter)];
	[self.navigationItem setRightBarButtonItem:birdButton];
	
}

// Tint navbar
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.61 green:0.35 blue:0.71 alpha:1.0];
}
- (void)viewWillDisappear:(BOOL)animated {
	self.navigationController.navigationController.navigationBar.tintColor = nil;
	[super viewWillDisappear:animated];
}

//Wallpapers

- (void)pickNightWall{
	UIImagePickerController *nightImagePicker = [[UIImagePickerController alloc]init];
	    nightImagePicker.delegate = self;
	    nightImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	    [self presentViewController:nightImagePicker animated:NO completion:nil];
}

- (void)pickDayWall{
	UIImagePickerController *dayImagePicker = [[UIImagePickerController alloc]init];
	    dayImagePicker.delegate = self;
	    dayImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	    [self presentViewController:dayImagePicker animated:NO completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)dayImagePicker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [dayImagePicker dismissViewControllerAnimated:YES completion:nil];
}

// Twitter Link
- (void)openTwitter {
	NSURL *url;
	
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]]) {
		url = [NSURL URLWithString:@"tweetbot:///user_profile/dylanduff3"];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]]) {
		url = [NSURL URLWithString:@"twitterrific:///profile?screen_name=dylanduff3"];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]]) {
		url = [NSURL URLWithString:@"tweetings:///user?screen_name=dylanduff3"];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]]) {
		url = [NSURL URLWithString:@"twitter://user?screen_name=dylanduff3"];
	} else {
		url = [NSURL URLWithString:@"http://twitter.com/dylanduff3"];
	}
		
	// [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
	[[UIApplication sharedApplication] openURL:url];
}

@end
