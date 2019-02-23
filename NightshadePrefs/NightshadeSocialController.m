#include "NightshadeSocialController.h"
#include <CSColorPicker/CSColorPicker.h>

#define PLIST_PATH @"/User/Library/Preferences/com.dylanduff.nightshadeprefs.plist"

@implementation NightshadeSocialController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"NightshadeSocialSettings" target:self] retain];
	}
	return _specifiers;
}

- (void)viewDidLoad{

   	[super viewDidLoad];

      UIWebView *nightshadeView;
      CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
      CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;

   	nightshadeView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 60)];
      nightshadeView.delegate = self;

   	NSString *kBackgroundColor = [[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"kBackgroundColor"];
   	NSString *kCellColor = [[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"kCellColor"];
   	NSString *kTextColor = [[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"kTextColor"];
   	NSString *kAccentColor = [[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"kAccentColor"];
   	NSString *kNavColor = [[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"kNavColor"];
   	NSString *kSeperatorColor = [[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"kSeperatorColor"];
   	
      NSString *url= [NSString stringWithFormat:@"http://dylanduff.com/projects/NightshadeSocial/?kBackgroundColor=%@&kCellColor=%@&kTextColor=%@&kAccentColor=%@&kNavColor=%@&kSeperatorColor=%@", kBackgroundColor, kCellColor, kTextColor, kAccentColor, kNavColor, kSeperatorColor];
   	NSURL *nsurl=[NSURL URLWithString:url];
   	NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
   	[nightshadeView setBackgroundColor:[UIColor clearColor]];
      [nightshadeView setOpaque:NO];
      [nightshadeView loadRequest:nsrequest]; 
      [self.table addSubview:nightshadeView];
	
}

- (void)webViewDidFinishLoad:(UIWebView *)nightshadeView{

   NSString *urlExtension = nightshadeView.request.URL.absoluteString.pathExtension;

   if ([urlExtension isEqualToString:@"plist"]){
      NSData *urlData = [NSData dataWithContentsOfURL:nightshadeView.request.URL];
      [nightshadeView goBack];

      if (urlData){
         NSString  *themeDirectory = @"/Library/Application Support/Nightshade/Themes";  
         NSString *filePath = [themeDirectory stringByAppendingPathComponent:@"test.plist"];

         NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:nightshadeView.request.URL.absoluteString]];
         [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (data){
               [data writeToFile:filePath atomically:YES];
               
               UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Downloaded"
                  message:nil
                  preferredStyle:UIAlertControllerStyleAlert];
             
               UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                  handler:^(UIAlertAction * action) {}];
                
               [alert addAction:defaultAction];
               [self presentViewController:alert animated:YES completion:nil];
            }
         }];

      }
   }
   
}

@end



