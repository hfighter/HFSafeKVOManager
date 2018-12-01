### HFSafeKVOManager

1、iOS安全的KVO操作，解决由于添加了KVO忘记移除，或者多次移除导致的崩溃问题。

2、支持KVO block实现

### Demo

```Objective-C
@interface Person : NSObject

@property (nonatomic, copy) NSString *name;

@end

@implementation Person
@end


@interface ViewController ()

@property (nonatomic, strong) Person *p;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.p = [Person new];
    [HFSafeKVOManager object:self.p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew withBlock:^(NSString *keyPath, id object, NSDictionary *changes) {
        NSLog(@"keypath is %@, object is %@, changes is %@", keyPath, object, changes);
    }];
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.p.name = @"name";
    });
}

@end

```
