//
//  ViewController.m
//  memory
//
//  Created by  on 12. 1. 5..
//  Copyright (c) 2012년 SPARROWAPPS. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"

@implementation ViewController

static NSMutableArray * btnArray = nil;
static int levelStartIdx[10]={0,0,0,0,0,0,0,0,0,0};
static int levelEndIdx[10]={30,50,70,90,110,130,150,170,180,188};

static int gLevel = 0;
static int gScore;
static int gSecond = INIT_SECOND;
static int gRemainButtons;
static int gHintCount = 3;
//static int gBombCount = 3;

//korea item mask
static int gKoreaItem = KOREA_ITEM_MASK_CLEAR;

//xy 값이 변경되는 것 때문에 보관
static int gBtnOrignX[BUTTONS];
static int gBtnOrignY[BUTTONS];

//현재 플레그 index
static int flagsArray[BUTTONS];
static flag_side_type flagSide[BUTTONS];
static game_item_type itemArray[BUTTONS];


static int frontBtnIdxCnt = 0;
static int frontBtnIdxArray[2];

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    mCountryNameArray = [[NSArray alloc] initWithObjects:
                         @"South_Korea", 
                         @"United_States",
                         @"France",
                         @"Italy",                  				  	
                         @"England",
                         @"Greece",
                         @"Germany",
                         @"HongKong",
                         @"Sweden",							
                         @"Switzerland",
                         @"United_Arab_Emirates",
                         @"Japan",
                         @"China",
                         @"Russia",
                         @"Canada",
                         @"Spain",
                         @"Poland",						
                         @"Portugal",
                         @"North_Korea",
                         @"Netherlands",
                         @"Finland",
                         @"Denmark",
                         @"Hungary",
                         @"Singapore",
                         @"Malaysia",
                         @"Ireland",
                         @"Norway",
                         @"Mexico",
                         @"Vatican_City",                     
                         @"Venezuela",
                         @"Turkey",
                         @"Brazil",
                         @"Egypt",
                         @"Israel",
                         @"Australia",
                         @"Taiwan",
                         @"Iran",					  	
                         @"Iraq",
                         @"Sudan",
                         @"Saudi_Arabia",
                         @"Argentina",
                         @"Slovakia",							
                         @"Slovenia",
                         @"Vietnam",
                         @"Philippines",
                         @"Dominica",                      	
                         @"Dominican_Republic",
                         @"Austria",
                         @"Colombia",
                         @"Chile",
                         @"New_Zealand",
                         @"Romania",
                         @"Bulgaria",
                         @"India",					
                         @"Indonesia",
                         @"Kuwait",
                         @"Sri_Lanka",
                         @"South_Africa",
                         @"Pakistan",
                         @"Afghanistan",
                         @"Turkmenistan",
                         @"Uruguay",							
                         @"Paraguay",						
                         @"Peru",
                         @"Uzbekistan",
                         @"Jordan",					
                         @"Kenya",
                         @"Senegal",							
                         @"Serbia",
                         @"Uganda",
                         @"Thailand",
                         @"Cameroon",
                         @"Nigeria",					  	
                         @"Nepal",						
                         @"Oman",
                         @"Congo2",            				
                         @"Congo",
                         @"Bolivia",
                         @"Cambodia",
                         @"Cuba",
                         @"Costa_Rica",
                         @"Ghana",
                         @"Tajikistan",						
                         @"Libya",
                         @"Syria",
                         @"Tanzania",
                         @"Zambia",							
                         @"Zimbabwe",
                         @"Croatia",
                         @"Albania",     			    	
                         @"Algeria",      			    	
                         @"Cote_dIvoire",
                         @"Andorra",      			    	
                         @"Angola",          		   			   	  	
                         @"Antigua_and_Barbuda",  		
                         @"Ukraine",          		  	
                         @"Armenia",            		  	
                         @"Honduras",
                         @"Yemen",                    	
                         @"Central_African_Republic",                     	
                         @"Gabon",
                         @"Bahamas",                                     	
                         @"Ecuador",
                         @"Bahrain",                       	
                         @"El_Salvador",
                         @"Bangladesh",                    	
                         @"Ethiopia",
                         @"Barbados",                      	
                         @"Fiji",
                         @"Somalia",							
                         @"South_Sudan",
                         @"Monaco",
                         @"Panama",
                         @"Belarus",                       	
                         @"Belgium",                       	
                         @"Belize",                        	
                         @"Benin",                         	
                         @"Bhutan",                        	
                         @"Bosnia_and_Herzegovina",        	
                         @"Botswana",                                	
                         @"Burkina_Faso",               	
                         @"Burundi",                       	
                         @"Cape_Verde",                   	
                         @"Chad",                          	
                         @"Comoros",                	
                         @"Cyprus",                        	
                         @"Czech_Republic",                	
                         @"Djibouti",                      	
                         @"EastTimor",		        	
                         @"Equatorial_Guinea",             	
                         @"Eritrea",                       	
                         @"Estonia",                       	
                         @"Gambia",                 	
                         @"Georgia",                	
                         @"Grenada",				  	
                         @"Guatemala",				  	
                         @"Guinea",					
                         @"Guinea-Bissau",			
                         @"Guyana",					
                         @"Haiti",					
                         @"Kiribati",				  	
                         @"Kyrgyzstan",				
                         @"Laos",					  	
                         @"Latvia",					
                         @"Lebanon",				  	
                         @"Lesotho",				  	
                         @"Liberia",				  	
                         @"Liechtenstein",			
                         @"Lithuania",				
                         @"Luxembourg",				
                         @"Macedonia",				
                         @"Madagascar",				
                         @"Malawi",					
                         @"Maldives",				  	
                         @"Mali",					  	
                         @"Malta",					  	
                         @"Marshall_Islands",			  	
                         @"Mauritius",             				  	
                         @"Micronesia",				  	
                         @"Moldova",					  	
                         @"Mongolia",					  	
                         @"Montenegro",				  	
                         @"Morocco",					  	
                         @"Mozambique",				  	
                         @"Burma",                         
                         @"Namibia",					  	
                         @"Nauru",					  	
                         @"Nicaragua",				 	
                         @"Niger",						
                         @"Palau",						
                         @"Papua_New_Guinea",				
                         @"Qatar",						
                         @"Rwanda",						
                         @"Saint_Kitts_and_Nevis",		
                         @"Saint_Lucia",					
                         @"Saint_Vincent_and_the_Grenadines", 
                         @"Samoa",							
                         @"San_Marino",						
                         @"Sao_Tome_and_Principe",			
                         @"Seychelles",						
                         @"Sierra_Leone",						
                         @"Solomon_Islands",					
                         @"Suriname",							
                         @"Swaziland",						
                         @"Togo",								
                         @"Tonga",							
                         @"Trinidad_and_Tobago",				
                         @"Tunisia",							
                         @"Tuvalu",							
                         @"Vanuatu",//189
                         nil];
    
    btnArray = [[NSMutableArray alloc]init];
    
    [self initGameScreen];
    [self initSound];
    [self newGame]; //<--- startPoint
    [self startTimer];
    
    if ([SPGameKitUtil isGameCenterAvailable]) { //게임센터가 가능한 단말이면...
        [SPGameKitUtil connectGameCenter];       //게임센터 접속~
    }
    
