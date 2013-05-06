//
//  globalVar.h
//  SmashingWord_me
//
//  Created by Edward on 4/7/13.
//
//

#import <Foundation/Foundation.h>

@interface globalVar : NSObject

extern NSInteger score;
extern double BUTTON_APPEAR_DURATION;
extern NSString *word_1;
extern NSString *word_2;
extern NSString *word_3;

extern NSInteger score_1;
extern NSInteger score_2;
extern NSInteger score_3;

extern NSInteger score_p1;
extern NSInteger score_p2;

extern NSString* scorePageMessage;

extern BOOL isPlayer1;

extern BOOL TEST_MODE;
@end
