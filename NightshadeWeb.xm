#import "NightshadeColors.h"
#import "SparkAppList.h"

@import WebKit;

@interface WKWebView ()
-(void)runJavaScript:(NSString *)js;
@end

NSString *cssString = @"#cnt,#sDeBje,.Post,._2v9s,._333v,._3gin,._3t18,._56bt,._6j_d,.article header,.popoverOpen,.rn-14lw9ot,body,main,nav{background-color:#171717!important}#add-to-cydia,#msd,.M6hT6,.SDkEP,._14v8,._1g05,._2b06,._2rec,._4g33,._5187,._52jh,._52jj,._52z5,._55wo,._55wr,._6beq,._vi6,.acw,.b0KoTc,.card-section,.content ul,.ext-related-articles-card,.fbar,.hatnote,.header-bar,.kp-body,.kp-hc,.last-modified-bar,.mbox-small,.minerva-footer,.mnr-c:not(:empty),.review-list li,.scbrr-tabs,header,panel-body{background:#1C1C1E!important}.Post{border-bottom:1px solid #38383A!important}.MUxGbd,._1g06,._2b06,._52jh,.license,.mbox-small,h1,h2,h3,label,li,p,span,td{color:#fff!important}.v0nnCb,a{color:#A95DD0!important}a.active{border-bottom:2px solid #A95DD0!important}._14v8{box-shadow:1px 1px 3px 0 #1C1C1E!important}._2ftp,.gb_b,.gb_ub,.mw-ui-icon{filter:invert(100%)}.SDkEP{border:0!important}._6beq{border-color:#38383A}panel-body{box-shadow:2px 4px 40px -12px #1C1C1E!important}";
//NSString *cssString2 = [cssString stringByReplacingOccurrencesOfString:@"NIGHTSHADE_BACKGROUND" withString:GetHexStringForPrefernceKey(@"kBackgroundColor")];
//NSString *cssString3 = [cssString2 stringByReplacingOccurrencesOfString:@"NIGHTSHADE_CELL" withString:GetHexStringForPrefernceKey(@"kCellColor")];
//NSString *cssString4 = [cssString3 stringByReplacingOccurrencesOfString:@"NIGHTSHADE_ACCENT" withString:GetHexStringForPrefernceKey(@"kAccentColor")];
//NSString *cssString5 = [cssString4 stringByReplacingOccurrencesOfString:@"NIGHTSHADE_SEPERATOR" withString:GetHexStringForPrefernceKey(@"kSeperatorColor")];
//NSString *cssString6 = [cssString5 stringByReplacingOccurrencesOfString:@"NIGHTSHADE_TEXT" withString:GetHexStringForPrefernceKey(@"kTextColor")];

/*
NSString* cssString = [NSString stringWithContentsOfFile:@"/User/Library/Nightshade/darkmode.css"
                                              encoding:NSUTF8StringEncoding
                                                 error:NULL];
*/

NSString *javascriptString = @"console.log('Nightshade Injected'); var style = document.createElement('style'); style.innerHTML = '%@'; document.head.appendChild(style);"; 
NSString *javascriptWithCSSString = [NSString stringWithFormat:javascriptString, cssString]; 

%group Hooks
	%hook WKWebView
	-(void)_didFinishLoadForMainFrame{
		%orig;
		[self runJavaScript:javascriptWithCSSString];
	}

	%new
	-(void)runJavaScript:(NSString *)js
	{
		__block BOOL finished = NO;

		[self evaluateJavaScript:js completionHandler:^(id result, NSError *error) {
			finished = YES;
		}];
		while (!finished) {
			[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
		}
	}
	%end

	%hook UIWebView
	-(void)webViewMainFrameDidFinishLoad:(id)arg1{
		%orig;
		[self stringByEvaluatingJavaScriptFromString:javascriptWithCSSString];
	}
	%end
%end

%ctor {

	NSString* bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];    
	
	if(GetPrefBool(@"kTweakEnabled")) {	
		if (GetPrefBool(@"kThemeWebViewsEnabled")){
			if([SparkAppList doesIdentifier:@"com.dylanduff.nightshadeprefs" andKey:@"whitelistedApps" containBundleIdentifier:bundleIdentifier]){
				%init(Hooks);  
			}			
		}
	}

}