#ifdef FREE_APP
    // 지역 체크!
    NSString   *countryCode = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
    NSLog(@"The device's specified countryCode is %@", countryCode);
    _isBannerVisible = NO;
    
    if ([countryCode isEqualToString:@"KR"]) {
        [self AddCaulyAD];
    } else {
        [self adBannerInit];
    }
#endif    
}

- (void)dealloc
{
    if(btnArray != nil)
    {
        for (int i=0;i<BUTTONS;i++)
        {
            UIButton * btn = [btnArray objectAtIndex:i];
            [btn removeFromSuperview];
        }
    }
    
    [btnArray release];
    btnArray = nil;
    
    [mlblMsg removeFromSuperview];
    
    [mCountryNameArray release];
    mCountryNameArray = nil;
    
    [mlblScore release];
    [mlblLevel release];
    [mlblTime release];
    [mlblNationalName release];
    
    [mlblMsg release];
    
    [self releaseSound];
    
    [mbtnHint release];
    [mlblHint release];
//    [mbtnBomb release];
//    [mlblBomb release];
    [mlblKorea release];
    [mbtnMenu release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [mlblScore release];
    mlblScore = nil;
    [mlblLevel release];
    mlblLevel = nil;
    [mlblTime release];
    mlblTime = nil;
    [mlblNationalName release];
    mlblNationalName = nil;
    
    [mlblMsg release];
    mlblMsg = nil;
    
    [mTimer invalidate];
    mTimer = nil;
    
    [mbtnHint release];
    mbtnHint = nil;
    [mlblHint release];
    mlblHint = nil;
//    [mbtnBomb release];
//    mbtnBomb = nil;
//    [mlblBomb release];
//    mlblBomb = nil;
    [mlblKorea release];
    mlblKorea = nil;
    [mbtnMenu release];
    mbtnMenu = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//    } else {
//        return YES;
//    }
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UI Componenet
- (void)initGameScreen
{
    int tag = 0 ;
    
    srand(time(NULL));
    
    //버튼 BUTTONS개 
    for (int i=0; i<BUTTONS_ROWS; i++)
    {
        for (int j=0; j<BUTTONS_COLS; j++)
        {
            UIButton * btn = [[UIButton alloc]init];
            
            btn.frame = CGRectMake(FIRST_BTN_X + (j*BTN_SIZE_X+j*SPACING_X), FIRST_BTN_Y +(i*BTN_SIZE_Y+i*SPACING_Y), BTN_SIZE_X, BTN_SIZE_Y);
            
            [[btn layer] setCornerRadius:8.0f];
            [[btn layer] setMasksToBounds:YES];
            [[btn layer] setBorderWidth:1.0f];
            [btn setTag:tag ++];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:btn];
            
            //xy 보관
            gBtnOrignX[btn.tag] = btn.frame.origin.x;
            gBtnOrignY[btn.tag] = btn.frame.origin.y;
            
            [btnArray addObject:btn];
            [btn release];
            
            if(tag == BUTTONS )
                break;
            
        }
    }
    
    //아이템 , 점수 획득용 lbl
    mlblMsg = [[UILabel alloc]init];
    //lblMsg addSubview
    mlblMsg.frame = CGRectMake(160, 240, 100, 20);
    mlblMsg.textAlignment = UITextAlignmentCenter;
    mlblMsg.backgroundColor = [UIColor clearColor];
    mlblMsg.textColor = [UIColor whiteColor];
    [self.view addSubview:mlblMsg];
}

- (void) newGame
{
    gRemainButtons = BUTTONS;
    
    frontBtnIdxCnt = 0;
    
    [self shuffleFlagArray];

    for (int i=0; i<BUTTONS; i++)
    {
        [self makeBtnImage:[btnArray objectAtIndex:i]];
        itemArray[i] = ITEM_NONE;
        flagSide[i] = FRONT;
    }

    //item 숨겨두기
    for (int i=0; i<ITEM_COUNT_MAX; i++)
    {
        int idx = [self randomRange:0 max:BUTTONS-1];
        int itm = [self randomRange:0 max:ITEM_MAX];
        itemArray[idx] = itm;
    }
    
    [self displaySecond];
    //[self startTimer];
    
    //score
    [self displayScore];
    
    //level
    [self displayLevel];
    
    //hint,
    [self displayHint];
    
    //bomb
    //[self displayBomb];
    
    [self displayKoreaItem];
    
    [self displayNationalName:FLAG_NONE];
}

//버튼 클릭 
- (void) btnClick:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    
    if(flagSide[btn.tag] == FRONT)
        return;
    
    if(frontBtnIdxCnt >=2 )
        return;
    
    [self displayNationalName:flagsArray[btn.tag]];
    
    [self toFrontBtnImage:btn];
    
    frontBtnIdxArray[frontBtnIdxCnt] = btn.tag;
    frontBtnIdxCnt ++;
}

