//
//  Quiz.h
//  QuoteQuiz
//
//  Created by Justin Wang on 5/16/14.
//  Copyright (c) 2014 com.6pingblky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quiz : NSObject
@property (strong,nonatomic)NSMutableArray * movieArray;
@property  NSInteger  correctCount;
@property NSInteger  incorrectCount;
@property NSInteger quizCount;
@property (strong,nonatomic,readonly)NSString * quote;
@property (strong,nonatomic,readonly)NSString * answer1;
@property (strong,nonatomic,readonly)NSString * answer2;
@property (strong,nonatomic,readonly)NSString * answer3;
@property (strong,nonatomic,readonly)NSString * tip;




-(id) initWithQuiz:(NSString *) plistName;
-(void) nextQuesetion: (NSUInteger) idx;
-(BOOL)checkQuestion : (NSUInteger)question forAnswer:(NSUInteger   ) answer;



@end
