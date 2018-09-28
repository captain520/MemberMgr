//
//  API.h
//  ZhiZaiDemo
//
//  Created by wangzhangchuan on 2017/12/4.
//  Copyright © 2017年 wangzhangchuan. All rights reserved.
//

#ifndef API_h
#define API_h


//#define ENVIRONMENT        0    // 1 : 正式环境    0:  测试环境
//
//#if ENVIRONMENT
//
//#deinf cp_Str2URL(url)        [NSURL URLWithString:url]
//
//#define CP_BASE_URL      @"http://api.leshouzhan.com"
//#else
//#define CP_BASE_URL      (@"http://api.leshouzhan.com")
//#endif

#define CPURL(api)     [NSString stringWithFormat:@"%@%@",DOMAIN_ADDRESS,api]

#define CPURL_user_SHOP_REGISTER                    CPURL(@"/api/user/register3")        //  门店注册
#define CPURL_USER_PASSWD_LOGIN                     CPURL(@"/api/user/login2")           //手机号码 + 密码登录
#define CPURL_USER_MESSAGE_CODE_LOGIN               CPURL(@"/api/user/login1")           //  手机号码 + 验证码登录
#define CPURL_USER_GET_USER_DETAIL_INFOMATION       CPURL(@"/api/user/getDetailUserInfo")    //  获取用户详细信息
#define CPURL_USER_GET_USER_BASE_INFOMATION         CPURL(@"/api/user/getBasicUserInfo") //  获取用户基本信息
#define CPURL_USER_ASSISTANT_REGISTER               CPURL(@"/api/user/register4")    // 店员注册
#define CPURL_UTIL_SEND_MESSAGE_CODE                CPURL(@"/api/user/send")
#define CPURL_UTIL_UPLOAD_IMAGE                     CPURL(@"/api/Upload/uploadImage")       //  上传图片
#define CPURL_CONFIG_HOME_AD                        CPURL(@"/api/adv/findAppHome")       // APP首页头部轮播图
#define CPURL_CONFIG_CUSTOMER_HELP                  CPURL(@"/api/Sysinfo/getSysInfo")       // 客服中心
#define CPURL_SHOP_GOOD_TYPE                        CPURL(@"/api/Goodstype/findGoodsType")       // 获取商品类型，如手机，平板
#define CPURL_SHOP_BRAND_TYPE                       CPURL(@"/api/Goodsbrand/findGoodsBrand")       // 获取手机品牌
#define CPURL_SHOP_GOOD_LIST                        CPURL(@"/api/goods/findGoods")       // 根据品牌或类型获取数据
#define CPURL_SHOP_SAVE_OWNER_INFO                  CPURL(@"/api/Reportresult/updateResult")       // 完善评估结果数据【保存出售手机人资料】
#define CPURL_SHOP_GET_RETRIEVE_DETAIL              CPURL(@"/api/Reportresult/getReportResultDetailInfo")       // 获取评估详情
#define CPURL_ASSISTANT_GET_RETRIEVE_ORDER          CPURL(@"/api/Reportresult/findReportResult")       //   获取评估列表数据
#define CPURL_ASSISTANT_UPDATE_USER_PHONE           CPURL(@"/api/user/updatePhone")       //  用户更换手机号码
#define CPURL_ASSISTANT_UPDATE_USER_PASSWD          CPURL(@"/api/user/updatePwd")       //  用户更改密码


#endif /* API_h */