- (void) checkItem:(UIButton *)btn
{
    int x = btn.frame.origin.x;
    int y = btn.frame.origin.y;
    int idx = btn.tag;
    
    switch (itemArray[idx]) {
        case ITEM_SCORE:
            gScore += 100;
            [self displayMsg:@"+100" withX:x andY:y];
            [self displayScore];
            [self soundPlay:SND_GET_BONUS];
            break;
            
        case ITEM_HINT:
            gHintCount ++;
            [self displayMsg:@"+HINT1" withX:x andY:y];
            [self displayHint];
            [self soundPlay:SND_GET_BONUS];
            break;
            
//        case ITEM_BOMB:
//            gBombCount ++;
//            [self displayMsg:@"+BOMB1" withX:x andY:y];
//            [self displayBomb];
//            [self soundPlay:SND_GET_BONUS];
//            break;
            
        case ITEM_TIME:
            gSecond += 20;
            [self displayMsg:@"+20sec" withX:x andY:y];
            [self displaySecond];
            [self soundPlay:SND_GET_BONUS];
            break;            
            
        case ITEM_K:
            gKoreaItem |= KOREA_ITEM_MASK_K;
            [self displayMsg:@"K" withX:x andY:y];
            [self displayKoreaItem];
            break;
            
        case ITEM_O:
            gKoreaItem |= KOREA_ITEM_MASK_O;
            [self displayMsg:@"O" withX:x andY:y];
            [self displayKoreaItem];
            [self soundPlay:SND_GET_BONUS];
            break;
            
        case ITEM_R:
            gKoreaItem |= KOREA_ITEM_MASK_R;
            [self displayMsg:@"R" withX:x andY:y];
            [self displayKoreaItem];
            [self soundPlay:SND_GET_BONUS];
            break;
            
        case ITEM_E:
            gKoreaItem |= KOREA_ITEM_MASK_E;
            [self displayMsg:@"E" withX:x andY:y];
            [self displayKoreaItem];
            [self soundPlay:SND_GET_BONUS];
            break;
            
        case ITEM_A:
            gKoreaItem |= KOREA_ITEM_MASK_A;
            [self displayMsg:@"A" withX:x andY:y];
            [self displayKoreaItem];
            [self soundPlay:SND_GET_BONUS];
            break;
            
        default:
            break;
    }
    
    itemArray[idx] = ITEM_NONE;
}

