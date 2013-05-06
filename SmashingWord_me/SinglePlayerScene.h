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

- (CCLabelTTF*) getWord1;
@end
