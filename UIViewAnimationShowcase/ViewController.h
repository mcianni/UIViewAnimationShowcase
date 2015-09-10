//
//  ViewController.h
//  UIViewAnimationShowcase
//
//  Created by mcmc on 9/10/15.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UITableView *animationTypeTableView;
@property (strong, nonatomic) IBOutlet UITableView *animationOptionsTableView;
@property (strong, nonatomic) IBOutlet UIButton *animateButton;

@end

