import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:twitter_api/twitter_api.dart';

/// Dummy static twitter provider
///
/// This should only be used for testing
class MockTwitterApi implements twitterApi {
  /// Register with dependency injection
  static void register() =>
      GetIt.I.registerSingleton<twitterApi>(MockTwitterApi());

  @override
  Future<Response> getTwitterRequest(String method, String url,
      {Map<String, String> options, int timeout = 10}) async {
    return Response('''
[
  {
    "created_at": "Sat Sep 28 16:07:32 +0000 2019",
    "id": 1177978155560296449,
    "id_str": "1177978155560296449",
    "text": "RT @AYSO49: Valley Center games cancelled for Sept 28",
    "truncated": false,
    "entities": {
      "hashtags": [],
      "symbols": [],
      "user_mentions": [
        {
          "screen_name": "AYSO49",
          "name": "AYSO49",
          "id": 35541597,
          "id_str": "35541597",
          "indices": [
            3,
            10
          ]
        }
      ],
      "urls": []
    },
    "source": "\u003ca href=\\\"https://mobile.twitter.com\\\" rel=\\\"nofollow\\\"\u003eTwitter Web App\u003c/a\u003e",
    "in_reply_to_status_id": null,
    "in_reply_to_status_id_str": null,
    "in_reply_to_user_id": null,
    "in_reply_to_user_id_str": null,
    "in_reply_to_screen_name": null,
    "user": {
      "id": 1216439244,
      "id_str": "1216439244",
      "name": "AYSO Kansas",
      "screen_name": "AYSOKS",
      "location": "",
      "description": "",
      "url": "http://t.co/TPWQXVA0RE",
      "entities": {
        "url": {
          "urls": [
            {
              "url": "http://t.co/TPWQXVA0RE",
              "expanded_url": "http://www.aysoks.org",
              "display_url": "aysoks.org",
              "indices": [
                0,
                22
              ]
            }
          ]
        },
        "description": {
          "urls": []
        }
      },
      "protected": false,
      "followers_count": 114,
      "friends_count": 5,
      "listed_count": 0,
      "created_at": "Sun Feb 24 20:13:55 +0000 2013",
      "favourites_count": 0,
      "utc_offset": null,
      "time_zone": null,
      "geo_enabled": false,
      "verified": false,
      "statuses_count": 52,
      "lang": null,
      "contributors_enabled": false,
      "is_translator": false,
      "is_translation_enabled": false,
      "profile_background_color": "C0DEED",
      "profile_background_image_url": "http://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_image_url_https": "https://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_tile": false,
      "profile_image_url": "http://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_image_url_https": "https://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_link_color": "1DA1F2",
      "profile_sidebar_border_color": "C0DEED",
      "profile_sidebar_fill_color": "DDEEF6",
      "profile_text_color": "333333",
      "profile_use_background_image": true,
      "has_extended_profile": false,
      "default_profile": true,
      "default_profile_image": false,
      "following": false,
      "follow_request_sent": false,
      "notifications": false,
      "translator_type": "none"
    },
    "geo": null,
    "coordinates": null,
    "place": null,
    "contributors": null,
    "retweeted_status": {
      "created_at": "Sat Sep 28 16:06:12 +0000 2019",
      "id": 1177977818208243712,
      "id_str": "1177977818208243712",
      "text": "Valley Center games cancelled for Sept 28",
      "truncated": false,
      "entities": {
        "hashtags": [],
        "symbols": [],
        "user_mentions": [],
        "urls": []
      },
      "source": "\u003ca href=\\\"http://twitter.com/download/iphone\\\" rel=\\\"nofollow\\\"\u003eTwitter for iPhone\u003c/a\u003e",
      "in_reply_to_status_id": null,
      "in_reply_to_status_id_str": null,
      "in_reply_to_user_id": null,
      "in_reply_to_user_id_str": null,
      "in_reply_to_screen_name": null,
      "user": {
        "id": 35541597,
        "id_str": "35541597",
        "name": "AYSO49",
        "screen_name": "AYSO49",
        "location": "Wichita",
        "description": "",
        "url": "http://t.co/3Yx7Z7qfyP",
        "entities": {
          "url": {
            "urls": [
              {
                "url": "http://t.co/3Yx7Z7qfyP",
                "expanded_url": "http://www.ayso49.org",
                "display_url": "ayso49.org",
                "indices": [
                  0,
                  22
                ]
              }
            ]
          },
          "description": {
            "urls": []
          }
        },
        "protected": false,
        "followers_count": 184,
        "friends_count": 6,
        "listed_count": 0,
        "created_at": "Sun Apr 26 19:28:23 +0000 2009",
        "favourites_count": 1,
        "utc_offset": null,
        "time_zone": null,
        "geo_enabled": false,
        "verified": false,
        "statuses_count": 180,
        "lang": null,
        "contributors_enabled": false,
        "is_translator": false,
        "is_translation_enabled": false,
        "profile_background_color": "FFFCB3",
        "profile_background_image_url": "http://abs.twimg.com/images/themes/theme1/bg.png",
        "profile_background_image_url_https": "https://abs.twimg.com/images/themes/theme1/bg.png",
        "profile_background_tile": true,
        "profile_image_url": "http://pbs.twimg.com/profile_images/1454074374/Approved_Logo_normal.jpg",
        "profile_image_url_https": "https://pbs.twimg.com/profile_images/1454074374/Approved_Logo_normal.jpg",
        "profile_link_color": "0084B4",
        "profile_sidebar_border_color": "BDDCAD",
        "profile_sidebar_fill_color": "DDFFCC",
        "profile_text_color": "333333",
        "profile_use_background_image": true,
        "has_extended_profile": false,
        "default_profile": false,
        "default_profile_image": false,
        "following": false,
        "follow_request_sent": false,
        "notifications": false,
        "translator_type": "none"
      },
      "geo": null,
      "coordinates": null,
      "place": null,
      "contributors": null,
      "is_quote_status": false,
      "retweet_count": 1,
      "favorite_count": 0,
      "favorited": false,
      "retweeted": false,
      "lang": "en"
    },
    "is_quote_status": false,
    "retweet_count": 1,
    "favorite_count": 0,
    "favorited": false,
    "retweeted": false,
    "lang": "en"
  },
  {
    "created_at": "Sat Sep 28 15:49:19 +0000 2019",
    "id": 1177973569118191617,
    "id_str": "1177973569118191617",
    "text": "All games at 208 cancelled Sept 28.",
    "truncated": false,
    "entities": {
      "hashtags": [],
      "symbols": [],
      "user_mentions": [],
      "urls": []
    },
    "source": "\u003ca href=\\\"https://mobile.twitter.com\\\" rel=\\\"nofollow\\\"\u003eTwitter Web App\u003c/a\u003e",
    "in_reply_to_status_id": null,
    "in_reply_to_status_id_str": null,
    "in_reply_to_user_id": null,
    "in_reply_to_user_id_str": null,
    "in_reply_to_screen_name": null,
    "user": {
      "id": 1216439244,
      "id_str": "1216439244",
      "name": "AYSO Kansas",
      "screen_name": "AYSOKS",
      "location": "",
      "description": "",
      "url": "http://t.co/TPWQXVA0RE",
      "entities": {
        "url": {
          "urls": [
            {
              "url": "http://t.co/TPWQXVA0RE",
              "expanded_url": "http://www.aysoks.org",
              "display_url": "aysoks.org",
              "indices": [
                0,
                22
              ]
            }
          ]
        },
        "description": {
          "urls": []
        }
      },
      "protected": false,
      "followers_count": 114,
      "friends_count": 5,
      "listed_count": 0,
      "created_at": "Sun Feb 24 20:13:55 +0000 2013",
      "favourites_count": 0,
      "utc_offset": null,
      "time_zone": null,
      "geo_enabled": false,
      "verified": false,
      "statuses_count": 52,
      "lang": null,
      "contributors_enabled": false,
      "is_translator": false,
      "is_translation_enabled": false,
      "profile_background_color": "C0DEED",
      "profile_background_image_url": "http://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_image_url_https": "https://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_tile": false,
      "profile_image_url": "http://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_image_url_https": "https://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_link_color": "1DA1F2",
      "profile_sidebar_border_color": "C0DEED",
      "profile_sidebar_fill_color": "DDEEF6",
      "profile_text_color": "333333",
      "profile_use_background_image": true,
      "has_extended_profile": false,
      "default_profile": true,
      "default_profile_image": false,
      "following": false,
      "follow_request_sent": false,
      "notifications": false,
      "translator_type": "none"
    },
    "geo": null,
    "coordinates": null,
    "place": null,
    "contributors": null,
    "is_quote_status": false,
    "retweet_count": 1,
    "favorite_count": 0,
    "favorited": false,
    "retweeted": false,
    "lang": "en"
  },
  {
    "created_at": "Sat Sep 28 15:24:26 +0000 2019",
    "id": 1177967310222630912,
    "id_str": "1177967310222630912",
    "text": "10UB game in Clearwater cancelled Sept 28 due to weather.",
    "truncated": false,
    "entities": {
      "hashtags": [],
      "symbols": [],
      "user_mentions": [],
      "urls": []
    },
    "source": "\u003ca href=\\\"https://mobile.twitter.com\\\" rel=\\\"nofollow\\\"\u003eTwitter Web App\u003c/a\u003e",
    "in_reply_to_status_id": null,
    "in_reply_to_status_id_str": null,
    "in_reply_to_user_id": null,
    "in_reply_to_user_id_str": null,
    "in_reply_to_screen_name": null,
    "user": {
      "id": 1216439244,
      "id_str": "1216439244",
      "name": "AYSO Kansas",
      "screen_name": "AYSOKS",
      "location": "",
      "description": "",
      "url": "http://t.co/TPWQXVA0RE",
      "entities": {
        "url": {
          "urls": [
            {
              "url": "http://t.co/TPWQXVA0RE",
              "expanded_url": "http://www.aysoks.org",
              "display_url": "aysoks.org",
              "indices": [
                0,
                22
              ]
            }
          ]
        },
        "description": {
          "urls": []
        }
      },
      "protected": false,
      "followers_count": 114,
      "friends_count": 5,
      "listed_count": 0,
      "created_at": "Sun Feb 24 20:13:55 +0000 2013",
      "favourites_count": 0,
      "utc_offset": null,
      "time_zone": null,
      "geo_enabled": false,
      "verified": false,
      "statuses_count": 52,
      "lang": null,
      "contributors_enabled": false,
      "is_translator": false,
      "is_translation_enabled": false,
      "profile_background_color": "C0DEED",
      "profile_background_image_url": "http://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_image_url_https": "https://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_tile": false,
      "profile_image_url": "http://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_image_url_https": "https://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_link_color": "1DA1F2",
      "profile_sidebar_border_color": "C0DEED",
      "profile_sidebar_fill_color": "DDEEF6",
      "profile_text_color": "333333",
      "profile_use_background_image": true,
      "has_extended_profile": false,
      "default_profile": true,
      "default_profile_image": false,
      "following": false,
      "follow_request_sent": false,
      "notifications": false,
      "translator_type": "none"
    },
    "geo": null,
    "coordinates": null,
    "place": null,
    "contributors": null,
    "is_quote_status": false,
    "retweet_count": 0,
    "favorite_count": 0,
    "favorited": false,
    "retweeted": false,
    "lang": "en"
  },
  {
    "created_at": "Sun Mar 03 02:49:31 +0000 2019",
    "id": 1102038261541744641,
    "id_str": "1102038261541744641",
    "text": "March 9 games rescheduled. No games March 9. Season to start March 16.",
    "truncated": false,
    "entities": {
      "hashtags": [],
      "symbols": [],
      "user_mentions": [],
      "urls": []
    },
    "source": "\u003ca href=\\\"http://twitter.com\\\" rel=\\\"nofollow\\\"\u003eTwitter Web Client\u003c/a\u003e",
    "in_reply_to_status_id": null,
    "in_reply_to_status_id_str": null,
    "in_reply_to_user_id": null,
    "in_reply_to_user_id_str": null,
    "in_reply_to_screen_name": null,
    "user": {
      "id": 1216439244,
      "id_str": "1216439244",
      "name": "AYSO Kansas",
      "screen_name": "AYSOKS",
      "location": "",
      "description": "",
      "url": "http://t.co/TPWQXVA0RE",
      "entities": {
        "url": {
          "urls": [
            {
              "url": "http://t.co/TPWQXVA0RE",
              "expanded_url": "http://www.aysoks.org",
              "display_url": "aysoks.org",
              "indices": [
                0,
                22
              ]
            }
          ]
        },
        "description": {
          "urls": []
        }
      },
      "protected": false,
      "followers_count": 114,
      "friends_count": 5,
      "listed_count": 0,
      "created_at": "Sun Feb 24 20:13:55 +0000 2013",
      "favourites_count": 0,
      "utc_offset": null,
      "time_zone": null,
      "geo_enabled": false,
      "verified": false,
      "statuses_count": 52,
      "lang": null,
      "contributors_enabled": false,
      "is_translator": false,
      "is_translation_enabled": false,
      "profile_background_color": "C0DEED",
      "profile_background_image_url": "http://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_image_url_https": "https://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_tile": false,
      "profile_image_url": "http://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_image_url_https": "https://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_link_color": "1DA1F2",
      "profile_sidebar_border_color": "C0DEED",
      "profile_sidebar_fill_color": "DDEEF6",
      "profile_text_color": "333333",
      "profile_use_background_image": true,
      "has_extended_profile": false,
      "default_profile": true,
      "default_profile_image": false,
      "following": false,
      "follow_request_sent": false,
      "notifications": false,
      "translator_type": "none"
    },
    "geo": null,
    "coordinates": null,
    "place": null,
    "contributors": null,
    "is_quote_status": false,
    "retweet_count": 0,
    "favorite_count": 0,
    "favorited": false,
    "retweeted": false,
    "lang": "en"
  },
  {
    "created_at": "Thu Sep 27 02:32:32 +0000 2018",
    "id": 1045139093255065600,
    "id_str": "1045139093255065600",
    "text": "We are trying to identify any candidates for Intermediate Coach.  If interested, contact Nyles at 316.305.9622",
    "truncated": false,
    "entities": {
      "hashtags": [],
      "symbols": [],
      "user_mentions": [],
      "urls": []
    },
    "source": "\u003ca href=\\\"http://twitter.com\\\" rel=\\\"nofollow\\\"\u003eTwitter Web Client\u003c/a\u003e",
    "in_reply_to_status_id": null,
    "in_reply_to_status_id_str": null,
    "in_reply_to_user_id": null,
    "in_reply_to_user_id_str": null,
    "in_reply_to_screen_name": null,
    "user": {
      "id": 1216439244,
      "id_str": "1216439244",
      "name": "AYSO Kansas",
      "screen_name": "AYSOKS",
      "location": "",
      "description": "",
      "url": "http://t.co/TPWQXVA0RE",
      "entities": {
        "url": {
          "urls": [
            {
              "url": "http://t.co/TPWQXVA0RE",
              "expanded_url": "http://www.aysoks.org",
              "display_url": "aysoks.org",
              "indices": [
                0,
                22
              ]
            }
          ]
        },
        "description": {
          "urls": []
        }
      },
      "protected": false,
      "followers_count": 114,
      "friends_count": 5,
      "listed_count": 0,
      "created_at": "Sun Feb 24 20:13:55 +0000 2013",
      "favourites_count": 0,
      "utc_offset": null,
      "time_zone": null,
      "geo_enabled": false,
      "verified": false,
      "statuses_count": 52,
      "lang": null,
      "contributors_enabled": false,
      "is_translator": false,
      "is_translation_enabled": false,
      "profile_background_color": "C0DEED",
      "profile_background_image_url": "http://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_image_url_https": "https://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_tile": false,
      "profile_image_url": "http://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_image_url_https": "https://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_link_color": "1DA1F2",
      "profile_sidebar_border_color": "C0DEED",
      "profile_sidebar_fill_color": "DDEEF6",
      "profile_text_color": "333333",
      "profile_use_background_image": true,
      "has_extended_profile": false,
      "default_profile": true,
      "default_profile_image": false,
      "following": false,
      "follow_request_sent": false,
      "notifications": false,
      "translator_type": "none"
    },
    "geo": null,
    "coordinates": null,
    "place": null,
    "contributors": null,
    "is_quote_status": false,
    "retweet_count": 0,
    "favorite_count": 0,
    "favorited": false,
    "retweeted": false,
    "lang": "en"
  },
  {
    "created_at": "Fri Sep 14 02:05:21 +0000 2018",
    "id": 1040421209542942720,
    "id_str": "1040421209542942720",
    "text": "Fall season schedules posted Tuesday morning!",
    "truncated": false,
    "entities": {
      "hashtags": [],
      "symbols": [],
      "user_mentions": [],
      "urls": []
    },
    "source": "\u003ca href=\\\"http://twitter.com\\\" rel=\\\"nofollow\\\"\u003eTwitter Web Client\u003c/a\u003e",
    "in_reply_to_status_id": null,
    "in_reply_to_status_id_str": null,
    "in_reply_to_user_id": null,
    "in_reply_to_user_id_str": null,
    "in_reply_to_screen_name": null,
    "user": {
      "id": 1216439244,
      "id_str": "1216439244",
      "name": "AYSO Kansas",
      "screen_name": "AYSOKS",
      "location": "",
      "description": "",
      "url": "http://t.co/TPWQXVA0RE",
      "entities": {
        "url": {
          "urls": [
            {
              "url": "http://t.co/TPWQXVA0RE",
              "expanded_url": "http://www.aysoks.org",
              "display_url": "aysoks.org",
              "indices": [
                0,
                22
              ]
            }
          ]
        },
        "description": {
          "urls": []
        }
      },
      "protected": false,
      "followers_count": 114,
      "friends_count": 5,
      "listed_count": 0,
      "created_at": "Sun Feb 24 20:13:55 +0000 2013",
      "favourites_count": 0,
      "utc_offset": null,
      "time_zone": null,
      "geo_enabled": false,
      "verified": false,
      "statuses_count": 52,
      "lang": null,
      "contributors_enabled": false,
      "is_translator": false,
      "is_translation_enabled": false,
      "profile_background_color": "C0DEED",
      "profile_background_image_url": "http://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_image_url_https": "https://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_tile": false,
      "profile_image_url": "http://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_image_url_https": "https://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_link_color": "1DA1F2",
      "profile_sidebar_border_color": "C0DEED",
      "profile_sidebar_fill_color": "DDEEF6",
      "profile_text_color": "333333",
      "profile_use_background_image": true,
      "has_extended_profile": false,
      "default_profile": true,
      "default_profile_image": false,
      "following": false,
      "follow_request_sent": false,
      "notifications": false,
      "translator_type": "none"
    },
    "geo": null,
    "coordinates": null,
    "place": null,
    "contributors": null,
    "is_quote_status": false,
    "retweet_count": 0,
    "favorite_count": 0,
    "favorited": false,
    "retweeted": false,
    "lang": "en"
  },
  {
    "created_at": "Fri Apr 06 23:07:27 +0000 2018",
    "id": 982394381419384834,
    "id_str": "982394381419384834",
    "text": "All soccer games at all regions are cancelled for April 7.",
    "truncated": false,
    "entities": {
      "hashtags": [],
      "symbols": [],
      "user_mentions": [],
      "urls": []
    },
    "source": "\u003ca href=\\\"https://mobile.twitter.com\\\" rel=\\\"nofollow\\\"\u003eTwitter Web App\u003c/a\u003e",
    "in_reply_to_status_id": null,
    "in_reply_to_status_id_str": null,
    "in_reply_to_user_id": null,
    "in_reply_to_user_id_str": null,
    "in_reply_to_screen_name": null,
    "user": {
      "id": 1216439244,
      "id_str": "1216439244",
      "name": "AYSO Kansas",
      "screen_name": "AYSOKS",
      "location": "",
      "description": "",
      "url": "http://t.co/TPWQXVA0RE",
      "entities": {
        "url": {
          "urls": [
            {
              "url": "http://t.co/TPWQXVA0RE",
              "expanded_url": "http://www.aysoks.org",
              "display_url": "aysoks.org",
              "indices": [
                0,
                22
              ]
            }
          ]
        },
        "description": {
          "urls": []
        }
      },
      "protected": false,
      "followers_count": 114,
      "friends_count": 5,
      "listed_count": 0,
      "created_at": "Sun Feb 24 20:13:55 +0000 2013",
      "favourites_count": 0,
      "utc_offset": null,
      "time_zone": null,
      "geo_enabled": false,
      "verified": false,
      "statuses_count": 52,
      "lang": null,
      "contributors_enabled": false,
      "is_translator": false,
      "is_translation_enabled": false,
      "profile_background_color": "C0DEED",
      "profile_background_image_url": "http://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_image_url_https": "https://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_tile": false,
      "profile_image_url": "http://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_image_url_https": "https://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_link_color": "1DA1F2",
      "profile_sidebar_border_color": "C0DEED",
      "profile_sidebar_fill_color": "DDEEF6",
      "profile_text_color": "333333",
      "profile_use_background_image": true,
      "has_extended_profile": false,
      "default_profile": true,
      "default_profile_image": false,
      "following": false,
      "follow_request_sent": false,
      "notifications": false,
      "translator_type": "none"
    },
    "geo": null,
    "coordinates": null,
    "place": null,
    "contributors": null,
    "is_quote_status": false,
    "retweet_count": 2,
    "favorite_count": 1,
    "favorited": false,
    "retweeted": false,
    "lang": "en"
  },
  {
    "created_at": "Fri Sep 22 14:51:22 +0000 2017",
    "id": 911241517125165057,
    "id_str": "911241517125165057",
    "text": "All 12UG schedules added for weeks 3 through 8. All 6UB schedules at Stryker revised.",
    "truncated": false,
    "entities": {
      "hashtags": [],
      "symbols": [],
      "user_mentions": [],
      "urls": []
    },
    "source": "\u003ca href=\\\"https://mobile.twitter.com\\\" rel=\\\"nofollow\\\"\u003eTwitter Web App\u003c/a\u003e",
    "in_reply_to_status_id": null,
    "in_reply_to_status_id_str": null,
    "in_reply_to_user_id": null,
    "in_reply_to_user_id_str": null,
    "in_reply_to_screen_name": null,
    "user": {
      "id": 1216439244,
      "id_str": "1216439244",
      "name": "AYSO Kansas",
      "screen_name": "AYSOKS",
      "location": "",
      "description": "",
      "url": "http://t.co/TPWQXVA0RE",
      "entities": {
        "url": {
          "urls": [
            {
              "url": "http://t.co/TPWQXVA0RE",
              "expanded_url": "http://www.aysoks.org",
              "display_url": "aysoks.org",
              "indices": [
                0,
                22
              ]
            }
          ]
        },
        "description": {
          "urls": []
        }
      },
      "protected": false,
      "followers_count": 114,
      "friends_count": 5,
      "listed_count": 0,
      "created_at": "Sun Feb 24 20:13:55 +0000 2013",
      "favourites_count": 0,
      "utc_offset": null,
      "time_zone": null,
      "geo_enabled": false,
      "verified": false,
      "statuses_count": 52,
      "lang": null,
      "contributors_enabled": false,
      "is_translator": false,
      "is_translation_enabled": false,
      "profile_background_color": "C0DEED",
      "profile_background_image_url": "http://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_image_url_https": "https://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_tile": false,
      "profile_image_url": "http://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_image_url_https": "https://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_link_color": "1DA1F2",
      "profile_sidebar_border_color": "C0DEED",
      "profile_sidebar_fill_color": "DDEEF6",
      "profile_text_color": "333333",
      "profile_use_background_image": true,
      "has_extended_profile": false,
      "default_profile": true,
      "default_profile_image": false,
      "following": false,
      "follow_request_sent": false,
      "notifications": false,
      "translator_type": "none"
    },
    "geo": null,
    "coordinates": null,
    "place": null,
    "contributors": null,
    "is_quote_status": false,
    "retweet_count": 0,
    "favorite_count": 0,
    "favorited": false,
    "retweeted": false,
    "lang": "en"
  },
  {
    "created_at": "Sat Apr 29 12:39:30 +0000 2017",
    "id": 858299701854179328,
    "id_str": "858299701854179328",
    "text": "All games at all regions are cancelled for April 29.",
    "truncated": false,
    "entities": {
      "hashtags": [],
      "symbols": [],
      "user_mentions": [],
      "urls": []
    },
    "source": "\u003ca href=\\\"https://mobile.twitter.com\\\" rel=\\\"nofollow\\\"\u003eTwitter Web App\u003c/a\u003e",
    "in_reply_to_status_id": null,
    "in_reply_to_status_id_str": null,
    "in_reply_to_user_id": null,
    "in_reply_to_user_id_str": null,
    "in_reply_to_screen_name": null,
    "user": {
      "id": 1216439244,
      "id_str": "1216439244",
      "name": "AYSO Kansas",
      "screen_name": "AYSOKS",
      "location": "",
      "description": "",
      "url": "http://t.co/TPWQXVA0RE",
      "entities": {
        "url": {
          "urls": [
            {
              "url": "http://t.co/TPWQXVA0RE",
              "expanded_url": "http://www.aysoks.org",
              "display_url": "aysoks.org",
              "indices": [
                0,
                22
              ]
            }
          ]
        },
        "description": {
          "urls": []
        }
      },
      "protected": false,
      "followers_count": 114,
      "friends_count": 5,
      "listed_count": 0,
      "created_at": "Sun Feb 24 20:13:55 +0000 2013",
      "favourites_count": 0,
      "utc_offset": null,
      "time_zone": null,
      "geo_enabled": false,
      "verified": false,
      "statuses_count": 52,
      "lang": null,
      "contributors_enabled": false,
      "is_translator": false,
      "is_translation_enabled": false,
      "profile_background_color": "C0DEED",
      "profile_background_image_url": "http://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_image_url_https": "https://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_tile": false,
      "profile_image_url": "http://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_image_url_https": "https://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_link_color": "1DA1F2",
      "profile_sidebar_border_color": "C0DEED",
      "profile_sidebar_fill_color": "DDEEF6",
      "profile_text_color": "333333",
      "profile_use_background_image": true,
      "has_extended_profile": false,
      "default_profile": true,
      "default_profile_image": false,
      "following": false,
      "follow_request_sent": false,
      "notifications": false,
      "translator_type": "none"
    },
    "geo": null,
    "coordinates": null,
    "place": null,
    "contributors": null,
    "is_quote_status": false,
    "retweet_count": 0,
    "favorite_count": 0,
    "favorited": false,
    "retweeted": false,
    "lang": "en"
  },
  {
    "created_at": "Sat Apr 22 12:01:21 +0000 2017",
    "id": 855753387786350592,
    "id_str": "855753387786350592",
    "text": "All games at AYSO Region 49 for April 22 have been cancelled because of wet fields.",
    "truncated": false,
    "entities": {
      "hashtags": [],
      "symbols": [],
      "user_mentions": [],
      "urls": []
    },
    "source": "\u003ca href=\\\"https://mobile.twitter.com\\\" rel=\\\"nofollow\\\"\u003eTwitter Web App\u003c/a\u003e",
    "in_reply_to_status_id": null,
    "in_reply_to_status_id_str": null,
    "in_reply_to_user_id": null,
    "in_reply_to_user_id_str": null,
    "in_reply_to_screen_name": null,
    "user": {
      "id": 1216439244,
      "id_str": "1216439244",
      "name": "AYSO Kansas",
      "screen_name": "AYSOKS",
      "location": "",
      "description": "",
      "url": "http://t.co/TPWQXVA0RE",
      "entities": {
        "url": {
          "urls": [
            {
              "url": "http://t.co/TPWQXVA0RE",
              "expanded_url": "http://www.aysoks.org",
              "display_url": "aysoks.org",
              "indices": [
                0,
                22
              ]
            }
          ]
        },
        "description": {
          "urls": []
        }
      },
      "protected": false,
      "followers_count": 114,
      "friends_count": 5,
      "listed_count": 0,
      "created_at": "Sun Feb 24 20:13:55 +0000 2013",
      "favourites_count": 0,
      "utc_offset": null,
      "time_zone": null,
      "geo_enabled": false,
      "verified": false,
      "statuses_count": 52,
      "lang": null,
      "contributors_enabled": false,
      "is_translator": false,
      "is_translation_enabled": false,
      "profile_background_color": "C0DEED",
      "profile_background_image_url": "http://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_image_url_https": "https://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_tile": false,
      "profile_image_url": "http://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_image_url_https": "https://pbs.twimg.com/profile_images/3303436294/f95cc04541662eb40a2a2227de69550e_normal.png",
      "profile_link_color": "1DA1F2",
      "profile_sidebar_border_color": "C0DEED",
      "profile_sidebar_fill_color": "DDEEF6",
      "profile_text_color": "333333",
      "profile_use_background_image": true,
      "has_extended_profile": false,
      "default_profile": true,
      "default_profile_image": false,
      "following": false,
      "follow_request_sent": false,
      "notifications": false,
      "translator_type": "none"
    },
    "geo": null,
    "coordinates": null,
    "place": null,
    "contributors": null,
    "is_quote_status": false,
    "retweet_count": 0,
    "favorite_count": 0,
    "favorited": false,
    "retweeted": false,
    "lang": "en"
  }
]
    ''', 200);
  }
}
