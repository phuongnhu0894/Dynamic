#import "ViewController.h"
@interface ViewController()
@property (weak, nonatomic) IBOutlet UITextField *checkTextField;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UIImageView *animalImageView;

@end

#pragma mark - Animals
@interface Cat : NSObject
@end

@implementation Cat
- (void) say {
    NSLog(@"Meo meo");
}
@end

@interface Dog : NSObject
@end
@implementation Dog
- (void) say {
    NSLog(@"Gau Gau");
}
@end

@interface Mouse : NSObject
@end
@implementation Mouse
- (void) say {
    NSLog(@"Chit chit");
}
@end

#pragma mark - Protocols
@protocol Fly <NSObject>
-(void) fly;
@end

@protocol Swim <NSObject>
-(void) swim;
@end

@interface Turtle : NSObject <Swim>
@end
@implementation Turtle
-(void) swim {
    NSLog(@"I can swim");
}
@end
#pragma mark - Main Logic
@implementation ViewController


- (IBAction)createObjectFromDynamicClass:(id)sender {
    NSArray* animals = @[@"Cat", @"Dog", @"Mouse", @"Elephant", @"Tiger"];
    int index = arc4random_uniform((u_int32_t)animals.count);
    
    Class class = NSClassFromString(animals[index]);
    if (class == nil) {
        NSLog(@"Non exist class - %@", animals[index]);
        return;
    }
    id object = [class new];
    SEL sayMethod = @selector(say);
    if ([object respondsToSelector:sayMethod]) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [object performSelector:sayMethod];
        #pragma clang diagnostic pop
    }
    
}

- (IBAction)callMethodFromString:(id)sender {
    NSArray* methods = @[@"sayHello", @"sayName", @"rob bank"];
    int index = arc4random_uniform((u_int32_t)methods.count);
    
    SEL method = NSSelectorFromString(methods[index]);
    
    if ([self respondsToSelector:method]) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:method];
        #pragma clang diagnostic pop
    } else {
        NSLog(@"%@ is not method",methods[index]);
    }

}

- (IBAction)createProtocolFromString:(id)sender {
    NSArray* protocols = @[@"Fly", @"Swim"];
    Turtle* turtle = [Turtle new];
    for (NSString* protocolName in protocols) {
        Protocol* protocol = NSProtocolFromString(protocolName);
        if ([turtle conformsToProtocol:protocol]) {
            NSLog(@"Turtle adopts %@ protocol", protocolName);
        }
    }
}
- (IBAction)checkAnimalEvent:(id)sender {
    NSString *input = self.checkTextField.text;
    Class class = NSClassFromString(input);
    if (class == [Cat class]) {
        self.animalImageView.image = [UIImage imageNamed:@"cat"];
    
    } else if (class== [Dog class]) {
        self.animalImageView.image = [UIImage imageNamed:@"dog"];
    } else if (class == [Mouse class] ) {
        self.animalImageView.image = [UIImage imageNamed:@"mouse"];
    } else {
        self.animalImageView.image = [UIImage imageNamed:@"error"];
    }
}

#pragma mark - Some dummy methods
-(void) sayHello {
    NSLog(@"Hello");
}

-(void) sayName{
    NSLog(@"I am Cuong");
}
@end
