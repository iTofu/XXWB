# XXWB [![LeoDev](https://img.shields.io/badge/blog-LeoDev.me-brightgreen.svg)](http://leodev.me)

当初学习开发时写的小小微博，高仿新浪微博首页！仅供学习哈！

![XXWB](https://github.com/LeoiOS/XXWB/blob/master/XXWBDemo.gif)

````objc
心有猛虎，细嗅蔷薇。
````

## 必读！！
**请把项目中的 `XXCONST.h` 中的 `client_id` 和 `redirect_uri` 更换成你自己的，如果没有，上 [新浪微博开放平台](http://open.weibo.com/) 创建一个应用，然后填过来！**


## 介绍

仅供学习和参考哈！欢迎 star ⭐️ 和 fork！

这是微博在 2013 还是 2014 年的样式，只高仿了新浪微博的首页。

当时写这个项目的时候还是个菜鸟，所以项目中有很多不完善和可改进之处，但暂无继续开发的计划，欢迎 fork 继续开发！

如果你愿意，给一个本人的署名“Leo”和本项目的链接 (https://github.com/LeoiOS/XXWB) 就行了，哈哈！

如果你有（除要求继续开发之外的(╯‵□′)╯︵┻━┻）其他建议和意见，请点击 [Issue](https://github.com/LeoiOS/XXWB/issues/new)！


> 在 XXCONST.h 文件中，你可以更换成自己的 OAuth2 认证相关的 Authorize 及 Token。
>
> 如果你没有账号，点击 [新浪微博开放平台](http://open.weibo.com/) 申请一个即可 :)



## 实现功能

1. 新浪微博 OAuth2 认证流程！
2. 完整项目框架：UITabBarController + UINavigationController + UIViewController！
3. 高度自定义 XXTabBarController，实现了 tabBar 的全部自定义。tabBar 中间添加 ➕ 按钮，可随意调整图片位置和大小，随意调整文字位置和大小，并利用 KVO 实现自定义 badgeValue 跟随 tabBarItem.badgeValue 值变化而变化！
4. 实现首页数据的全部展示，包括微博的用户头像、用户名、会员等级图标、时间、发送来源、正文、附图、转发数、评论数、点赞数等！
5. 微博发送时间进行人性化显示，如：刚刚、1分钟前、1小时前、昨天等！
6. 微博附图实现九宫格布局，并可点开查看大图！
7. 实现微博转发显示！
8. 借鉴 MVVM 思想，实现 cell 的动态高度！
9. 实现下拉刷新和上拉加载功能！
10. 实现首页 UI 的高仿！不能更像！
11. 实现发微博功能！



## 预览

![XXWB](https://github.com/LeoiOS/XXWB/blob/master/demo01.png)
---
![XXWB](https://github.com/LeoiOS/XXWB/blob/master/demo02.png)
---
![XXWB](https://github.com/LeoiOS/XXWB/blob/master/demo03.png)
---
![XXWB](https://github.com/LeoiOS/XXWB/blob/master/demo04.png)



## 鸣谢

本项目中使用到了如下框架：

* [MJRefresh](https://github.com/CoderMJLee/MJRefresh)
* [MJExtension](https://github.com/CoderMJLee/MJExtension)
* [MJPhotoBrowser](https://github.com/CoderMJLee)
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
* [SDWebImage](https://github.com/rs/SDWebImage)
* [SVProgressHUD](https://github.com/TransitApp/SVProgressHUD)




## 免责声明

**本项目所用新浪微博接口由新浪微博所有，OAuth2 认证接口由本人所有。**

**仅供学习参考，作者本人保留其他所有未经声明的合法权利。**

**如果你有任何非法行为，如：任何恶意的、对新浪微博造成任意形式损害的行为等，皆与本人无关！**
