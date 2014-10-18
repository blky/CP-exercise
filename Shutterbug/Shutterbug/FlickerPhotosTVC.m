//
//  FlickerPhotosTVC.m
//  Shutterbug
//
//  Created by Cindy Zheng on 6/2/14.
//  Copyright (c) 2014 com.6pingblky. All rights reserved.
//

#import "FlickerPhotosTVC.h"
#import "Flickr Fetcher/FlickrFetcher.h"
#import "URLImageViewController.h"

@interface FlickerPhotosTVC ()

@end

@implementation FlickerPhotosTVC
#pragma mark - data source

//any time model change, reload table view
-(void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.tableView reloadData];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     // Return the number of sections.
     return  1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     // Return the number of rows in the section.
     
    return [self.photos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photoViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *photo  = self.photos [indexPath.row];
    cell.textLabel.text = [photo valueForKeyPath: FLICKR_PHOTO_TITLE ];
    cell.detailTextLabel.text =[photo valueForKeyPath: FLICKR_PHOTO_DESCRIPTION];
    
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id detail = self.splitViewController.viewControllers [1];
    
    if ([detail isKindOfClass:[UINavigationController class]]) {
       
        detail =  [((UINavigationController *)detail).viewControllers firstObject];
        
    }
         
    if ([detail isKindOfClass: [URLImageViewController class]] ) {
        [self prepareImageViewController:detail toDisplayPhoto:self.photos[indexPath.row]];
        
     
    }
    
}

#pragma mark - Navigation



-(void)prepareImageViewController:(URLImageViewController *)urlIVC toDisplayPhoto:(NSDictionary *)photo
{
    urlIVC.imageURL = [FlickrFetcher URLforPhoto:photo format:FlickrPhotoFormatLarge   ];
    urlIVC.title = [photo valueForKey:FLICKR_PHOTO_TITLE];
    
    NSLog(@"ths title of photo to show is %@",urlIVC.title);
    
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"here now 1 %@ " ,[sender class]);
    if ([sender isKindOfClass:[UITableViewCell class]]) {
       NSLog(@"here now 2");
        NSIndexPath * indexPath = [self.tableView indexPathForCell:sender];
        NSLog(@"index path %@",indexPath);
        
        if (indexPath) {
             
            if ([segue.identifier isEqualToString:@"displayPhoto"]) {
                if ([segue.destinationViewController isKindOfClass:[URLImageViewController class ]]) {
                    [self prepareImageViewController:segue.destinationViewController toDisplayPhoto:self.photos[indexPath.row]];
                    
                  
                }
                
            }
        }
    }
    
    
    
    
    
}


@end
