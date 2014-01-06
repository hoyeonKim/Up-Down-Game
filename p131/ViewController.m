//
//  ViewController.m
//  p131
//
//  Created by SDT-1 on 2014. 1. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>{
    int answer;
    int maximumTrail;
    int trial;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameSelector;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *countlabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UITextField *userInput;

- (IBAction)checkInput:(id)sender;
- (IBAction)newGame:(id)sender;

@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    [self.userInput becomeFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	[self newGame:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self checkInput:nil];
    return YES;
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == alertView.firstOtherButtonIndex){
        [self newGame:nil];
    }
}

-(IBAction)checkInput:(id)sender{
    int inputVal = [self.userInput.text intValue];
    self.userInput.text=@"";
    
    if(answer==inputVal){
        self.label.text=@"정답입니다!";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"정답" message:@"다시게임하시겠습니까?" delegate:self
                                             cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
        alert.tag = 11;
        [alert show];
        //[alert release];
    }
    else{
        trial++;
        if(trial>=maximumTrail){
            NSString *msg = [NSString stringWithFormat:@"답은 %d입니다",answer];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"실패" message:msg delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
            alert.tag=12;
            [alert show];
            
        }
        else{
            if(answer<inputVal){
                self.label.text = @"Down";
            }
            else{
                self.label.text=@"UP";
            }
            self.countlabel.text = [NSString stringWithFormat:@"%d/%d",trial,maximumTrail];
            
            self.progress.progress = trial /(float)maximumTrail;
            
        }
    }
    
}

-(IBAction)newGame:(id)sender{
    int selectedGame = self.gameSelector.selectedSegmentIndex;
    int maximumRandom = 0;
    if(0==selectedGame){
        maximumTrail = 5;
        maximumRandom = 10;
    }
    else if(1== selectedGame){
        maximumTrail =10;
        maximumRandom = 50;
    }
    else{
        maximumTrail = 20;
        maximumRandom = 100;
    }
    answer = random()%maximumRandom+1;
    trial = 0;
    self.progress.progress=0.0;
    self.countlabel.text = @"";
    self.label.text=@"";
    
    NSLog(@"New Game with Answer: %d",answer);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
