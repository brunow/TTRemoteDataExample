/*
 Copyright (c) 2011 Bruno Wernimont
 
 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files (the
 "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

 
#import "TTURLRequestViewController.h"

#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>
#import "extThree20JSON/extThree20JSON.h"
#import "extThree20JSON/YAJL.h"
#import "extThree20XML/extThree20XML.h"

@implementation TTURLRequestViewController


#pragma mark -
#pragma mark TTURLRequestDelegate

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	if ([request.response isKindOfClass:[TTURLImageResponse class]]) {
		TTURLImageResponse *imageResponse = (TTURLImageResponse *)request.response;
		[btnImage setBackgroundImage:imageResponse.image forState:UIControlStateNormal];
	} else if([request.response isKindOfClass:[TTURLJSONResponse class]]) {
		TTURLJSONResponse *JSONResponse = (TTURLJSONResponse *)request.response;
		NSDictionary *JSON = [JSONResponse rootObject];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"JSON Response"
														message:[NSString stringWithFormat:@"%@", JSON]
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		
		[alert show];
		[alert release];
	} else {
		TTURLXMLResponse *XMLResponse = (TTURLXMLResponse *)request.response;
		NSDictionary *XML = [XMLResponse rootObject];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"XML Response"
														message:[NSString stringWithFormat:@"%@", XML]
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
		
		[alert show];
		[alert release];
	}


}

#pragma mark -
#pragma mark Action

- (void)loadRemoteImage {
	TTURLRequest *request = [TTURLRequest requestWithURL:@"http://www.xgarreau.org/aide/devel/gd/tux.jpg" delegate:self];
	
	request.response = [[[TTURLImageResponse alloc] init] autorelease];
	[request send];
}

- (void)loadRemoteJSON {
	TTURLRequest *request = [TTURLRequest requestWithURL:@"http://api.smugmug.com/services/api/json/1.2.2/" delegate:self];
	
	request.response = [[[TTURLJSONResponse alloc] init] autorelease];
	[request send];
}

- (void)loadRemoteXML {
	TTURLRequest *request = [TTURLRequest requestWithURL:@"http://feeds.feedburner.com/BlogDeBrunoWernimont-DveloppeurWeb?format=xml" delegate:self];
	
	request.response = [[[TTURLXMLResponse alloc] init] autorelease];
	[request send];
}

#pragma mark -
#pragma mark View lifecycle

- (void)loadView {
	[super loadView];
	
	btnImage = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	btnImage.top    = 40;
	btnImage.left   = 50;
	btnImage.height = 200;
	btnImage.width  = 200;
	[btnImage setTitle:@"Load image" forState:UIControlStateNormal];
	[btnImage addTarget:self action:@selector(loadRemoteImage) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btnImage];
	
	UIButton *btnJSON = [UIButton buttonWithType:UIButtonTypeCustom];
	btnJSON.top    = 240;
	btnJSON.left   = 50;
	btnJSON.height = 100;
	btnJSON.width  = 200;
	[btnJSON setTitle:@"Load JSON" forState:UIControlStateNormal];
	[btnJSON addTarget:self action:@selector(loadRemoteJSON) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btnJSON];
	
	UIButton *btnXML = [UIButton buttonWithType:UIButtonTypeCustom];
	btnXML.top    = 340;
	btnXML.left   = 50;
	btnXML.height = 100;
	btnXML.width  = 200;
	[btnXML setTitle:@"Load XML" forState:UIControlStateNormal];
	[btnXML addTarget:self action:@selector(loadRemoteXML) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btnXML];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)dealloc {
	[btnImage release];
	
    [super dealloc];
}

@end
