//
//  tipViewController.m
//  QuoteQuiz
//
//  Created by Cindy Zheng on 5/17/14.
//  Copyright (c) 2014 com.6pingblky. All rights reserved.
//

#import "tipViewController.h"

@interface tipViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation tipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tipLabel.text=self.tipToShow;
}



@end