- (void) makeBtnImage: (UIButton *)btn
{
    //btn 이미지 교체
    NSString * fileName;
    int orgx, orgy;
    int x,y;
    
    fileName = (NSString *)[mCountryNameArray objectAtIndex:flagsArray[btn.tag]];
    
    UIImage * img = [UIImage imageNamed:fileName];
    CGPoint startpoint = CGPointMake(0, 0);
    [img drawAtPoint:startpoint];
    [btn setImage:img forState:UIControlStateNormal];
    
    //에니메이션
    orgx = gBtnOrignX[btn.tag];
    orgy = gBtnOrignY[btn.tag];
    
    x = btn.frame.origin.x + BTN_SIZE_X/2;
    y = btn.frame.origin.y + BTN_SIZE_Y/2;
    btn.frame = CGRectMake(x , y, 1, 1);
    btn.alpha = 0;
    [UIView beginAnimations:@"makeBtnImage" context:btn];

    [UIView setAnimationDuration:ANIMATION_DURATION];
    btn.frame = CGRectMake(orgx, orgy, BTN_SIZE_X, BTN_SIZE_Y);
    btn.alpha = 1;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
    btn.enabled = YES;
}

- (void) makeBtnImage: (UIButton *)btn withFlagIdx:(int)flagidx
{
    //btn 이미지 교체
    NSString * fileName;
    //int flagidx;
    int orgx, orgy;
    int x,y;
    
    //flagidx = [self randomRange:levelStartIdx[gLevel] max:levelEndIdx[gLevel]];
    fileName = (NSString *)[mCountryNameArray objectAtIndex:flagidx];
    flagsArray[btn.tag] = flagidx;
    UIImage * img = [UIImage imageNamed:fileName];
    CGPoint startpoint = CGPointMake(0, 0);
    [img drawAtPoint:startpoint];
    [btn setImage:img forState:UIControlStateNormal];
    
    //에니메이션
    orgx = gBtnOrignX[btn.tag];
    orgy = gBtnOrignY[btn.tag];
    
    x = btn.frame.origin.x + BTN_SIZE_X/2;
    y = btn.frame.origin.y + BTN_SIZE_Y/2;
    btn.frame = CGRectMake(x , y, 1, 1);
    btn.alpha = 0;
    [UIView beginAnimations:@"makeBtnImage" context:btn];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    btn.frame = CGRectMake(orgx, orgy, BTN_SIZE_X, BTN_SIZE_Y);
    btn.alpha = 1;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
    btn.enabled = YES;
}

//에니메이션의 종료를 이리로 집중시킨다.
- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context 
{
    if ([animationID isEqualToString:@"makeBtnImage"]) {
        UIView* item = (UIView *)context;
        [self toBackBtnImage:(UIButton *)item];
    }
    else if ([animationID isEqualToString:@"toFrontBtnImage"])
    {
        if (frontBtnIdxCnt == 0)
        {
            //nothing to do.
        }
        else if (frontBtnIdxCnt == 1)
        {
            //nothing to do.
        }
        else if (frontBtnIdxCnt == 2)
        {
            //같은가 틀린가 보고
            //원래대로 뒤집기
            if ( flagsArray[frontBtnIdxArray[0]] == flagsArray[frontBtnIdxArray[1]] )
            {
                //정답
                [self doCorrect:[btnArray objectAtIndex:frontBtnIdxArray[0] ]];
                [self doCorrect:[btnArray objectAtIndex:frontBtnIdxArray[1] ]];
            }
            else
            {
                //틀려서 뒤집기
                [self toBackBtnImage:[btnArray objectAtIndex:frontBtnIdxArray[0] ]];
                [self toBackBtnImage:[btnArray objectAtIndex:frontBtnIdxArray[1] ]];
            }
            frontBtnIdxCnt = 0;
        }
    }
}

- (void) toFrontBtnImage: (UIButton *)btn
{
    UIImage * img;
    NSString * fileName;
    fileName = (NSString *)[mCountryNameArray objectAtIndex:flagsArray[btn.tag]];
    
    img = [UIImage imageNamed:fileName];        
    flagSide[btn.tag] = FRONT;
    
    CGPoint startpoint = CGPointMake(0, 0);
    [img drawAtPoint:startpoint];

    [UIView beginAnimations:@"toFrontBtnImage" context:nil];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:btn cache:YES];
    
    [btn setImage:img forState:UIControlStateNormal];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
    btn.enabled = YES;
}

- (void) toBackBtnImage: (UIButton *)btn
{
    UIImage * img;
    img = [UIImage imageNamed:@"back.png"];
    flagSide[btn.tag] = BACK;
    
    CGPoint startpoint = CGPointMake(0, 0);
    [img drawAtPoint:startpoint];
    
    [UIView beginAnimations:@"toBackBtnImage" context:nil];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut]; // 빠져나갈때 가속
    
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:btn cache:YES];
    
    [btn setImage:img forState:UIControlStateNormal];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
    btn.enabled = YES;
}



