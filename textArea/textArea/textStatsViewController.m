//
//  textStatsViewController.m
//  textArea
//
//  Created by Justin Wang on 5/16/14.
//  Copyright (c) 2014 com.6pingblky. All rights reserved.
//

#import "textStatsViewController.h"

@interface textStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlineLabel;

@end

@implementation textStatsViewController


-(void) viewDidLoad
{
    [super viewDidLoad];
    //test when coding , when if def testing..
  //  self.textToAnalyze = [[NSAttributedString  alloc]initWithString:@"test" attributes:@{NSForegroundColorAttributeName: [UIColor greenColor] , NSStrokeWidthAttributeName   : @-3   }];
    
}

-(void)setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    
    //if window is on screen , do update ui, otherwise, ignore
    if (self.view.window )   [self updateUI] ;
    
}

-(void)updateUI
{
    self.colorfulLabel.text = [NSString stringWithFormat:@"%lu of colorful character . ",(unsigned long)[[self characterWithAttributes:NSForegroundColorAttributeName ]length]];
    
    self.outlineLabel.text = [NSString stringWithFormat:@"%lu of outlined character . ",(unsigned long)[[self characterWithAttributes:NSStrokeWidthAttributeName ]length]];
    
}

- (NSAttributedString *) characterWithAttributes :(NSString *) AttributedName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc]init];
    
    NSUInteger i = 0;
    while (i < [self.textToAnalyze length]) {
       
        NSRange range; //return back a value from caling below
        
        //defined as id, since it could be any type of attribute,
        
        id value = [self.textToAnalyze attribute:AttributedName atIndex:i effectiveRange:&range];
        
        if (value) {
            [characters appendAttributedString: [self.textToAnalyze attributedSubstringFromRange:range]];
            i  =range.location + range.length;
            
        }else {
            i ++;
        }
       
    }
    
    return  characters;
        
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
    
}

@end
