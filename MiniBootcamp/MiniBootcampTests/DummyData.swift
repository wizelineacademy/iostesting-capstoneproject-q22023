//
//  DummyData.swift
//  MiniBootcampTests
//
//  Created by Hario Budiharjo on 27/05/23.
//

import Foundation

class DummyData {
    func dummyJson() -> Data {
        let data = """
{
    "tweets": [
        {
            "created_at": "creation",
            "id_str": "id",
            "text": "This is an example",
            "user": {
                "name": "Wizeboot",
                "screen_name": "@wizeboot",
                "description": "description",
                "location": "location",
                "followers_count": 100,
                "created_at": "creation",
                "profile_background_color": "red",
                "profile_image_url": "url",
                "profile_background_image_url": "url"
            },
            "favorite_count": 100,
            "retweet_count": 10
        },
        {
            "created_at": "creation",
            "id_str": "id",
            "text": "This is an example",
            "user": {
                "name": "Wizeboot",
                "screen_name": "@wizeboot",
                "description": "description",
                "location": "location",
                "followers_count": 100,
                "created_at": "creation",
                "profile_background_color": "red",
                "profile_image_url": "url",
                "profile_background_image_url": "url"
            },
            "favorite_count": 100,
            "retweet_count": 10
        },
        {
            "created_at": "creation",
            "id_str": "id",
            "text": "This is an example",
            "user": {
                "name": "Wizeboot",
                "screen_name": "@wizeboot",
                "description": "description",
                "location": "location",
                "followers_count": 100,
                "created_at": "creation",
                "profile_background_color": "red",
                "profile_image_url": "url",
                "profile_background_image_url": "url"
            },
            "favorite_count": 100,
            "retweet_count": 10
        },
        {
            "created_at": "creation",
            "id_str": "id",
            "text": "This is an example",
            "user": {
                "name": "Wizeboot",
                "screen_name": "@wizeboot",
                "description": "description",
                "location": "location",
                "followers_count": 100,
                "created_at": "creation",
                "profile_background_color": "red",
                "profile_image_url": "url",
                "profile_background_image_url": "url"
            },
            "favorite_count": 100,
            "retweet_count": 10
        },
        {
            "created_at": "creation",
            "id_str": "id",
            "text": "This is an example",
            "user": {
                "name": "Wizeboot",
                "screen_name": "@wizeboot",
                "description": "description",
                "location": "location",
                "followers_count": 100,
                "created_at": "creation",
                "profile_background_color": "red",
                "profile_image_url": "url",
                "profile_background_image_url": "url"
            },
            "favorite_count": 100,
            "retweet_count": 10
        },
        {
            "created_at": "creation",
            "id_str": "id",
            "text": "This is an example",
            "user": {
                "name": "Wizeboot",
                "screen_name": "@wizeboot",
                "description": "description",
                "location": "location",
                "followers_count": 100,
                "created_at": "creation",
                "profile_background_color": "red",
                "profile_image_url": "url",
                "profile_background_image_url": "url"
            },
            "favorite_count": 100,
            "retweet_count": 10
        },
        {
            "created_at": "creation",
            "id_str": "id",
            "text": "This is an example",
            "user": {
                "name": "Wizeboot",
                "screen_name": "@wizeboot",
                "description": "description",
                "location": "location",
                "followers_count": 100,
                "created_at": "creation",
                "profile_background_color": "red",
                "profile_image_url": "url",
                "profile_background_image_url": "url"
            },
            "favorite_count": 100,
            "retweet_count": 10
        },
        {
            "created_at": "creation",
            "id_str": "id",
            "text": "This is an example",
            "user": {
                "name": "Wizeboot",
                "screen_name": "@wizeboot",
                "description": "description",
                "location": "location",
                "followers_count": 100,
                "created_at": "creation",
                "profile_background_color": "red",
                "profile_image_url": "url",
                "profile_background_image_url": "url"
            },
            "favorite_count": 100,
            "retweet_count": 10
        },
        {
            "created_at": "creation",
            "id_str": "id",
            "text": "This is an example",
            "user": {
                "name": "Wizeboot",
                "screen_name": "@wizeboot",
                "description": "description",
                "location": "location",
                "followers_count": 100,
                "created_at": "creation",
                "profile_background_color": "red",
                "profile_image_url": "url",
                "profile_background_image_url": "url"
            },
            "favorite_count": 100,
            "retweet_count": 10
        },
        {
            "created_at": "creation",
            "id_str": "id",
            "text": "This is an example",
            "user": {
                "name": "Wizeboot",
                "screen_name": "@wizeboot",
                "description": "description",
                "location": "location",
                "followers_count": 100,
                "created_at": "creation",
                "profile_background_color": "red",
                "profile_image_url": "url",
                "profile_background_image_url": "url"
            },
            "favorite_count": 100,
            "retweet_count": 10
        }
    ]
}
"""
        return data.data(using: .utf8)!
    }
    
    func dummyJsonWrong() -> Data {
        let data = """
{
    "tweetweet_count": 10
        }
    ]
}
"""
        return data.data(using: .utf8)!
    }
}