//- (void) panalty
//{
//    int empty_count = 0;
//    if (gRemainButtons == BUTTONS )
//        return;
//    //빈곳 위치 설정
//    
//    int empty_loc = [self randomRange:1 max:BUTTONS-gRemainButtons];
//    for ( int i=0; i<BUTTONS; i++ )
//    {
//        if (flagsArray[i] == FLAG_NONE)
//        {
//            empty_count ++;
//        }
//        
//        if (empty_count == empty_loc)
//        {
//            [self makeBtnImage:[btnArray objectAtIndex:i]];
//            break;
//        }
//    }
//    gRemainButtons ++;
//}

- (void) hideBtn: (UIButton *)btn
{
    int orgx, orgy;
    int x,y;
    
    flagsArray[btn.tag] = FLAG_NONE;
    
    //에니메이션
    orgx = btn.frame.origin.x;
    orgy = btn.frame.origin.y;
    x = btn.frame.origin.x + BTN_SIZE_X/2;
    y = btn.frame.origin.y + BTN_SIZE_Y/2;
    
    
    [UIView beginAnimations:@"hideBtn" context:nil];
    btn.frame = CGRectMake(x , y, 1, 1);
    btn.alpha = 0;
    
    
    [UIView setAnimationDuration:ANIMATION_DURATION*5];

    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    [UIView commitAnimations];
    
    btn.enabled = NO;
    btn.frame = CGRectMake(orgx, orgy, BTN_SIZE_X, BTN_SIZE_Y);
}

#pragma mark - Calculate
- (int) randomRange:(int)minvalue max:(int)maxvalue
{
    return (rand() % (maxvalue - minvalue +1) + minvalue);
}

//정답 처리
- (void) doCorrect:(UIButton *)btn
{
    int addscore;
    NSString * str;
    
    gRemainButtons --;
    [self soundPlay:SND_MOVE];
    addscore = (gRemainButtons + gSecond/10) * 10;
    gScore += addscore;
    
    str = [NSString stringWithFormat:@"+%i",addscore];
    
    //item check
    [self checkItem:btn];
    
    //점수
    [self displayScore];
    
    //버튼 완료
    [self hideBtn:btn];
    
    [self displayMsg:str withX:btn.frame.origin.x andY:btn.frame.origin.y];
    
    if ( [self checkGameComplete] == YES )
    {
        [mTimer invalidate];
        mTimer = nil;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Complete", @"")
                                                       message:[NSString stringWithFormat:NSLocalizedString(@"NextLevel", @""),gScore]
                                                      delegate:self 
                                             cancelButtonTitle:nil 
                                             otherButtonTitles:NSLocalizedString(@"OK", @""),nil];
        alert.tag = 0;
        [alert show];
        [alert release];
        
    }
    else
    {
        //Nothing to do.
    }
}

- (BOOL) checkGameComplete
{
    BOOL res = YES;
    
    if ( gRemainButtons == 0)
        res = YES;
    else
        res = NO;
    
    return res;
}

- (int) getFlagIdx
{
    int idx;
    BOOL isExist = NO;
    
    //게임이 끝난상태.
    if ([self checkGameComplete] == YES)
        return FLAG_NONE;
    
again:
    
    idx = [self randomRange:levelStartIdx[gLevel] max:levelEndIdx[gLevel]];
    for (int i=0; i<BUTTONS; i++)
    {
        if (flagsArray[i] == idx)
        {
            isExist = YES;
            break;
        }
    }
    
    if(isExist == YES)
        return idx;
    else
        goto again;
}

- (void) shuffleFlagArray
{
    
    //두개씩 랜덤으로 
    for (int i=0; i<BUTTONS /2; i++)
    {
        flagsArray[i] = [self randomRange:levelStartIdx[gLevel] max:levelEndIdx[gLevel]];
        flagsArray[i+ (BUTTONS /2)] = flagsArray[i];
    }
    
    //셔플 
    //랜덤으로 두 포지션을 얻어서 스왑한다.
    for (int i=0; i < BUTTONS * 2; i++)
    {
        int pos1 = [self randomRange:0 max:BUTTONS - 1];
        int pos2 = [self randomRange:0 max:BUTTONS - 1];
        int tmp = flagsArray[pos1];
        flagsArray[pos1] = flagsArray[pos2];
        flagsArray[pos2] = tmp;
    }
    
    
}



#pragma mark - Timer
- (void) startTimer
{
    if(mTimer == nil)
    {
        mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
    }
    else
    {
        [mTimer invalidate];
        mTimer = nil;
        
        mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
    }
}

- (void) handleTimer:(NSTimer*)timer
{
    gSecond --;
    
    [self displaySecond];
    if( gSecond == 0)
    {
        //gameover
        [self displayGameOver];
    }
}


#pragma mark - Display (label , allert)

- (void) displayNationalName:(int) flagIdx
{
    NSString * fileName;
    if (flagIdx != FLAG_NONE)
        fileName = (NSString *)[mCountryNameArray objectAtIndex:flagIdx];
    else
        fileName = @"";
    
    [mlblNationalName setText:NSLocalizedString(fileName, @"")];
}

- (void) displayScore
{
    NSString * str;
    str = [NSString stringWithFormat:@"%i",gScore];
    [mlblScore setText:str];
}

- (void) displayLevel
{
    NSString * str;
    str = [NSString stringWithFormat:@"%i",gLevel + 1];
    [mlblLevel setText:str];
}

- (void) displayHint
{
    NSString * str;
    str = [NSString stringWithFormat:@"x%i",gHintCount];
    [mlblHint setText:str];
}

//- (void) displayBomb
//{
//    NSString * str;
//    str = [NSString stringWithFormat:@"x%i",gBombCount];
//    [mlblBomb setText:str];   
//}

- (void) displayKoreaItem
{
    int mask = KOREA_ITEM_MASK_CLEAR;
    mask |= KOREA_ITEM_MASK_K;
    mask |= KOREA_ITEM_MASK_O;
    mask |= KOREA_ITEM_MASK_R;
    mask |= KOREA_ITEM_MASK_E;
    mask |= KOREA_ITEM_MASK_A;
    
    NSString * k, * o,* r, * e,* a;
    NSString * str = [NSString stringWithString:@""];
    if( (gKoreaItem & KOREA_ITEM_MASK_K) == KOREA_ITEM_MASK_K )
        k = [NSString stringWithString:@"K"];
    else
        k = [NSString stringWithString:@" "];
    
    if( (gKoreaItem & KOREA_ITEM_MASK_O) == KOREA_ITEM_MASK_O )
        o = [NSString stringWithString:@"O"];
    else
        o = [NSString stringWithString:@" "];
    
    if( (gKoreaItem & KOREA_ITEM_MASK_R) == KOREA_ITEM_MASK_R )
        r = [NSString stringWithString:@"R"];
    else
        r = [NSString stringWithString:@" "];
    
    if( (gKoreaItem & KOREA_ITEM_MASK_E) == KOREA_ITEM_MASK_E )
        e = [NSString stringWithString:@"E"];
    else
        e = [NSString stringWithString:@" "];
    
    if( (gKoreaItem & KOREA_ITEM_MASK_A) == KOREA_ITEM_MASK_A )
        a = [NSString stringWithString:@"A"];
    else
        a = [NSString stringWithString:@" "];
    
    str = [str stringByAppendingFormat:k];
    str = [str stringByAppendingFormat:o];
    str = [str stringByAppendingFormat:r];
    str = [str stringByAppendingFormat:e];
    str = [str stringByAppendingFormat:a];
    
    [mlblKorea setText:str];
    
    //모든 존재하는 깃발을 Koread로 변경 한다.
    if (gKoreaItem == mask)
    {
        [self soundPlay:SND_SHAKE];
        
        for (int i=0; i<BUTTONS; i++)
        {
            if ( flagsArray[i] != FLAG_NONE )
            {
                [self makeBtnImage:[btnArray objectAtIndex:i] withFlagIdx:0]; //korea
            }
        }
        
        gKoreaItem = KOREA_ITEM_MASK_CLEAR;
    }
}

- (void) displaySecond
{
    int min;
    int sec;
    min = gSecond / 60;
    sec = gSecond % 60;
    NSString * str = [NSString stringWithFormat:@"%02i:%02i", min,sec];
    [mlblTime setText:str];
    
    if(gSecond < 60)
    {
        [mlblTime setTextColor:[UIColor redColor]];
    }
    else
    {
        [mlblTime setTextColor:[UIColor whiteColor]];
    }
}

- (void) displayMsg:(NSString *)msg withX:(int)x andY:(int)y;
{
    //    if(!mOptDisplayEffect)
    //        return;
    
    [self.view bringSubviewToFront:mlblMsg];
    mlblMsg.frame = CGRectMake(x, y+20, 100, 20);
    mlblMsg.alpha = 1;
    mlblMsg.font = [UIFont fontWithName:@"Helvetica" size:22];
    
    mlblMsg.text = msg;
    
    [UIView beginAnimations:@"displayMsg" context:nil];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    mlblMsg.frame = CGRectMake(x, y-40, 100, 20);
    mlblMsg.alpha = 0;
    
    [UIView commitAnimations];
}


