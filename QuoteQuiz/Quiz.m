//
//  Quiz.m
//  QuoteQuiz
//
//  Created by Justin Wang on 5/16/14.
//  Copyright (c) 2014 com.6pingblky. All rights reserved.
//

#import "Quiz.h"
@interface Quiz()

//class extension from read-only to read-write
@property (strong,nonatomic,readwrite)NSString * quote;
@property (strong,nonatomic,readwrite)NSString * answer1;
@property (strong,nonatomic,readwrite)NSString * answer2;
@property (strong,nonatomic,readwrite)NSString * answer3;
@property (strong,nonatomic,readwrite)NSString * tip;
@end

@implementation Quiz

-(id)initWithQuiz:(NSString *)plistName
{
    if (self = [super init]) {
        
        NSString * plistCatPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        self.movieArray = [NSMutableArray arrayWithContentsOfFile:plistCatPath];
        self.quizCount = [self.movieArray count];
        NSLog(@"here");
        
    }
    return  self;
    
}



-(void)nextQuesetion:(NSUInteger)idx
{
    self.quote = [NSString stringWithFormat:@"%@", self.movieArray[idx] [@"quote"] ];
    self.answer1 = self.movieArray [idx] [@"ans1"];
    self.answer2 = self.movieArray [idx] [@"ans2"];
    self.answer3 = self.movieArray [idx] [@"ans3"];
    self.tip =self.movieArray [idx] [@"tip"];

    if (idx==0) {
        self.correctCount =0;
        self.incorrectCount =0;
        
    }
    
    
    
}

-(BOOL)checkQuestion:(NSUInteger)question forAnswer:(NSUInteger )answer

{
    
    NSString * ans = self.movieArray[question] [@"answer"];
    
    if (answer == [ans intValue])
    {
        self.correctCount ++;
        return  YES;
        
        
        
    }else{
        self.incorrectCount ++;
        return NO;
        
    }
    
    
 
}


@end
