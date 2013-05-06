//
//  GHUnitCocos2dBase.h
//  SmashingWord_me
//
//  Created by Denny Winoto on 4/18/13.
//
//


#import <Foundation/Foundation.h>
#import <GHUnitIOS/GHUnit.h>
#import "cocos2d.h"

#import "SinglePlayerScene.h"

@interface GHUnitCocos2dBase : GHTestCase
{
	UIWindow *window_;
	UINavigationController *navController_;
    
	CCDirectorIOS	*director_;							// weak ref
    
    SinglePlayerScene *spc;
}
@end
