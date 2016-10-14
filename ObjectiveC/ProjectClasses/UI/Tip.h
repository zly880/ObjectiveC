// 获取UITableView的相对位置 同理可得UICollectionView的相对位置
//CGRect rectInTableView = [tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];

// UIStoryBoard页面跳转传值
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//    if ([segue.identifier isEqualToString:@"XXX"]) {
//        if ([sender isKindOfClass:[NSString class]]) {
//            [(CustomName *)segue.destinationViewController setProperty:sender];
//        }
//    }
//}

// UIDatePicker日期选择器，是一个用来选择日期和时间的控件，也可作为倒计时控件，继承UIControl。
// 初始化UIDatePicker
// UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 200, 320, 216)];
// 设置时区
// [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
// 设置当前显示时间
// [datePicker setDate:tempDate animated:YES];
// 设置显示最大时间（此处为当前时间）
// [datePicker setMaximumDate:[NSDate date]];
// 设置UIDatePicker的显示模式
// [datePicker setDatePickerMode:UIDatePickerModeDate];
// 当值发生改变的时候调用的方法
// [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
// [self.view addSubview:datePicker];
// 获得当前UIPickerDate所在的时间
// NSDate *selected = [datePicker date];

//#pragma mark -
//#pragma mark — UIMenuController，UIMenuItem
//UIMenuController *menuController = [UIMenuController sharedMenuController];
//UIMenuItem *menuItem_1 = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector()];
//UIMenuItem *menuItem_2 = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector()];
//UIMenuItem *menuItem_3 = [[UIMenuItem alloc] initWithTitle:@"移动" action:@selector()];
//menuController.menuItems = [NSArray arrayWithObjects: menuItem_1, menuItem_2,menuItem_3,nil];
////touchpos_x, touchpos_y分别为长按那点的x和y坐标   self.view为将要展示弹出框的视图
//[menuController setTargetRect:CGRectMake(touchpos_x, touchpos_y, 50, 50) inView:self.view];
//[menuController setMenuVisible:YES animated:YES];

// 动态获取键盘高度
//- (void)registerForKeyboardNotifications {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
//}
//- (void)keyboardWasShown:(NSNotification *)notif {
//    NSDictionary *info = [notif userInfo];
//    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    keyboardSize = [value CGRectValue].size;
//}
//- (void)keyboardWasHidden:(NSNotification *)notif {
//    NSDictionary *info = [notif userInfo];
//    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    keyboardSize = [value CGRectValue].size;
//}

// UITextView长文本输入限制
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//
//    if ([text isEqualToString:@"\n"]) {
//        return NO;
//    }
//    NSString *toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
//    if ([toBeString length] > 50) {
//        textView.text = [toBeString substringToIndex:50];
//        return NO;
//    }
//    return YES;
//}

// 限制只能输入数字和小数点
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    
//    BOOL returnValue = NO;
//    if ([self isPureInt:string] == YES || [string isEqualToString:@"."] || string.length == 0) {
//        returnValue = YES;
//    }
//    if ((range.location == 0 && range.length == 0 && [string isEqualToString:@"0"])
//        || (range.location == 0 && range.length == 0 && [string isEqualToString:@"."])) {
//        returnValue = NO;
//    }
//    
//    return returnValue;
//}
//
//- (BOOL)isPureInt:(NSString *)string {
//    
//    if (string == nil || string.length == 0) {
//        return NO;
//    }
//    
//    NSInteger val;
//    NSScanner *scan = [NSScanner scannerWithString:string];
//    return [scan scanInteger:&val] && [scan isAtEnd];
//}

// 部分拉伸图片，常用于圆角聊天信息框
//UIImage *image = [[UIImage imageNamed:@"XX"] stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
// 创建可拉伸图片，平铺拉伸
//UIImage *image = [[UIImage imageNamed:@"XX"] resizeableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];

// 数组排序，数组中元素是字典
//NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:key ascending:ascending]];
//NSArray *new = [array sortedArrayUsingDescriptors:sortDescriptors];

// 禁止下拉，允许上拉
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    int currentPostion = scrollView.contentOffset.y;
//    if (currentPostion - _lastPosition > 0) {
//        _lastPosition = currentPostion;
//        (@"ScrollUp now");
//    } else if (_lastPosition - currentPostion > 0) {
//        _lastPosition = currentPostion;
//        (@"ScrollDown now");
//        scrollView.contentOffset = CGPointZero;
//    }
//}

