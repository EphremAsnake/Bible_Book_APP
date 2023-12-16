import 'dart:convert';

Configs configsFromJson(String str) => Configs.fromJson(json.decode(str));

String configsToJson(Configs data) => json.encode(data.toJson());

class Configs {
    AppRateShare appRateShare;
    AppConfig appConfig;
    List<HouseAd> houseAds;
    String aboutApp;

    Configs({
        required this.appRateShare,
        required this.appConfig,
        required this.houseAds,
        required this.aboutApp,
    });

    factory Configs.fromJson(Map<String, dynamic> json) => Configs(
        appRateShare: AppRateShare.fromJson(json["app_rate_share"]),
        appConfig: AppConfig.fromJson(json["app_config"]),
        houseAds: List<HouseAd>.from(json["house_ads"].map((x) => HouseAd.fromJson(x))),
        aboutApp: json["about_app"],
    );

    Map<String, dynamic> toJson() => {
        "app_rate_share": appRateShare.toJson(),
        "app_config": appConfig.toJson(),
        "house_ads": List<dynamic>.from(houseAds.map((x) => x.toJson())),
        "about_app": aboutApp,
    };
}

class AppConfig {
    AppColors appColors;

    AppConfig({
        required this.appColors,
    });

    factory AppConfig.fromJson(Map<String, dynamic> json) => AppConfig(
        appColors: AppColors.fromJson(json["app_colors"]),
    );

    Map<String, dynamic> toJson() => {
        "app_colors": appColors.toJson(),
    };
}

class AppColors {
    String whiteColor;
    String backgroundColor;
    String primaryColor;
    String blackColor;
    String grayTextColor;
    String shadowColor;
    String splashColor;
    String errorColor;
    String lightGrey;

    AppColors({
        required this.whiteColor,
        required this.backgroundColor,
        required this.primaryColor,
        required this.blackColor,
        required this.grayTextColor,
        required this.shadowColor,
        required this.splashColor,
        required this.errorColor,
        required this.lightGrey,
    });

    factory AppColors.fromJson(Map<String, dynamic> json) => AppColors(
        whiteColor: json["white_color"],
        backgroundColor: json["background_color"],
        primaryColor: json["primary_color"],
        blackColor: json["black_color"],
        grayTextColor: json["gray_text_color"],
        shadowColor: json["shadow_color"],
        splashColor: json["splash_color"],
        errorColor: json["error_color"],
        lightGrey: json["light_grey"],
    );

    Map<String, dynamic> toJson() => {
        "white_color": whiteColor,
        "background_color": backgroundColor,
        "primary_color": primaryColor,
        "black_color": blackColor,
        "gray_text_color": grayTextColor,
        "shadow_color": shadowColor,
        "splash_color": splashColor,
        "error_color": errorColor,
        "light_grey": lightGrey,
    };
}

class AppRateShare {
    String iosId;
    String androidId;
    String iosShare;
    String androidShare;

    AppRateShare({
        required this.iosId,
        required this.androidId,
        required this.iosShare,
        required this.androidShare,
    });

    factory AppRateShare.fromJson(Map<String, dynamic> json) => AppRateShare(
        iosId: json["ios_id"],
        androidId: json["android_id"],
        iosShare: json["ios_share"],
        androidShare: json["android_share"],
    );

    Map<String, dynamic> toJson() => {
        "ios_id": iosId,
        "android_id": androidId,
        "ios_share": iosShare,
        "android_share": androidShare,
    };
}

class HouseAd {
    HouseAd1Class? houseAd1;
    HouseAd1Class? houseAd2;

    HouseAd({
        this.houseAd1,
        this.houseAd2,
    });

    factory HouseAd.fromJson(Map<String, dynamic> json) => HouseAd(
        houseAd1: json["house_ad_1"] == null ? null : HouseAd1Class.fromJson(json["house_ad_1"]),
        houseAd2: json["house_ad_2"] == null ? null : HouseAd1Class.fromJson(json["house_ad_2"]),
    );

    Map<String, dynamic> toJson() => {
        "house_ad_1": houseAd1?.toJson(),
        "house_ad_2": houseAd2?.toJson(),
    };
}

class HouseAd1Class {
    String title;
    String buttonText;
    bool show;
    bool openInAppBrowser;
    String iosUrl;
    String androidUrl;

    HouseAd1Class({
        required this.title,
        required this.buttonText,
        required this.show,
        required this.openInAppBrowser,
        required this.iosUrl,
        required this.androidUrl,
    });

    factory HouseAd1Class.fromJson(Map<String, dynamic> json) => HouseAd1Class(
        title: json["title"],
        buttonText: json["button_text"],
        show: json["show"],
        openInAppBrowser: json["open_in_app_browser"],
        iosUrl: json["ios_url"],
        androidUrl: json["android_url"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "button_text": buttonText,
        "show": show,
        "open_in_app_browser": openInAppBrowser,
        "ios_url": iosUrl,
        "android_url": androidUrl,
    };
}