- (void) displayGameOver
{
#ifdef FREE_APP      
    [SPGameKitUtil sendScoreToGameCenter:gScore andId:@"memory_free"];
#else
    [SPGameKitUtil sendScoreToGameCenter:gScore andId:@"memory"];    
#endif
    
    [mTimer invalidate];
    mTimer =nil;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Game Over", @"")
                                                   message:[NSString stringWithFormat:NSLocalizedString(@"Your score", @""),gScore]
                                                  delegate:self 
                                         cancelButtonTitle:nil 
                                         otherButtonTitles:NSLocalizedString(@"Retry", @""), NSLocalizedString(@"Leaderboard", @""),nil];
    alert.tag= 1;
    [alert show];
    [alert release];    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    //구매 사이트 연결 
    //    if ( buttonIndex == 1 && alertView.tag == 1)
    //    {
    //        NSURL * url = [[NSURL alloc]initWithString:NSLocalizedString(@"URL", @"")]; 
    //        [[UIApplication sharedApplication] openURL:url];
    //        [url release];
    //    }
    if ( buttonIndex == 0 && alertView.tag == 0 ) // next game
    {
        //alert의 결과로...... 하자
        gSecond += 30;
        gLevel += 1;
        
        if(gLevel == 10 ) //최대...
            gLevel = 9;
        
        [self newGame];
        [self startTimer];
    }
    
    if ( buttonIndex == 0 && alertView.tag == 1 ) //retry new game
    {   
        gKoreaItem = KOREA_ITEM_MASK_CLEAR;
        //gBombCount = 3;
        gHintCount = 3;
        gScore = 0;
        gLevel = 0;
        gSecond = INIT_SECOND;
        [self newGame];
        [self startTimer];
    }
    
    if ( buttonIndex == 1 && alertView.tag == 1 ) //leaderboard view
    {
        [self showLeaderboard];
        gKoreaItem = KOREA_ITEM_MASK_CLEAR;
        //gBombCount = 3;
        gHintCount = 3;
        gScore = 0;
        gLevel = 0;
        gSecond = INIT_SECOND;
        [self newGame];  
        
    }
}

#pragma mark - Sound Componenet

-(void) initSound
{
    mMoveSound = [[SPSoundEffect alloc] initWithSoundNameSysSnd:@"move" ofType:@"wav"];
    mBombSound = [[SPSoundEffect alloc] initWithSoundNameSysSnd:@"bomb" ofType:@"wav"];
    mShakeSound = [[SPSoundEffect alloc] initWithSoundNameSysSnd:@"shake" ofType:@"wav"];
    mMissSound = [[SPSoundEffect alloc] initWithSoundNameSysSnd:@"miss" ofType:@"wav"];
    mBonusSound = [[SPSoundEffect alloc] initWithSoundNameSysSnd:@"bonus" ofType:@"wav"];
}

-(void) releaseSound
{
    [mMoveSound release];
    mMoveSound = nil;
    [mBombSound release];
    [mShakeSound release];
    [mMissSound release];
    mMissSound =nil;
    [mBonusSound release];
    mBonusSound =nil;
}

-(void) soundPlay:(game_sound_id_type)snd_id
{
    //    if(mOptSoundEffect)
    //    {
    switch (snd_id) {
        case SND_MOVE:
            [mMoveSound play];
            break;
            
        case SND_BOMB:
            [mBombSound play];
            break;
            
        case SND_SHAKE:
            [mShakeSound play];
            break;
            
        case SND_MISS:
            [mMissSound play];
            break;
            
        case SND_GET_BONUS:
            [mBonusSound play];
            break;            
            
        default:
            break;
    }
    //    }
}


#pragma mark - event handler
//힌트 버튼이 눌리면... 흔들기 효과로....
- (IBAction)hintBtnClick:(id)sender {
#define RADIANS(degrees) ((degrees * M_PI) / 180.0)
    
    if ( gHintCount == 0 )
        return;

    if (frontBtnIdxCnt != 1)
        return;
    
    gHintCount --;    
    [self displayHint];
    
    UIButton * btn;
    
    for (int i=0;i<BUTTONS;i++)
    {
        if (flagsArray[frontBtnIdxArray[0]] == flagsArray[i] && frontBtnIdxArray[0] != i )
        {
            btn = [btnArray objectAtIndex:i];
            CGAffineTransform leftWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-5.0));
            CGAffineTransform rightWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(5.0));
            
            btn.transform = leftWobble;  // starting point
            
            [UIView beginAnimations:@"wobble" context:btn];
            [UIView setAnimationRepeatAutoreverses:YES]; // important
            [UIView setAnimationRepeatCount:10];
            [UIView setAnimationDuration:0.2];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(wobbleEnded:finished:context:)];
            
            btn.transform = rightWobble; // end here & auto-reverse
            
            [UIView commitAnimations];
            break;
        }
    }
}

- (void) wobbleEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context 
{
    if ([finished boolValue]) {
        UIView* item = (UIView *)context;
        item.transform = CGAffineTransformIdentity;
    }
}

