#import <Preferences/PSListItemsController.h>
#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSSwitchTableCell.h>

#define LocalizedString(key) [[self bundle] localizedStringForKey:key value:key table:nil]

@interface NightshadeThemeController : PSListItemsController
@end

@interface PSSpecifier (value)
- (id)values;
- (id)setValues:(id)value;
@end