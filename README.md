DOPDropDownMenu
===============

Drop down menu like we see on website for iPhone..

![image](https://github.com/dopcn/DOPDropDownMenu/blob/master/images/sample_en.gif)

works the same as `UITableView` with a `dataSource` and a `delegate`

```objc
#pragma mark - data source protocol
@protocol DOPDropDownMenuDataSource <NSObject>
@required
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column;
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath;
@optional
//default value is 1
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu;
@end

#pragma mark - delegate
@protocol DOPDropDownMenuDelegate <NSObject>
@optional
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath;
@end
```

the menu will set it's width equal to screen width defaultly

```objc
/**
 *  the width of menu will be set to screen width defaultly
 *
 *  @param origin the origin of this view's frame
 *  @param height menu's height
 *
 *  @return menu
 */
- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height;
```

### DOPDropDownMenu-Enhanced

there is a new DOPDropDownMenu-Enhanced, https://github.com/12207480/DOPDropDownMenu-Enhanced 

on the basis of this, add double tableView , to optimize the code, improves stability ,

this project is inspired by [MXPullDownMenu](https://github.com/xxxxxtongxue/MXPullDownMenu)