//폭탄 버튼이 눌리면... 레이블에 나온 모든 깃발 제거.
//- (IBAction)bombBtnClick:(id)sender {
//    
//    if (gBombCount == 0 )
//        return;
//    
//    if (lastButtonIdx == -1)
//        return;
//    
//    if (flagSide[lastButtonIdx] == BACK )
//        return;
//    
//    [self soundPlay:SND_BOMB];
//    
//    gBombCount --;
//    [self displayBomb];
//    
//    UIButton * btn;
//    
//    for (int i=0; i<BUTTONS; i++)
//    {
//        if (flagsArray[lastButtonIdx] == flagsArray[i] )
//        {
//            int addscore;
//            NSString * str;
//            btn = [btnArray objectAtIndex:i];
//            gRemainButtons --;
//            [self soundPlay:SND_MOVE];
//            addscore = (gRemainButtons + gSecond/10) * 10 + 100;
//            gScore += addscore;
//            
//            str = [NSString stringWithFormat:@"+%i",addscore];
//            [self displayMsg:str withX:btn.frame.origin.x andY:btn.frame.origin.y];
//            
//            //item check
//            [self checkItem:btn];
//            
//            //점수
//            [self displayScore];
//            
//            //btn 완료
//            btn.enabled = NO;
//            
//            if ( [self checkGameComplete] == YES )
//            {
//                [mTimer invalidate];
//                mTimer = nil;
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Complete", @"")
//                                                               message:[NSString stringWithFormat:NSLocalizedString(@"NextLevel", @""),gScore]
//                                                              delegate:self 
//                                                     cancelButtonTitle:nil 
//                                                     otherButtonTitles:NSLocalizedString(@"OK", @""),nil];
//                alert.tag = 0;
//                [alert show];
//                [alert release];
//                break;
//                
//            }
//            
//        }
//    }
//}

- (IBAction)menuBtnClick:(id)sender
{
    [mTimer invalidate];
    mTimer =nil;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:NSLocalizedString(@"GameTitle", @"")
                                                            delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"Resume", @"")
                                              destructiveButtonTitle:NSLocalizedString(@"NewGame", @"")
                                                   otherButtonTitles:NSLocalizedString(@"Leaderboard", @""), nil];
    actionSheet.tag = 0;
    [actionSheet showInView:[self view]];
    [actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( buttonIndex == 0 && actionSheet.tag == 0 ) //New game
    {   
        gKoreaItem = KOREA_ITEM_MASK_CLEAR;
        gHintCount = 3;
        //gBombCount = 3;
        gScore = 0;
        gLevel = 0;
        gSecond = INIT_SECOND;
        [self newGame];
        [self startTimer];
    }
    
    else if ( buttonIndex == 1 && actionSheet.tag == 0  ) //leaderboard view
    {
        [self showLeaderboard];
    }
    else
    {
        [self startTimer];
    }
}

#pragma mark - leaderboard
- (void) showLeaderboard {
    GKLeaderboardViewController *leaderboardController = [[[GKLeaderboardViewController alloc] init]autorelease];
    if (leaderboardController != nil) {
        // 레더보드 델리게이트는 나임
        leaderboardController.leaderboardDelegate = self;
        
        // 레더보드를 현재 뷰에 모달로 띄운다.
        [self presentModalViewController:leaderboardController animated: YES];
    }
}

// 레더보드 델리게이트를 구현한 부분. 닫힐때 호출된다.
- (void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
    [self dismissModalViewControllerAnimated:YES]; //점수판 모달뷰를 내림
    // 추가적으로 자신의 어플에 맞게 구현해야할것이 있으면 한다.
    [self startTimer];
}

- (void) showArchboard {
    GKAchievementViewController *archiveController = [[[GKAchievementViewController alloc]init] autorelease];
    
    if (archiveController != nil) {
        
        archiveController.achievementDelegate = self;
        
        [self presentModalViewController:archiveController animated: YES];
    }
}

- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController{
    [self dismissModalViewControllerAnimated:YES];
}

#ifdef FREE_APP
#pragma mark iAD Delegate
-(void) adBannerInit
{
    adBanner = [[ADBannerView alloc] initWithFrame:CGRectZero];
    [adBanner setRequiredContentSizeIdentifiers:
     [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, nil]];
    
    [adBanner setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierPortrait];
    [adBanner setFrame:CGRectMake(0, 480, 320, 50)];
    [adBanner setDelegate:self];
    [self.view addSubview:adBanner];
    [adBanner release];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!_isBannerVisible)
    {
        [UIView beginAnimations:@"animateBannerAppear" context:nil];
        [adBanner setFrame:CGRectMake(0, 430, 320, 50)];
        [UIView commitAnimations];
        _isBannerVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (_isBannerVisible)
    {
        [UIView beginAnimations:@"animateBannerOff" context:nil];
        //[adBanner setFrame:CGRectMake(0, 480, 320, 50)];
        adBanner.frame = CGRectOffset(adBanner.frame, 0, -50);
        [UIView commitAnimations];
    }
}

#pragma mark - CaulyAD

- (void)AddCaulyAD {
    
    float yPos = (self.view.frame.size.height - 48);
    
    if( [CaulyViewController moveBannerAD:self caulyParentview:nil xPos:0 yPos:yPos] == FALSE ) {
        NSLog(@"requestBannerAD failed");
    }
}
#endif

@end
