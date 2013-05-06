//
//  SinglePlayerScene.m
//  SmashingWord_me
//
//  Created by Edward on 3/21/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SinglePlayerScene.h"
#import "CCBReader.h"

@implementation SinglePlayerScene
const bool TEST_MODE = false;                // A FLAG TO INDICATE WHETHER THE GAME IS IN TEST MODE

const int MAX_LETTER_ARRAY = 10;             // SIZE OF THE LETTER ARRAY
const int MAX_BUTTON_APPEAR = 9;             // MAXIMUM NUMBER OF BUTTONS APPEAR ON EACH TIME STEP
const int STARTING_MINUTES = 0;              // STAGE DURATION
const int STARTING_SECONDS = 20;             // STAGE DURATION
const int INCR_SCORE = 10;                   // score increment step

const int TOTAL_WORDS_IN_FILE = 20;          // MAXIMUM NUMBER OF WORDS IN A DICTIONARY FILE
const int RANGE_OF_WORD_LENGTH = 2;         // RANGE OF WORD LENGTH USED
const int START_OF_WORD_LENGTH = 3;
const bool easy = false;

NSString *l;
int tempTag;
int currMinute;
int currSeconds;
NSString *STARTING_TIME = @"Time : 1:00";
BOOL STOP = false;
NSString *letter[MAX_LETTER_ARRAY];
int total_tests = 0;
int successful_tests = 0;
int failed_tests = 0;
//NSInteger score = 0;

NSMutableDictionary *word1Dict;
NSMutableDictionary *word2Dict;
NSMutableDictionary *word3Dict;
NSMutableDictionary *lettersDict;


//************** generating the words **********************
- (void) getWords
{
    int r1, r2, r3;
    int l1, l2, l3;
    NSString *fileName;
    
    r1 = rand() % TOTAL_WORDS_IN_FILE;
    l1 = rand() % RANGE_OF_WORD_LENGTH + START_OF_WORD_LENGTH;
    fileName = [NSString stringWithFormat:@"%i.txt", l1];
    word_1 = [self readDictionaryFile:r1 fileName:fileName];
    [word1 setString:word_1];
    
    r2 = rand() % TOTAL_WORDS_IN_FILE;
    l2 = rand() % RANGE_OF_WORD_LENGTH + START_OF_WORD_LENGTH;
    fileName = [NSString stringWithFormat:@"%i.txt", l2];
    while (r2==r1){ r2 = rand() % TOTAL_WORDS_IN_FILE;}
    word_2 = [self readDictionaryFile:r2 fileName:fileName];
    [word2 setString:word_2];
    
    r3 = rand() % TOTAL_WORDS_IN_FILE;
    l3 = rand() % RANGE_OF_WORD_LENGTH + START_OF_WORD_LENGTH;
    fileName = [NSString stringWithFormat:@"%i.txt", l3];
    while (r3==r1 || r3 == r2){ r3 = rand() % TOTAL_WORDS_IN_FILE;}
    word_3 = [self readDictionaryFile:r3 fileName:fileName];
    [word3 setString:word_3];
    /************** CHANGE boolean 'easy' ON TOP FOR EASY GAME ****************/
    if(easy)
    {
        r1 = rand() % 26;
        l1 = 1;
        fileName = [NSString stringWithFormat:@"%i.txt", l1];
        word_1 = [self readDictionaryFile:r1 fileName:fileName];
        [word1 setString:word_1];
        
        
        r2 = rand() % 26;
        l2 = 1;
        fileName = [NSString stringWithFormat:@"%i.txt", l2];
        while (r2==r1){ r2 = rand() % TOTAL_WORDS_IN_FILE;}
        word_2 = [self readDictionaryFile:r2 fileName:fileName];
        [word2 setString:word_2];
        
        r3 = rand() % 26;
        l3 = 1;
        fileName = [NSString stringWithFormat:@"%i.txt", l3];
        while (r3==r1 || r3 == r2){ r3 = rand() % TOTAL_WORDS_IN_FILE;}
        word_3 = [self readDictionaryFile:r3 fileName:fileName];
        [word3 setString:word_3];
    }
}

