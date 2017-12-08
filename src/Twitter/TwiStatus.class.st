"
I represent a status (a twit) from twitter.

https://developer.twitter.com/en/docs/tweets/data-dictionary/overview/tweet-object
"
Class {
	#name : #TwiStatus,
	#superclass : #TwiEntity,
	#instVars : [
		'login'
	],
	#category : #Twitter
}

{ #category : #'instance creation' }
TwiStatus class >> login: aLogin json: aJson [
	^ self new 
		login: aLogin;
		json: aJson;
		yourself
]

{ #category : #'accessing api' }
TwiStatus >> coordinates [
	"Nullable. Represents the geographic location of this Tweet as reported by the user or client application. The inner coordinates array is formatted as geoJSON (longitude first, then latitude)."
	^ self jsonAt: 'coordinates'
]

{ #category : #'accessing api' }
TwiStatus >> createdAt [
	"UTC time when this Tweet was created"
	^ self jsonAt: 'created_at'
]

{ #category : #'accessing api' }
TwiStatus >> entities [
	"Entities which have been parsed out of the text of the Tweet. Additionally see Entities in Twitter Objects."
	^ self jsonAt: 'entities'
]

{ #category : #'accessing api' }
TwiStatus >> extendedEntities [
	"When between one and four native photos or one video or one animated GIF are in Tweet, contains an array 'media' metadata. Additionally see Entities in Twitter Objects."
	^ self jsonAt: 'extended_entities'
]

{ #category : #'accessing api' }
TwiStatus >> favoriteCount [
	"Nullable. Indicates approximately how many times this Tweet has been liked by Twitter users."
	^ self jsonAt: 'favorite_count'
]

{ #category : #'accessing api' }
TwiStatus >> filterLevel [
	"Indicates the maximum value of the filter_level parameter which may be used and still stream this Tweet. So a value of medium will be streamed on none, low, and medium streams."
	^ self jsonAt: 'filter_level'
]

{ #category : #'accessing api' }
TwiStatus >> fullText [
	"undocumented?"
	^ self jsonAt: 'full_text'
]

{ #category : #gtinspector }
TwiStatus >> gtInspectorStatusIn: composite [
	<gtInspectorPresentationOrder: 0>  
	 
	composite text
		title: self user screenName, ' at ', self createdAt;
		display: self fullText
]

{ #category : #'accessing api' }
TwiStatus >> id [
	"The integer representation of the unique identifier for this Tweet. This number is greater than 53 bits and some programming languages may have difficulty/silent defects in interpreting it. Using a signed 64 bit integer for storing this identifier is safe. Use id_str for fetching the identifier to stay on the safe side. See Twitter IDs, JSON and Snowflake"
	^ self jsonAt: 'id'
]

{ #category : #'accessing api' }
TwiStatus >> idStr [
	"The string representation of the unique identifier for this Tweet. Implementations should use this rather than the large integer in id"
	^ self jsonAt: 'id_str'
]

{ #category : #'accessing api' }
TwiStatus >> inReplyToScreenName [
	"Nullable. If the represented Tweet is a reply, this field will contain the screen name of the original Tweet’s author."
	^ self jsonAt: 'in_reply_to_screen_name'
]

{ #category : #'accessing api' }
TwiStatus >> inReplyToStatusId [
	"Nullable. If the represented Tweet is a reply, this field will contain the integer representation of the original Tweet’s ID."
	^ self jsonAt: 'in_reply_to_status_id'
]

{ #category : #'accessing api' }
TwiStatus >> inReplyToStatusIdStr [
	"Nullable. If the represented Tweet is a reply, this field will contain the string representation of the original Tweet’s ID."
	^ self jsonAt: 'in_reply_to_status_id_str'
]

{ #category : #'accessing api' }
TwiStatus >> inReplyToUserId [
	"Nullable. If the represented Tweet is a reply, this field will contain the integer representation of the original Tweet’s author ID. This will not necessarily always be the user directly mentioned in the Tweet."
	^ self jsonAt: 'in_reply_to_user_id'
]

{ #category : #'accessing api' }
TwiStatus >> inReplyToUserIdStr [
	"Nullable. If the represented Tweet is a reply, this field will contain the string representation of the original Tweet’s author ID. This will not necessarily always be the user directly mentioned in the Tweet."
	^ self jsonAt: 'in_reply_to_user_id_str'
]

{ #category : #'accessing api' }
TwiStatus >> isFavorited [
	"Nullable. Indicates whether this Tweet has been liked by the authenticating user."
	^ self jsonAt: 'favorited'
]

{ #category : #'accessing api' }
TwiStatus >> isPossiblySensitive [
	"Nullable. This field only surfaces when a Tweet contains a link. The meaning of the field doesn’t pertain to the Tweet content itself, but instead it is an indicator that the URL contained in the Tweet may contain content or media identified as sensitive content."
	^ self jsonAt: 'possibly_sensitive'
]

{ #category : #'accessing api' }
TwiStatus >> isQuoteStatus [
	"Indicates whether this is a Quoted Tweet."
	^ self jsonAt: 'is_quote_status'
]

{ #category : #'accessing api' }
TwiStatus >> isRetweeted [
	"Indicates whether this Tweet has been Retweeted by the authenticating user."
	^ self jsonAt: 'retweeted'
]

{ #category : #'accessing api' }
TwiStatus >> isTruncated [
	"Indicates whether the value of the text parameter was truncated, for example, as a result of a retweet exceeding the original Tweet text length limit of 140 characters. Truncated text will end in ellipsis, like this ... Since Twitter now rejects long Tweets vs truncating them, the large majority of Tweets will have this set to false . Note that while native retweets may have their toplevel text property shortened, the original text will be available under the retweeted_status object and the truncated parameter will be set to the value of the original status (in most cases, false )."
	^ self jsonAt: 'truncated'
]

{ #category : #'accessing api' }
TwiStatus >> lang [
	"Nullable. When present, indicates a BCP 47 language identifier corresponding to the machine-detected language of the Tweet text, or und if no language could be detected."
	^ self jsonAt: 'lang'
]

{ #category : #accessing }
TwiStatus >> login [
	^ login
]

{ #category : #accessing }
TwiStatus >> login: anObject [
	login := anObject
]

{ #category : #'accessing api' }
TwiStatus >> matchingRules [
	"Present in filtered products such as Twitter Search and PowerTrack. Provides the id and tag associated with the rule that matched the Tweet. With PowerTrack, more than one rule can match a Tweet."
	^ self jsonAt: 'matching_rules'
]

{ #category : #'accessing api' }
TwiStatus >> place [
	"Nullable When present, indicates that the tweet is associated (but not necessarily originating from) a Place."
	^ self jsonAt: 'place'
]

{ #category : #'accessing api' }
TwiStatus >> quoteCount [
	"Nullable. Indicates approximately how many times this Tweet has been quoted by Twitter users."
	^ self jsonAt: 'quote_count'
]

{ #category : #'accessing api' }
TwiStatus >> quotedStatus [
	"This field only surfaces when the Tweet is a quote Tweet. This field contains the integer value Tweet ID of the quoted Tweet."
	^ self 
		jsonAt: 'quoted_status' 
		ifPresent: [ :aJson | TwiStatus login: self login json: aJson ]
		ifAbsent: [ nil ]
]

{ #category : #'accessing api' }
TwiStatus >> quotedStatusId [
	"This field only surfaces when the Tweet is a quote Tweet. This field contains the integer value Tweet ID of the quoted Tweet."
	^ self jsonAt: 'quoted_status_id'
]

{ #category : #'accessing api' }
TwiStatus >> quotedStatusIdStr [
	"This field only surfaces when the Tweet is a quote Tweet. This is the string representation Tweet ID of the quoted Tweet."
	^ self jsonAt: 'quoted_status_id_str'
]

{ #category : #'accessing api' }
TwiStatus >> replyCount [
	"Number of times this Tweet has been replied to."
	^ self jsonAt: 'reply_count'
]

{ #category : #'accessing api' }
TwiStatus >> retweetCount [
	"Number of times this Tweet has been retweeted."
	^ self jsonAt: 'retweet_count'
]

{ #category : #'accessing api' }
TwiStatus >> retweetedStatus [
	"Users can amplify the broadcast of Tweets authored by other users by retweeting . Retweets can be distinguished from typical Tweets by the existence of a retweeted_status attribute. This attribute contains a representation of the original Tweet that was retweeted. Note that retweets of retweets do not show representations of the intermediary retweet, but only the original Tweet. (Users can also unretweet a retweet they created by deleting their retweet.)"
	^ self 
		jsonAt: 'retweeted_status' 
		ifPresent: [ :aJson | TwiStatus login: self login json: aJson ]
		ifAbsent: [ nil ]
]

{ #category : #'accessing api' }
TwiStatus >> source [
	"Utility used to post the Tweet, as an HTML-formatted string. Tweets from the Twitter website have a source value of web."
	^ self jsonAt: 'source'
]

{ #category : #'accessing api' }
TwiStatus >> text [
	"The actual UTF-8 text of the status update. See twitter-text for details on what characters are currently considered valid."
	^ self jsonAt: 'text'
]

{ #category : #'accessing api' }
TwiStatus >> user [
	"The user who posted this Tweet. See User data dictionary for complete list of attributes."
	^ TwiUser json: (self jsonAt: 'user')
]
