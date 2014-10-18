//
//  pzViewController.m
//  textArea
//
//  Created by Justin Wang on 5/14/14.
//  Copyright (c) 2014 com.6pingblky. All rights reserved.
//

#import "pzViewController.h"
#import "textStatsViewController.h"

@interface pzViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *bodyText;

@property (weak, nonatomic) IBOutlet UIButton *outlinebutton;
@end

@implementation pzViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"statsViewController"]) {
        if ([segue.destinationViewController isKindOfClass:[textStatsViewController class ]]) {
            textStatsViewController *tsvc = (textStatsViewController *)segue.destinationViewController;
            tsvc.textToAnalyze = self.bodyText.textStorage;
            
        }
    }
}

- (IBAction)changeSelectedTextColor:(UIButton *)sender
{
    //[self.bodyText.textStorage addAttribute NSForegroundColorAttributeName value:sender backgroundColor range:self.bodyText.selectedRange];
    
    [self.bodyText.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor  range:self.bodyText.selectedRange];
    
    
}
- (IBAction)outlineBodyText {
    
    [self.bodyText.textStorage addAttributes:@{ NSStrokeWidthAttributeName: @-3,
                                                NSStrokeColorAttributeName: [UIColor blackColor]}  range:self.bodyText.selectedRange];
    
    
}

- (IBAction)removeOutlineText {

    [self.bodyText.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.bodyText.selectedRange];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"view load here");
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc ] initWithString:self.outlinebutton.currentTitle ];
    
    [title setAttributes:@{NSStrokeWidthAttributeName: @3, NSStrokeColorAttributeName: self.outlinebutton.tintColor} range:NSMakeRange(0, [title length])];
    
    [self.outlinebutton setAttributedTitle:title forState:UIControlStateNormal];
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    //check system configured font size change to apply the view here, every time the view comes into focus
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFontsChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    
}

-(void)preferredFontsChanged : (NSNotification *)notification
{
    [self usePreferredFonts ];
    
}


-(void) usePreferredFonts
{
    self.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.bodyText.font =[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated  ];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    
    
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