- (CCLabelTTF*) getWord1
{
    return word1;
}

- (NSString*) testing
{
    return @"hello";
}

//************** readDictionaryFile  **********************
// This function will take 2 parameters lineNum and wordLength, read a file called fileName
// containing a dictionary of words and return the corresponding word given the
// line number.
- (NSString*) readDictionaryFile:(NSInteger)lineNum fileName:(NSString*)fileName
{
    
    NSFileManager *filemgr;
    filemgr = [NSFileManager defaultManager];
    
    //NSString *home = NSHomeDirectory();
    
    //NSString *destinationPath = [NSString stringWithFormat:@"%@/SmashingWord_me.app/%@", home, fileName];
    //NSLog(@"\nText File: %@\n", destinationPath);
    //NSLog( @"THIZZZZ: %@" , [[NSBundle mainBundle] bundlePath] );
    
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *destinationPath = [NSString stringWithFormat:@"%@/%@", bundlePath, fileName];
    
    NSLog(@"\nText File: %@\n", destinationPath);
    if ([filemgr fileExistsAtPath: destinationPath] == YES)
        NSLog (@"File exists");
    else
        NSLog (@"File not found!");
     
    
    NSString *readText = [[NSString alloc] initWithContentsOfFile:destinationPath
                                                         encoding:NSUTF8StringEncoding
                                                            error:nil];
    NSArray *lines = [readText componentsSeparatedByString:@"\n"];
    
    //NSLog(@"%@ HAA", lines[lineNum]);
    
    return [lines[lineNum] lowercaseString];
}

