//
//  GHUnitCocos2dBase.m
//  SmashingWord_me
//
//  Created by Denny Winoto on 4/18/13.
//
//

#import "GHUnitCocos2dBase.h"



@implementation GHUnitCocos2dBase

- (BOOL) shouldRunOnMainThread
{
    // By default NO, but if you have a UI test or test dependent on running on the main thread return YES
    return YES;
}

- (void) setUpClass
{
    
	CC_DIRECTOR_INIT();
    
    spc = [[SinglePlayerScene alloc] init];

}

- (void) tearDownClass
{
	CC_DIRECTOR_END();
	// You have to do this or the test window will not get the focus back
	[window_ release];
}

- (void)testStrings {
    NSString *string1 = @"a string";
    GHTestLog(@"I can log to the GHUnit test console: %@", string1);
    
    // Assert string1 is not NULL, with no custom error description
    GHAssertNotNil(string1, nil);
    
    // Assert equal objects, add custom error description
    NSString *string2 = @"a string";
    GHAssertEqualObjects(string1, string2, @"A custom error message. string1 should be equal to: %@.", string2);
}

- (void) testSample
{
    NSString *line = [spc readDictionaryFile:1 fileName:@"test.txt"];
    GHAssertTrue([line isEqualToString: @"hello"], @"Not equal to hello");
}

- (void) testGetWords
{
    [spc getWords];
    GHAssertNotNil([spc getWord1], @"Word1 should not be nil");
}

@end