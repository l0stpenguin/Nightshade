#include "NightshadeThemeController.h"
#include <CSColorPicker/CSColorPicker.h>

#define PLIST_PATH @"/User/Library/Preferences/com.dylanduff.nightshadeprefs.plist"

@implementation NightshadeThemeController

- (NSArray *)specifiers {
  if (!_specifiers) {
    _specifiers = [[self loadSpecifiersFromPlistName:@"NightshadeThemeSettings" target:self] retain];
  }

  return _specifiers;
}

- (void)viewDidLoad{
  [super viewDidLoad];

  NSMutableArray *cells = [NSMutableArray array];

  NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/User/Library/Nightshade/Themes" error:NULL];
  NSMutableArray *plistFiles = [[NSMutableArray alloc] init];
   [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       NSString *filename = (NSString *)obj;
       NSString *extension = [[filename pathExtension] lowercaseString];
       if ([extension isEqualToString:@"plist"]) {
           [plistFiles addObject:filename];
       }
   }];

  PSSpecifier *noneCell = [PSSpecifier preferenceSpecifierNamed:@"None" target:self
    set:NULL
    get:NULL
    detail:PSListItemsController.class cell:PSListItemCell edit:nil];
  [cells addObject:noneCell];

  for (NSString *theme in plistFiles) {
      // Create a specifier for it

      NSString *themePath = @"/User/Library/Nightshade/Themes/";
      themePath = [themePath stringByAppendingString:theme];
      NSDictionary *themeData = [NSDictionary dictionaryWithContentsOfFile:themePath] ? : [NSDictionary new];

      PSSpecifier *cell = [PSSpecifier preferenceSpecifierNamed:themeData[@"kName"] target:self
        set:NULL
        get:NULL
        detail:PSListItemsController.class cell:PSListItemCell edit:nil];

      NSString *themeAddress = [themeData[@"kName"] stringByAppendingString:@".plist"];
      [cell setProperty:themeAddress forKey:@"SelectedTheme"];
  
     [cells addObject:cell];

   }

  // Add the specifiers
  [self insertContiguousSpecifiers:cells afterSpecifierID:@"kTheme" animated:NO];
}


@end



