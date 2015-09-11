//
//  ViewController.m
//  UIViewAnimationShowcase
//
//  Created by mcmc on 9/10/15.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
{
    int count;
    NSArray *animations;
    NSArray *animationOptions;
    NSUInteger selectedAnimationOptions;
    BOOL animating;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    animating = false;
    [_animateButton setTitle:@"STOP" forState:UIControlStateSelected];
    
    animations = @[
                   @[ @"None",           @(UIViewAnimationOptionTransitionNone)          ],
                   @[ @"FlipFromLeft",   @(UIViewAnimationOptionTransitionFlipFromLeft)  ],
                   @[ @"FlipFromRight",  @(UIViewAnimationOptionTransitionFlipFromRight) ],
                   @[ @"CurlUp",         @(UIViewAnimationOptionTransitionCurlUp)        ],
                   @[ @"CurlDown",       @(UIViewAnimationOptionTransitionCurlDown)      ],
                   @[ @"CrossDissolve",  @(UIViewAnimationOptionTransitionCrossDissolve) ],
                   @[ @"FlipFromTop",    @(UIViewAnimationOptionTransitionFlipFromTop)   ],
                   @[ @"FlipFromBottom", @(UIViewAnimationOptionTransitionFlipFromBottom)]
                   ];
    animationOptions = @[
                   @[ @"LayoutSubviews",            @(UIViewAnimationOptionLayoutSubviews)           ],
                   @[ @"AllowUserInteraction",      @(UIViewAnimationOptionAllowUserInteraction)     ],
                   @[ @"BeginFromCurrentState",     @(UIViewAnimationOptionBeginFromCurrentState)    ],
                   @[ @"Repeat",                    @(UIViewAnimationOptionRepeat)                   ],
                   @[ @"Autoreverse",               @(UIViewAnimationOptionAutoreverse)              ],
                   @[ @"OverrideInheritedDuration", @(UIViewAnimationOptionOverrideInheritedDuration)],
                   @[ @"OverrideInheritedCurve",    @(UIViewAnimationOptionOverrideInheritedCurve)   ],
                   @[ @"AllowAnimatedContent",      @(UIViewAnimationOptionAllowAnimatedContent)     ],
                   @[ @"ShowHideTransitionViews",   @(UIViewAnimationOptionShowHideTransitionViews)  ],
                   @[ @"OverrideInheritedOptions",  @(UIViewAnimationOptionOverrideInheritedOptions) ],
                         
                   @[ @"CurveEaseInOut",            @(UIViewAnimationOptionCurveEaseInOut)           ],
                   @[ @"CurveEaseIn",               @(UIViewAnimationOptionCurveEaseIn)              ],
                   @[ @"CurveEaseOut",              @(UIViewAnimationOptionCurveEaseOut)             ],
                   @[ @"CurveLinear",               @(UIViewAnimationOptionCurveLinear)              ]
                       ];
    
    [_animateButton addTarget:self action:@selector(buttonHandler)  forControlEvents:UIControlEventTouchUpInside];

}

- (void)buttonHandler
{
    animating = !animating;
    _animateButton.selected = animating;

    if (animating) {
        [self runAnimation];
    }
}

- (void)runAnimation
{
    [UIView transitionWithView:_countLabel
                      duration:1.0
                       options:selectedAnimationOptions
                    animations:^{ _countLabel.text = [NSString stringWithFormat:@"%i", count++]; }
                    completion:^(BOOL finished) { if (animating) [self runAnimation]; }
    ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)calculateAnimationOptions
{
    NSUInteger sum = [animations[_animationTypeTableView.indexPathForSelectedRow.row][1] integerValue];
    NSArray *rows = _animationOptionsTableView.indexPathsForSelectedRows;
    for (NSIndexPath *path in rows) {
        sum |= [animationOptions[path.row][1] integerValue];
    }
    selectedAnimationOptions = sum;
}

# pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (tableView == _animationTypeTableView) ?  animations.count : animationOptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OptionCell"];
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.backgroundColor = _animateButton.backgroundColor;
        cell.preservesSuperviewLayoutMargins = NO;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:10.0];
    }
    cell.textLabel.text = (tableView == _animationTypeTableView) ? animations[indexPath.row][0] : animationOptions[indexPath.row][0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[[tableView cellForRowAtIndexPath:indexPath] textLabel] setTextColor:[UIColor darkGrayColor]];
    [self calculateAnimationOptions];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[[tableView cellForRowAtIndexPath:indexPath] textLabel] setTextColor:[UIColor whiteColor]];
    [self calculateAnimationOptions];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return (tableView == _animationTypeTableView) ? @"Animation Type" : @"Options";
}

@end
