//
//  HighestScoreScene.h
//  SmashingWord_me
//
//  Created by Edward on 4/18/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HighestScoreScene : CCLayer {
    CCLabelTTF* singleTopTen[10];
    CCLabelTTF* multiTopTen[10];
    CCSprite* bg;
    CCLabelTTF* single;
    CCLabelTTF* multi;
    
    int single_highest[10];
    int multi_highest[10];
}

@end
