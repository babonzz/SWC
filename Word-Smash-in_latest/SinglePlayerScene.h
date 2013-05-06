//
//  SinglePlayerScene.h
//  SmashingWord_me
//
//  Created by Edward on 3/21/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "globalVar.h"
//score=0;
/*
NSString *word_1;
NSString *word_2;
NSString *word_3;

NSInteger score_1;
NSInteger score_2;
NSInteger score_3;
 */

@interface SinglePlayerScene : CCLayer {
    CCMenuItemImage* startButton;
    CCMenuItemImage* button[9];
    CCMenuItemImage* select[10];
    CCLabelTTF* clock;
    CCLabelTTF* word1;
    CCLabelTTF* word2;
    CCLabelTTF* word3;
    CCSprite* bg;
    
}

@property (strong, nonatomic) NSTimer *aTimer;              //stage timer
@property (strong, nonatomic) NSTimer *timer;               //button appear duration timer
//@property double BUTTON_APPEAR_DURATION;
@property (strong, nonatomic) NSArray *strArray;

- (NSString*) readDictionaryFile:(NSInteger)lineNum fileName:(NSString*)fileName;
- (NSString*) testing;
- (void) getWords;

//Methods used for testing
- (CCMenuItemImage*) getButton0;
- (CCMenuItemImage*) getButton1;
- (CCMenuItemImage*) getButton2;
- (CCMenuItemImage*) getButton3;
- (CCMenuItemImage*) getButton4;
- (CCMenuItemImage*) getButton5;
- (CCMenuItemImage*) getButton6;
- (CCMenuItemImage*) getButton7;
- (CCMenuItemImage*) getButton8;

- (CCMenuItemImage*) getSelect0;
- (CCMenuItemImage*) getSelect1;
- (CCMenuItemImage*) getSelect2;
- (CCMenuItemImage*) getSelect3;
- (CCMenuItemImage*) getSelect4;
- (CCMenuItemImage*) getSelect5;
- (CCMenuItemImage*) getSelect6;
- (CCMenuItemImage*) getSelect7;
- (CCMenuItemImage*) getSelect8;
- (CCMenuItemImage*) getSelect9;

- (CCLabelTTF*) getWord1;
-(void)pressButton0:(id)sender;
-(void)pressButton1:(id)sender;
-(void)pressButton2:(id)sender;
-(void)pressButton3:(id)sender;
-(void)pressButton4:(id)sender;
-(void)pressButton5:(id)sender;
-(void)pressButton6:(id)sender;
-(void)pressButton7:(id)sender;
-(void)pressButton8:(id)sender;

-(void)hideButtons;
-(void)resetSelectArray;
@end
