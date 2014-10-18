//
//  URLImageViewController.m
//  ScollViewandQueue
//
//  Created by Cindy Zheng on 5/28/14.
//  Copyright (c) 2014 com.6pingblky. All rights reserved.
//

#import "URLImageViewController.h"

@interface URLImageViewController () <UIScrollViewDelegate,UISplitViewControllerDelegate>

@property (strong,nonatomic) UIImageView *imageView;

//create a same size scollview for view controller
@property (weak, nonatomic) IBOutlet UIScrollView *scollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;


//a property of new kind that don't use _image as instance variable, but write from self.<other Property>
@property (strong,nonatomic)UIImage *image;


@end


@implementation URLImageViewController


#pragma  mark -

#pragma mark properties

-(void)setScollView:(UIScrollView *)scollView
{
    _scollView = scollView;
    self.scollView.contentSize = self.image ? self.image.size : CGSizeZero;
    _scollView.maximumZoomScale =2.0;
    _scollView.minimumZoomScale =0.2;
    _scollView.delegate=self;
    
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView

{
    //define where the zooming happened.
    return self.imageView;
    
    
}

//lazy instantiation
-(UIImageView *)imageView
{
    
    if (!_imageView) _imageView =   [[UIImageView alloc ] init];
    
    return _imageView;
    
}

-(UIImage *)image
{
    return self.imageView.image;
    
}

-(void)setImage:(UIImage *)image
{
    self.scollView.zoomScale =1.0;
    
    self.imageView.image=image;
    NSLog(@"###imageview inofrmation L %@",self.image);
    [self.imageView sizeToFit  ];
    self.imageView.frame = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
    
    self.scollView.contentSize = self.image ? self.image.size : CGSizeZero;
    
    [self.spinner stopAnimating];		
}

#pragma mark   multiThreading for loading image

-(void)setImageURL:(NSURL *)imageURL
{
    //this is from internet , later will be using multi-thread to advance its development
    _imageURL = imageURL;
    
    //self.image = [UIImage imageWithData: [NSData dataWithContentsOfURL:self.imageURL]  ];
    
    
    //download image with different queue other than main queue
    [self startDownloadImage];
    
    
    NSLog(@"###image url is %@",self.imageURL);
    
}

-(void)startDownloadImage
{
    self.image = nil;
    
    if (self.imageURL) {
        
        [self.spinner startAnimating];
        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        
        //create background task
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration: configuration];
        
        NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL *localFile, NSURLResponse *response, NSError *error) {
            
            if (!error) {
                if ([request.URL isEqual:self.imageURL]) {
                    
                    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localFile]];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.image = image; });
                }
            }
   
        }];
        
        [downloadTask resume];
         
    }
    
}


#pragma  mark -UISplitViewcontrollerDelegate

-(void)awakeFromNib
{
    self.splitViewController.delegate =self;
    
    
    
}

-(BOOL) splitViewController:(UISplitViewController *)svc
   shouldHideViewController:(UIViewController *)vc
              inOrientation:(UIInterfaceOrientation)orientation

{
    
    return UIInterfaceOrientationIsPortrait(orientation );
    
}

-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = aViewController.title;
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
}



-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.navigationItem.leftBarButtonItem=nil;
    
}

#pragma mark - UI


-(void) viewDidLoad
{
    [super viewDidLoad];
    
    
    
    [self.scollView   addSubview:self.imageView  ];
    
    
}@end
