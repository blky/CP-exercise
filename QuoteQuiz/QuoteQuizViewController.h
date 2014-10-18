//
//  QuoteQuizViewController.h
//  QuoteQuiz
//
//  Created by Justin Wang on 5/16/14.
//  Copyright (c) 2014 com.6pingblky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Quiz;

@interface QuoteQuizViewController : UIViewController

@property   NSInteger quizIndex;
@property (strong,nonatomic) Quiz * quiz;

 
@end
