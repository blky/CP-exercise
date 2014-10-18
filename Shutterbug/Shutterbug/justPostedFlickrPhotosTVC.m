//
//  justPostedFlickrPhotosTVC.m
//  Shutterbug
//
//  Created by Cindy Zheng on 6/2/14.
//  Copyright (c) 2014 com.6pingblky. All rights reserved.
//

#import "justPostedFlickrPhotosTVC.h"
#import "FlickrFetcher.h"

@interface justPostedFlickrPhotosTVC ()

@end

@implementation justPostedFlickrPhotosTVC

#pragma  mark - UI 


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchPhotos];
    
}

-(IBAction)fetchPhotos
{
    
    [self.refreshControl beginRefreshing]; // start the spinner
    NSURL *url = [FlickrFetcher URLforRecentGeoreferencedPhotos];
   
    
    // create a (non-main) queue to do fetch on
    dispatch_queue_t fetchQ = dispatch_queue_create("flickr fetcher", NULL);
    // put a block to do the fetch onto that queue
    dispatch_async(fetchQ, ^{
        // fetch the JSON data from Flickr
        NSData *jsonResults = [NSData dataWithContentsOfURL:url];
        // convert it to a Property List (NSArray and NSDictionary)
        NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                            options:0
                                                                              error:NULL];
        
        
        // get the NSArray of photo NSDictionarys out of the results
        NSArray *photos = [propertyListResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];
        // update the Model (and thus our UI), but do so back on the main queue
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing]; // stop the spinner
            self.photos = photos;
        });
    });
   
}
@end