-(void) hideButtons{
    [button[0] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [button[0] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    button[0].isEnabled=NO;
    [button[1] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [button[1] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    button[1].isEnabled=NO;
    [button[2] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [button[2] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    button[2].isEnabled=NO;
    [button[3] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [button[3] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    button[3].isEnabled=NO;
    [button[4] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [button[4] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    button[4].isEnabled=NO;
    [button[5] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [button[5] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    button[5].isEnabled=NO;
    [button[6] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [button[6] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    button[6].isEnabled=NO;
    [button[7] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [button[7] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    button[7].isEnabled=NO;
    [button[8] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [button[8] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    button[8].isEnabled=NO;
}


//************** Timer action **********************
-(void)timerFired
{
    // time's up
    if (currMinute ==0 && currSeconds == 1){
        [self.timer invalidate];
        STOP = true;
    }
    
    // if the game is still playing....
    else if((currMinute>0 || currSeconds>=0) && currMinute>=0)
    {
        if(currSeconds==0)
        {
            currMinute-=1;
            currSeconds=59;
        }
        else if(currSeconds>0)
        {
            currSeconds-=1;
        }
        if(currMinute>-1)
            [clock setString:[NSString stringWithFormat:@"%@%d%@%02d",@"Time : ",currMinute,@":",currSeconds]];
    }
    
    // time's up
    else
    {
        [self.timer invalidate];
    }
}

- (void)onTick{
    
    if (!STOP){
        [self hideButtons];
        int max_buttons = rand() % MAX_BUTTON_APPEAR + 1;
        
        for (int i=0; i<max_buttons; i++)
            [self generateButton];
        
    }
    else{
        [self endOfGame];
        [self.aTimer invalidate];
    }
}

//When the game finishes
-(void) endOfGame{
    [self hideButtons];
    
    //self.startButton.hidden = false;
    [self countLetters];
    
    score = [self getScore:word1Dict];
    score += [self getScore:word2Dict];
    score += [self getScore:word3Dict];
    /*
     for (int i =0; i<MAX_LETTER_ARRAY;i++)
     NSLog(@"%@", letter[i]);
     */
    NSLog(@"%i", score);
    score_p1 = score;
    score_p2 = -1;
    
    word1Dict = nil;
    word2Dict = nil;
    word3Dict = nil;
    lettersDict = nil;
    CCScene* scene = [CCBReader sceneWithNodeGraphFromFile:@"Score.ccbi"];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionCrossFade transitionWithDuration:0.3 scene:scene]];
    [self init];

}

// calculate the score
-(NSInteger) getScore: (NSMutableDictionary*) dict{
    
    if ([dict count]== 0)
        return 0;
    
    Boolean hit = false;
    
    for (id wordkey in dict){ //for each key in the word dictionary
        //NSLog(@"wordkey: %@", wordkey);
        for (id letterkey in lettersDict){ //compare with each key in letter dictionary
            //NSLog(@"%@ %@ %i %i",wordkey, letterkey, [[dict objectForKey:wordkey] intValue], [[lettersDict objectForKey:letterkey] intValue]);
            if ([wordkey isEqualToString:letterkey] && ([[lettersDict objectForKey:letterkey] intValue] >= [[dict objectForKey:wordkey] intValue])){
                hit = true;
                
            }
        }
        if (!hit) return 0;
        else hit = false;
    }
    
    return INCR_SCORE;
}


//counting letters occurance in letter array
-(void) countLetters{
    
    NSInteger count = 0;
    
    for (int i=0; i<MAX_LETTER_ARRAY; i++){
        
        if ([lettersDict objectForKey:[NSString stringWithFormat:@"%c",(char)(select[i].tag+32)]]==nil && select[i].tag != 0){
            for (int j=i; j<MAX_LETTER_ARRAY; j++){
                if (select[i].tag == select[j].tag)
                    count++;
            }
            [lettersDict setObject:[NSString stringWithFormat:@"%i", count] forKey:[NSString stringWithFormat:@"%c",(char)(select[i].tag+32)]];
        }
        count = 0;  // reset count
    }
    /*
     for (id key in lettersDict) {
     NSLog(@"key: %@, value: %@", key, [lettersDict objectForKey:key]);
     }
     */
}

//counting letters occurance in a word
-(void)parseWord: (NSString*) str dictionary:(NSMutableDictionary*) dict{
    if (str == NULL){
        dict = NULL;
        return;
    }
    
    NSString *key, *value;
    NSInteger numberOfChar=0;
    NSInteger i = 0;
    char c;
    
    for (i=0; i<[str length];i++){
        c = [str characterAtIndex:i];
        key = [NSString stringWithFormat:@"%c",c];
        if ([dict objectForKey:key]==nil){        //if c is not one of the key in dictionary
            //numberOfChar = [self occurrencesOfCharacter: &c nsstring:str];
            numberOfChar = [[str componentsSeparatedByString:key] count] - 1;
            value = [NSString stringWithFormat:@"%d", numberOfChar];
            [dict setObject:value forKey: key];
        }
    }
    /*
     for (id key in dict) {
     NSLog(@"key: %@, value: %@", key, [dict objectForKey:key]);
     }*/
     
}

//generating a button to appear
- (void) generateButton{
    int buttonToAppear = rand()%9 + 1;
    [self getLetter];
    switch (buttonToAppear) {
        case 1:
            [button[0] setNormalImage:[CCSprite spriteWithFile:l]];
            [button[0] setSelectedImage:[CCSprite spriteWithFile:l]];
            button[0].tag = tempTag;
            button[0].isEnabled=YES;
            break;
        case 2:
            [button[1] setNormalImage:[CCSprite spriteWithFile:l]];
            [button[1] setSelectedImage:[CCSprite spriteWithFile:l]];
            button[1].tag = tempTag;
            button[1].isEnabled=YES;
            break;
        case 3:
            [button[2] setNormalImage:[CCSprite spriteWithFile:l]];
            [button[2] setSelectedImage:[CCSprite spriteWithFile:l]];
            button[2].tag = tempTag;
            button[2].isEnabled=YES;
            break;
        case 4:
            [button[3] setNormalImage:[CCSprite spriteWithFile:l]];
            [button[3] setSelectedImage:[CCSprite spriteWithFile:l]];
            button[3].tag = tempTag;
            button[3].isEnabled=YES;
            break;
        case 5:
            [button[4] setNormalImage:[CCSprite spriteWithFile:l]];
            [button[4] setSelectedImage:[CCSprite spriteWithFile:l]];
            button[4].tag = tempTag;
            button[4].isEnabled=YES;
            break;
        case 6:
            [button[5] setNormalImage:[CCSprite spriteWithFile:l]];
            [button[5] setSelectedImage:[CCSprite spriteWithFile:l]];
            button[5].tag = tempTag;
            button[5].isEnabled=YES;
            break;
        case 7:
            [button[6] setNormalImage:[CCSprite spriteWithFile:l]];
            [button[6] setSelectedImage:[CCSprite spriteWithFile:l]];
            button[6].tag = tempTag;
            button[6].isEnabled=YES;
            break;
        case 8:
            [button[7] setNormalImage:[CCSprite spriteWithFile:l]];
            [button[7] setSelectedImage:[CCSprite spriteWithFile:l]];
            button[7].tag = tempTag;
            button[7].isEnabled=YES;
            break;
        case 9:
            [button[8] setNormalImage:[CCSprite spriteWithFile:l]];
            [button[8] setSelectedImage:[CCSprite spriteWithFile:l]];
            button[8].tag = tempTag;
            button[8].isEnabled=YES;
            break;
        default: break;
    }
    
}

//generating a letter to show on the button
- (void)getLetter{
    tempTag = (rand()%26) + 65;
    char c = (char)tempTag;
    l = [NSString stringWithFormat:@"%c"@".png" , c];
}


////////////////////////////////////////////////////////
//**************  start the game  ************************
-(void)start: (id)sender{
    
    [self getWords];
    //self.word1.text = @"Edwarda";
    [self parseWord: [word1 string] dictionary:word1Dict];
    [self parseWord: [word2 string] dictionary:word2Dict];
    [self parseWord: [word3 string] dictionary:word3Dict];
    
    [self.aTimer invalidate];
    [self.timer invalidate];
    self.timer = nil;
    self.aTimer = nil;
    
    currMinute = STARTING_MINUTES;
    currSeconds = STARTING_SECONDS;
    
    clock.color = ccBLACK;
    [clock setString: STARTING_TIME];
    //self.clock.backgroundColor=[UIColor clearColor];
    
    STOP = false;
    
    //stage timer
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    
    
    //button appear timer
    self.aTimer = [NSTimer scheduledTimerWithTimeInterval:BUTTON_APPEAR_DURATION target:self selector:@selector(onTick) userInfo:nil repeats:YES];
    
    [startButton setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [startButton setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    startButton.isEnabled=NO;

}

-(void)pressButton0:(id)sender{
    for(int i = 0; i<10; i++){
        if(select[i].tag == 0){
            [button[0] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            [button[0] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            button[0].isEnabled=NO;
            [select[i] setNormalImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[0].tag]]];
            [select[i] setSelectedImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[0].tag]]];
            select[i].tag = button[0].tag;
            break;
        }        
    }
}

-(void)pressButton1:(id)sender{
    for(int i = 0; i<10; i++){
        if(select[i].tag == 0){
            [button[1] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            [button[1] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            button[1].isEnabled=NO;
            [select[i] setNormalImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[1].tag]]];
            [select[i] setSelectedImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[1].tag]]];
            select[i].tag = button[1].tag;
            break;
        }
    }
}

-(void)pressButton2:(id)sender{
    for(int i = 0; i<10; i++){
        if(select[i].tag == 0){
            [button[2] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            [button[2] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            button[2].isEnabled=NO;
            [select[i] setNormalImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[2].tag]]];
            [select[i] setSelectedImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[2].tag]]];
            select[i].tag = button[2].tag;
            break;
        }
    }
}

-(void)pressButton3:(id)sender{
    for(int i = 0; i<10; i++){
        if(select[i].tag == 0){
            [button[3] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            [button[3] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            button[3].isEnabled=NO;
            [select[i] setNormalImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[3].tag]]];
            [select[i] setSelectedImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[3].tag]]];
            select[i].tag = button[3].tag;
            break;
        }
    }
}

-(void)pressButton4:(id)sender{
    for(int i = 0; i<10; i++){
        if(select[i].tag == 0){
            [button[4] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            [button[4] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            button[4].isEnabled=NO;
            [select[i] setNormalImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[4].tag]]];
            [select[i] setSelectedImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[4].tag]]];
            select[i].tag = button[4].tag;
            break;
        }
    }
}

-(void)pressButton5:(id)sender{
    for(int i = 0; i<10; i++){
        if(select[i].tag == 0){
            [button[5] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            [button[5] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            button[5].isEnabled=NO;
            [select[i] setNormalImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[5].tag]]];
            [select[i] setSelectedImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[5].tag]]];
            select[i].tag = button[5].tag;
            break;
        }
    }
}

-(void)pressButton6:(id)sender{
    for(int i = 0; i<10; i++){
        if(select[i].tag == 0){
            [button[6] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            [button[6] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            button[6].isEnabled=NO;
            [select[i] setNormalImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[6].tag]]];
            [select[i] setSelectedImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[6].tag]]];
            select[i].tag = button[6].tag;
            break;
        }
    }
}

-(void)pressButton7:(id)sender{
    for(int i = 0; i<10; i++){
        if(select[i].tag == 0){
            [button[7] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            [button[7] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            button[7].isEnabled=NO;
            [select[i] setNormalImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[7].tag]]];
            [select[i] setSelectedImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[7].tag]]];
            select[i].tag = button[7].tag;
            break;
        }
    }
}

-(void)pressButton8:(id)sender{
    for(int i = 0; i<10; i++){
        if(select[i].tag == 0){
            [button[8] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            [button[8] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
            button[8].isEnabled=NO;
            [select[i] setNormalImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[8].tag]]];
            [select[i] setSelectedImage:[CCSprite spriteWithFile:[NSString stringWithFormat:@"%c"@".png", (char)button[8].tag]]];
            select[i].tag = button[8].tag;
            break;
        }
    }
}

-(void)unSelect0: (id)sender{
    [select[0] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [select[0] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    select[0].tag = 0;
}

-(void)unSelect1: (id)sender{
    [select[1] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [select[1] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    select[1].tag = 0;
}

-(void)unSelect2: (id)sender{
    [select[2] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [select[2] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    select[2].tag = 0;
}

-(void)unSelect3: (id)sender{
    [select[3] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [select[3] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    select[3].tag = 0;
}

-(void)unSelect4: (id)sender{
    [select[4] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [select[4] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    select[4].tag = 0;
}

-(void)unSelect5: (id)sender{
    [select[5] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [select[5] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    select[5].tag = 0;
}

-(void)unSelect6: (id)sender{
    [select[6] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [select[6] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    select[6].tag = 0;
}

-(void)unSelect7: (id)sender{
    [select[7] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [select[7] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    select[7].tag = 0;
}

-(void)unSelect8: (id)sender{
    [select[8] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [select[8] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    select[8].tag = 0;
}

-(void)unSelect9: (id)sender{
    [select[9] setNormalImage:[CCSprite spriteWithFile:@"transparent.png"]];
    [select[9] setSelectedImage:[CCSprite spriteWithFile:@"transparent.png"]];
    select[9].tag = 0;
}

-(id)init{
    if((self=[super init])){
        srand ( time(NULL) );//clear out random numbers
        
        self.strArray = [NSArray arrayWithObjects:@"HELLO",@"WORLD",@"EDWARD",@"BING",@"WENHAO",@"DENNY",nil];
    
        //word1Dict= [NSMutableDictionary dictionary];
        word1Dict= [[NSMutableDictionary alloc] init];
        word2Dict= [[NSMutableDictionary alloc] init];
        word3Dict= [[NSMutableDictionary alloc] init];
        
        lettersDict= [[NSMutableDictionary alloc] init];
        
        bg = [CCSprite spriteWithFile:@"background.png"];
        [bg setPosition:ccp(160, 240)];
        [self addChild:bg z:0];
        //[self addChild:[CCMenuLayer node] z:1];
        
        ////////////////////////add 9 buttons and selected letters
        CCMenu *starMenu;
        button[0] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(pressButton0:)];
        [button[0] setScale:0.7];
        button[0].tag = 0;
        button[0].isEnabled=NO;
        starMenu = [CCMenu menuWithItems:button[0], nil];
        starMenu.position = CGPointZero;
        [starMenu setPosition:ccp(50,150)];
        [self addChild:starMenu z:1];
        
        button[1] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(pressButton1:)];
        [button[1] setScale:0.7];
        button[1].isEnabled=NO;
        starMenu = [CCMenu menuWithItems:button[1], nil];
        starMenu.position = CGPointZero;
        [starMenu setPosition:ccp(150,150)];
        [self addChild:starMenu z:1];
        
        button[2] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(pressButton2:)];
        [button[2] setScale:0.7];
        button[2].isEnabled=NO;
        starMenu = [CCMenu menuWithItems:button[2], nil];
        starMenu.position = CGPointZero;
        [starMenu setPosition:ccp(250,150)];
        [self addChild:starMenu z:1];
        
        button[3] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(pressButton3:)];
        [button[3] setScale:0.7];
        button[3].isEnabled=NO;
        starMenu = [CCMenu menuWithItems:button[3], nil];
        starMenu.position = CGPointZero;
        [starMenu setPosition:ccp(50,250)];
        [self addChild:starMenu z:1];
        
        button[4] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(pressButton4:)];
        [button[4] setScale:0.7];
        button[4].isEnabled=NO;
        starMenu = [CCMenu menuWithItems:button[4], nil];
        starMenu.position = CGPointZero;
        [starMenu setPosition:ccp(150,250)];
        [self addChild:starMenu z:1];
        
        button[5] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(pressButton5:)];
        [button[5] setScale:0.7];
        button[5].isEnabled=NO;
        starMenu = [CCMenu menuWithItems:button[5], nil];
        starMenu.position = CGPointZero;
        [starMenu setPosition:ccp(250,250)];
        [self addChild:starMenu z:1];
        
        button[6] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(pressButton6:)];
        [button[6] setScale:0.7];
        button[6].isEnabled=NO;
        starMenu = [CCMenu menuWithItems:button[6], nil];
        starMenu.position = CGPointZero;
        [starMenu setPosition:ccp(50,350)];
        [self addChild:starMenu z:1];
        
        button[7] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(pressButton7:)];
        [button[7] setScale:0.7];
        button[7].isEnabled=NO;
        starMenu = [CCMenu menuWithItems:button[7], nil];
        starMenu.position = CGPointZero;
        [starMenu setPosition:ccp(150,350)];
        [self addChild:starMenu z:1];
        
        button[8] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(pressButton8:)];
        [button[8] setScale:0.7];
        button[8].isEnabled=NO;
        starMenu = [CCMenu menuWithItems:button[8], nil];
        starMenu.position = CGPointZero;
        [starMenu setPosition:ccp(250,350)];
        [self addChild:starMenu z:1];
        
        /////////////////////////
        select[0] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(unSelect0:)];
        [select[0] setScale:0.4];
        starMenu = [CCMenu menuWithItems:select[0], nil];
        select[0].tag = 0;
        starMenu.position = CGPointZero;
        //[self addChild:starMenu];
        [starMenu setPosition:ccp(20,50)];
        [self addChild:starMenu z:1];
        
        select[1] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(unSelect1:)];
        [select[1] setScale:0.4];
        starMenu = [CCMenu menuWithItems:select[1], nil];
        select[1].tag = 0;
        starMenu.position = CGPointZero;
        //[self addChild:starMenu];
        [starMenu setPosition:ccp(50,50)];
        [self addChild:starMenu z:1];
        
        select[2] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(unSelect2:)];
        [select[2] setScale:0.4];
        starMenu = [CCMenu menuWithItems:select[2], nil];
        select[2].tag = 0;
        starMenu.position = CGPointZero;
        //[self addChild:starMenu];
        [starMenu setPosition:ccp(85,50)];
        [self addChild:starMenu z:1];
        
        select[3] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(unSelect3:)];
        [select[3] setScale:0.4];
        starMenu = [CCMenu menuWithItems:select[3], nil];
        select[3].tag = 0;
        starMenu.position = CGPointZero;
        //[self addChild:starMenu];
        [starMenu setPosition:ccp(120,50)];
        [self addChild:starMenu z:1];
        
        select[4] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(unSelect4:)];
        [select[4] setScale:0.4];
        starMenu = [CCMenu menuWithItems:select[4], nil];
        select[4].tag = 0;
        starMenu.position = CGPointZero;
        //[self addChild:starMenu];
        [starMenu setPosition:ccp(155,50)];
        [self addChild:starMenu z:1];
        
        select[5] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(unSelect5:)];
        [select[5] setScale:0.4];
        starMenu = [CCMenu menuWithItems:select[5], nil];
        select[5].tag = 0;
        starMenu.position = CGPointZero;
        //[self addChild:starMenu];
        [starMenu setPosition:ccp(190,50)];
        [self addChild:starMenu z:1];
        
        select[6] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(unSelect6:)];
        [select[6] setScale:0.4];
        starMenu = [CCMenu menuWithItems:select[6], nil];
        select[6].tag = 0;
        starMenu.position = CGPointZero;
        //[self addChild:starMenu];
        [starMenu setPosition:ccp(225,50)];
        [self addChild:starMenu z:1];
        
        select[7] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(unSelect7:)];
        [select[7] setScale:0.4];
        starMenu = [CCMenu menuWithItems:select[7], nil];
        select[7].tag = 0;
        starMenu.position = CGPointZero;
        //[self addChild:starMenu];
        [starMenu setPosition:ccp(260,50)];
        [self addChild:starMenu z:1];
        
        select[8] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(unSelect8:)];
        [select[8] setScale:0.4];
        starMenu = [CCMenu menuWithItems:select[8], nil];
        select[8].tag = 0;
        starMenu.position = CGPointZero;
        //[self addChild:starMenu];
        [starMenu setPosition:ccp(295,50)];
        [self addChild:starMenu z:1];
        
        select[9] = [CCMenuItemImage itemWithNormalImage:@"transparent.png" selectedImage:@"transparent.png" target:self selector:@selector(unSelect9:)];
        [select[9] setScale:0.4];
        starMenu = [CCMenu menuWithItems:select[9], nil];
        select[9].tag = 0;
        starMenu.position = CGPointZero;
        //[self addChild:starMenu];
        [starMenu setPosition:ccp(330,50)];
        [self addChild:starMenu z:1];
        
        ///////////////////////////////////////////////////
        ///////////////////start button
        startButton = [CCMenuItemImage itemWithNormalImage:@"start.png" selectedImage:@"start.png" target:self selector:@selector(start:)];
        [startButton setScale:0.5];
        starMenu = [CCMenu menuWithItems:startButton, nil];
        starMenu.position = CGPointZero;
        [starMenu setPosition:ccp(300,455)];
        [self addChild:starMenu z:1];
        
        ////////////////add clock and given words labels
        clock = [CCLabelTTF labelWithString:@"Time" fontName:@"Arial" fontSize:24];
        clock.position = ccp(250,420);
        clock.color = ccBLACK;
        [self addChild:clock z:1];
        
        word1 = [CCLabelTTF labelWithString:@"Word1:" fontName:@"Arial" fontSize:15];
        word1.position = ccp(50,460);
        word1.color = ccBLACK;
        [self addChild:word1 z:1];
        
        word2 = [CCLabelTTF labelWithString:@"Word2:" fontName:@"Arial" fontSize:15];
        word2.position = ccp(50,430);
        word2.color = ccBLACK;
        [self addChild:word2 z:1];
        
        word3 = [CCLabelTTF labelWithString:@"Word3:" fontName:@"Arial" fontSize:15];
        word3.position = ccp(50,400);
        word3.color = ccBLACK;
        [self addChild:word3 z:1];
        
    }
    return self;
}


-(void)BackButtonPress:(id)sender{
    CCScene* scene = [CCBReader sceneWithNodeGraphFromFile:@"GameMenu.ccbi"];
    [[CCDirector sharedDirector]replaceScene:[CCTransitionCrossFade transitionWithDuration:0.3 scene:scene]];
}

// Changing the image of the same sprite
//[test setTexture:[[CCTextureCache sharedTextureCache] addImage:@"two.png"]];
@end