//// 获取当前屏幕显示的window
//- (UIWindow *)getCurrentWindow {
//
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    if (window.windowLevel != UIWindowLevelNormal) {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(UIWindow * tmpWin in windows) {
//            if (tmpWin.windowLevel == UIWindowLevelNormal) {
//                window = tmpWin;
//                break;
//            }
//        }
//    }
//
//    return window;
//}
//
//// 获取当前屏幕显示的viewcontroller
//- (UIViewController *)getCurrentVC {
//
//    UIViewController *result = nil;
//    UIWindow *window = [self getCurrentWindow];
//    UIView *frontView = [[window subviews] objectAtIndex:0];
//    id nextResponder = [frontView nextResponder];
//    result = [nextResponder isKindOfClass:[UIViewController class]] ? nextResponder : window.rootViewController;
//
//    return result;
//}

//// 去掉UItableview headerview黏性(sticky)
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    CGFloat sectionHeaderHeight = 90;
//    if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}

//- (void)processgestureReconizer:(UIGestureRecognizer *)gesture {
//
//    //判断手势状态
//    switch (gesture.state) {
//        case UIGestureRecognizerStateBegan: {
//            self.usualCollectionView.userInteractionEnabled = NO;
//            self.unusualCollectionView.userInteractionEnabled = NO;
//
//            CGPoint point = [gesture locationInView:self.unusualCollectionView];
//            self.from = [self.unusualCollectionView indexPathForItemAtPoint:point];
//            if (self.from == nil) {
//                break;
//            }
//            HomeCell *cell = (HomeCell *)[self.unusualCollectionView cellForItemAtIndexPath:self.from];
//            if (cell == nil) {
//                break;
//            }
//
//            CGRect rectInMain = CGRectMake(point.x - cell.bounds.size.width * 0.5,
//                                           point.y - cell.bounds.size.height * 0.5,
//                                           cell.bounds.size.width,
//                                           cell.bounds.size.height);
//            CGRect rect = [self.unusualCollectionView convertRect:rectInMain toView:self.view];
//            self.gestureView = [[UIView alloc] initWithFrame:rect];
//            self.gestureView.backgroundColor = [UIColor clearColor];
//            UILabel *label = [[UILabel alloc] initWithFrame:cell.titleLabel.frame];
//            label.text = cell.titleLabel.text;
//            label.textAlignment = cell.titleLabel.textAlignment;
//            label.textColor = cell.titleLabel.textColor;
//            label.font = cell.titleLabel.font;
//            [self.gestureView addSubview:label];
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.imageView.frame];
//            imageView.image = cell.imageView.image;
//            [self.gestureView addSubview:imageView];
//            [self.view addSubview:self.gestureView];
//            break;
//        }
//        case UIGestureRecognizerStateChanged: {
//            CGPoint point = [gesture locationInView:self.unusualCollectionView];
//            HomeCell *cell = (HomeCell *)[self.unusualCollectionView cellForItemAtIndexPath:self.from];
//            if (cell == nil) {
//                break;
//            }
//            CGRect rectInMain = CGRectMake(point.x - cell.bounds.size.width * 0.5,
//                                           point.y - cell.bounds.size.height * 0.5,
//                                           cell.bounds.size.width,
//                                           cell.bounds.size.height);
//            CGRect rect = [self.unusualCollectionView convertRect:rectInMain toView:self.view];
//            self.gestureView.frame = rect;
//            break;
//        }
//        case UIGestureRecognizerStateEnded: {
//            // 数据处理
//            BOOL contain = CGRectContainsPoint(self.usualCollectionView.frame, self.gestureView.center);
//            if (contain == YES) {
//                NSDictionary *fromDic = [self.unusualArray objectAtIndex:self.from.row];
//                if ([self.usualArray containsObject:fromDic] == NO) {
//                    CGPoint point = [gesture locationInView:self.unusualCollectionView];
//                    self.to = [NSIndexPath indexPathForItem:(point.x / (ScreenWidth / 4)) inSection:0];
//                    NSDictionary *toDic = [self.usualArray objectAtIndex:self.to.row];
//                    [self.usualArray removeObjectAtIndex:self.to.row];
//                    [self.usualArray insertObject:fromDic atIndex:self.to.row];
//                    [self.unusualArray removeObjectAtIndex:self.from.row];
//                    [self.unusualArray insertObject:toDic atIndex:self.from.row];
//                    [self.usualCollectionView reloadData];
//                    [self.unusualCollectionView reloadData];
//                }
//            }
//
//            self.usualCollectionView.userInteractionEnabled = YES;
//            self.unusualCollectionView.userInteractionEnabled = YES;
//            [self.gestureView removeFromSuperview];
//            self.gestureView = nil;
//            break;
//        }
//        default: {
//            self.usualCollectionView.userInteractionEnabled = YES;
//            self.unusualCollectionView.userInteractionEnabled = YES;
//            [self.gestureView removeFromSuperview];
//            self.gestureView = nil;
//            break;
//        }
//    }
//}

//// 同步GET请求
//NSURL *url = [[NSURL alloc] initWithString:urlString];
//NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
//NSURLResponse *respones = nil;
//NSError *error = nil;
//NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&respones  error:&error];
//
//// 异步GET请求
//NSURL *url = [[NSURL alloc] initWithString:urlString];
//NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
//[NSURLConnection connectionWithRequest:request delegate:self];
//// 协议方法
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
//
//// 只有创建可变的request才能设置POST请求，timeoutInterval:post超时默认最大时间是240秒。
//// 同步POST请求
//NSURL *url = [[NSURL alloc]initWithString:urlString];
//NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
//[request1 setHTTPMethod:@"POST"];
//NSString *bodyStr = @"type=focus-c";
//NSData *body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
//[request setHTTPBody:body];
//NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//
//// 异步POST请求
//NSURL *url = [[NSURL alloc] initWithString:urlString];
//NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
//[request setHTTPMethod:@"POST"];
//NSString * bodyStr = @"type=focus-c";
//NSData * body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
//[request setHTTPBody:body];
//[[NSURLConnection alloc] initWithRequest:request delegate:self]
//// 协议方法
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection;