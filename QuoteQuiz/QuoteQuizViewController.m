//
//  QuoteQuizViewController.m
//  QuoteQuiz
//
//  Created by Justin Wang on 5/16/14.
//  Copyright (c) 2014 com.6pingblky. All rights reserved.
//

#import "QuoteQuizViewController.h"
#import "tipViewController.h"
#import "Quiz.h"


@interface QuoteQuizViewController ()
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (weak, nonatomic) IBOutlet UILabel *ans1Label;
@property (weak, nonatomic) IBOutlet UILabel *ans2Label;
@property (weak, nonatomic) IBOutlet UILabel *ans3Label;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (weak, nonatomic) IBOutlet UIButton *a1button;
@property (weak, nonatomic) IBOutlet UIButton *a2button;
@property (weak, nonatomic) IBOutlet UIButton *a3button;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property  NSInteger answer;

@property UIColor * oriBKColor;


@end

@implementation QuoteQuizViewController


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"tipWindow"]) {
        if ([segue.destinationViewController isKindOfClass:[tipViewController class ]]) {
            tipViewController *tivc = (tipViewController *)segue.destinationViewController;
            tivc.tipToShow = self.quiz.tip;
            NSLog(@"%@", tivc.tipToShow);
            
        }
    }
}


- (IBAction)answer1Button:(UIButton *)sender {
    self.answer=1;
    [self checkAnswerUpdateUI];
    
}
- (IBAction)answer2Button:(UIButton *)sender {
    self.answer=2;
    [self checkAnswerUpdateUI];
}
- (IBAction)answer3Button:(UIButton *)sender {
    self.answer=3;
     [self checkAnswerUpdateUI];
}


- (IBAction)nextQuitButton:(id)sender {
    
    [self nextQuizItem];
    [self resetUI];
    
}

-(void)checkAnswerUpdateUI
{
    self.nextButton.enabled = YES;
    self.a1button.hidden =YES;
    self.a2button.hidden = YES;
    self.a3button.hidden = YES;
    if ([self.quiz checkQuestion:self.quizIndex forAnswer:self.answer]) {
        
        
        if (self.answer ==1) {
            
            self.ans1Label.backgroundColor = [UIColor greenColor];
            
            
        } else if ( self.answer ==2){
            
            self.ans2Label.backgroundColor = [UIColor greenColor];

        } else if ( self.answer ==3){
            
            self.ans3Label.backgroundColor = [UIColor greenColor];

        }
    } else {
        
        if (self.answer ==1) {
            self.ans1Label.backgroundColor = [UIColor redColor ];

        }else if ( self.answer ==2){
            self.ans2Label.backgroundColor = [UIColor redColor];
            
        } else if ( self.answer ==3){
            self.ans3Label.backgroundColor = [UIColor redColor];
            
        }
        
        
    }
    
    
    self.resultLabel.text = [NSString stringWithFormat:@"%lu correct vs %lu incorrect ", self.quiz.correctCount, self.quiz.incorrectCount];
    
 
}

-(void)nextQuizItem
{
    
    
    //handle beginning, in the middle and end of the quiz situation
    if (self.quizIndex == 999) {
        self.quizIndex =0;
        self.resultLabel.text =@"";
        
    }else if ((self.quiz.quizCount -1) <  self.quizIndex){
        self.quizIndex ++;
        
    }else {
        
        self.quizIndex ++;
        //self.resultLabel.text =@"";
        
    }
    
    
    //show quiz content if available
    
    if (self.quiz.quizCount >= self.quizIndex +1 ) {
        
        
        [self.quiz nextQuesetion:self.quizIndex]  ;
        self.ans1Label.text = self.quiz.answer1;
        self.ans2Label.text = self.quiz.answer2;
        self.ans3Label.text = self.quiz.answer3;
        self.questionLabel.text = self.quiz.quote;
        
     //   NSLog(@"%@,%@", self.quiz.tip,self.quiz.quote);
        
    }else {
        self.quizIndex =0;
        [self quizDone];
        
        [self resetUI]; //reset color background and button no hid, etc.
        
        
        
    }
    

    
}


-(void) resetUI
{
    self.ans1Label.backgroundColor = self.oriBKColor;
    self.ans3Label.backgroundColor = self.oriBKColor;
    self.ans2Label.backgroundColor = self.oriBKColor;
    self.nextButton.enabled = NO;
    self.a1button.hidden =NO;
    self.a2button.hidden = NO;
    self.a3button.hidden = NO;
    
    

}


-(void) quizDone
{
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	 
    NSLog(@"%@",self.quiz);
    
    self.oriBKColor = self.ans1Label.backgroundColor;
    
    self.quizIndex = 999;
    self.quiz = [[Quiz alloc ]initWithQuiz: @"quotes"];
    [self nextQuizItem];
    self.questionLabel.backgroundColor  =  self.oriBKColor;
    NSLog(@"%@",self.quiz);
    NSLog(@"%lu",self.quiz.quizCount);
    
    
    
}



@end
