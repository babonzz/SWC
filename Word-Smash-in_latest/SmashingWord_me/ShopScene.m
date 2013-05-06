//
//  ShopScene.m
//  SmashingWord_me
//
//  Created by Edward on 5/1/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "ShopScene.h"
#import "CCBReader.h"

@implementation ShopScene

-(id)init{
    if((self=[super init])){
        moneyLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Gold: %i", money] fontName:@"ArialRoundedMTBold" fontSize:15];
        moneyLabel.position = ccp(50,450);
        moneyLabel.color = ccBLACK;
        [self addChild:moneyLabel z:1];
        
        shopItem[0] = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i left", freezeTimeCounter] fontName:@"ArialRoundedMTBold" fontSize:15];
        shopItem[0].position = ccp(70,300);
        shopItem[0].color = ccBLACK;
        [self addChild:shopItem[0] z:1];
        
        shopItem[1] = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i left", extraTimeCounter] fontName:@"ArialRoundedMTBold" fontSize:15];
        shopItem[1].position = ccp(170,300);
        shopItem[1].color = ccBLACK;
        [self addChild:shopItem[1] z:1];
        
        shopItem[2] = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i left", slowdownTimeCounter] fontName:@"ArialRoundedMTBold" fontSize:15];
        shopItem[2].position = ccp(260,300);
        shopItem[2].color = ccBLACK;
        [self addChild:shopItem[2] z:1];
        
        shopItem[3] = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i left", cloudCounter] fontName:@"ArialRoundedMTBold" fontSize:15];
        shopItem[3].position = ccp(70,130);
        shopItem[3].color = ccBLACK;
        [self addChild:shopItem[3] z:1];
        
        shopItem[4] = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i left", increaseCounter] fontName:@"ArialRoundedMTBold" fontSize:15];
        shopItem[4].position = ccp(170,130);
        shopItem[4].color = ccBLACK;
        [self addChild:shopItem[4] z:1];

        
    }
    return self;
}

-(void)BackButtonPress:(id)sender{
    CCScene* scene = [CCBReader sceneWithNodeGraphFromFile:@"GameMenu.ccbi"];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionCrossFade transitionWithDuration:0.3 scene:scene]];
}

-(void)freezeTimePress:(id)sender{
    if(money >=100){
        money -= 100;
        freezeTimeCounter ++;
        [shopItem[0] setString:[NSString stringWithFormat:@"%i left", freezeTimeCounter]];
        [moneyLabel setString:[NSString stringWithFormat:@"Gold: %i",money]];
    }
}

-(void)extraTimePress:(id)sender{
    if(money >=100){
        money -= 100;
        extraTimeCounter ++;
        [shopItem[1] setString:[NSString stringWithFormat:@"%i left", extraTimeCounter]];
        [moneyLabel setString:[NSString stringWithFormat:@"Gold: %i",money]];
    }
}

-(void)slowdownTimePress:(id)sender{
    if(money >=100){
        money -= 100;
        slowdownTimeCounter ++;
        [shopItem[2] setString:[NSString stringWithFormat:@"%i left", slowdownTimeCounter]];
        [moneyLabel setString:[NSString stringWithFormat:@"Gold: %i",money]];
    }
}

-(void)cloudPress:(id)sender{
    if(money >=100){
        money -= 100;
        cloudCounter ++;
        [shopItem[3] setString:[NSString stringWithFormat:@"%i left", cloudCounter]];
        [moneyLabel setString:[NSString stringWithFormat:@"Gold: %i",money]];
    }
}

-(void)increasePress:(id)sender{
    if(money >=250){
        money -= 250;
        increaseCounter ++;
        [shopItem[4] setString:[NSString stringWithFormat:@"%i left", increaseCounter]];
        [moneyLabel setString:[NSString stringWithFormat:@"Gold: %i",money]];
    }
}

@end
