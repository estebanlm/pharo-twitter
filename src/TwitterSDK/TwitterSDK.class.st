"
I am TwitterSDK, an object to interact with the Twitter API (version 1.1). More info at <https://brackendev.github.io/TwitterSDK-Pharo/>.

Example usage:

	twitter := TwitterSDK createWithConsumerKey: CONSUMER_KEY consumerSecret: CONSUMER_SECRET accessToken: ACCESS_TOKEN accessTokenSecret: TOKEN_SECRET.
	twitter friendshipsCreateWithScreenName: 'brackendev' userID: nil follow: true.
"
Class {
	#name : #TwitterSDK,
	#superclass : #Object,
	#instVars : [
		'service',
		'accessToken',
		'userAccess'
	],
	#category : #TwitterSDK
}

{ #category : #public }
TwitterSDK class >> createWithConsumerKey: consumerKey consumerSecret: consumerSecret accessToken: aToken accessTokenSecret: aTokenSecret [
	"Do this before anything else"

	"Setup your app at https://apps.twitter.com/app/"

	| consumerData accessTokenDict userAccess service accessToken |
	consumerData := ZnOAuth1ConsumerData newForTwitterAuthentication.
	consumerData consumer: consumerKey.
	consumerData consumerSecret: consumerSecret.
	service := ZnOAuth1Service new.
	service providerAccount: consumerData.
	accessTokenDict := Dictionary new.
	accessTokenDict at: 'oauth_token' put: aToken.
	accessTokenDict at: 'oauth_token_secret' put: aTokenSecret.
	accessToken := ZnOAuth1Token newFromDictionary: accessTokenDict.
	userAccess := ZnOAuth1TwitterUserAccess new oauth1Service: service.
	userAccess accessToken: accessToken.
	^ self new
		service: service;
		userAccess: userAccess;
		accessToken: accessToken;
		yourself
]

{ #category : #private }
TwitterSDK class >> defaultAccessToken [
	"Private use"

	^ ZnOAuth1Token new
]

{ #category : #private }
TwitterSDK class >> defaultService [
	"Private use"

	^ ZnOAuth1Service new
]

{ #category : #private }
TwitterSDK class >> defaultUserAccess [
	"Private use"

	^ ZnOAuth1TwitterUserAccess new
]

{ #category : #'private - accessing' }
TwitterSDK >> accessToken [
	"Private use"

	^ accessToken ifNil: [ accessToken := self class defaultAccessToken ]
]

{ #category : #'private - accessing' }
TwitterSDK >> accessToken: aZnOAuth1Token [
	"Private use"

	accessToken := aZnOAuth1Token
]

{ #category : #'Twitter account' }
TwitterSDK >> accountRemovePofileBanner [
	"https://dev.twitter.com/rest/reference/post/account/remove_profile_banner"

	^ self
		executePOSTRequestWithURL:
			(TwitterSDKZnUrl create
				addPathSegment: 'account';
				addPathSegment: 'remove_profile_banner.json')
]

{ #category : #'Twitter account' }
TwitterSDK >> accountSettings [
	"https://dev.twitter.com/rest/reference/get/account/settings"

	^self
		executeGETRequestWithURL:
			(TwitterSDKZnUrl create
				addPathSegment: 'account';
				addPathSegment: 'settings.json')
]

{ #category : #'Twitter account' }
TwitterSDK >> accountUpdateProfileBackgroundImage: image title: tile includeEntities: includeEntities skipStatus: skipStatus mediaID: mediaID [
	"https://dev.twitter.com/rest/reference/post/account/update_profile_background_image"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'account';
		addPathSegment: 'update_profile_image.json'.
	image ifNotNil: [ u queryAt: 'image' put: image ].	" TODO based on #mediaUploadFile:"
	tile ifNotNil: [ u queryAt: 'tile' put: tile ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	skipStatus ifNotNil: [ u queryAt: 'skip_status' put: skipStatus ].
	mediaID ifNotNil: [ u queryAt: 'media_id' put: mediaID ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter account' }
TwitterSDK >> accountUpdateProfileBanner: image width: width height: height offsetLeft: offsetLeft offsetRight: offsetRight [
	"https://dev.twitter.com/rest/reference/post/account/update_profile_banner"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'account';
		addPathSegment: 'update_profile_banner.json'.
	image ifNotNil: [ u queryAt: 'banner' put: image ]. " TODO based on #mediaUploadFile:"
	width ifNotNil: [ u queryAt: 'width' put: width ].
	height ifNotNil: [ u queryAt: 'height' put: height ].
	offsetLeft ifNotNil: [ u queryAt: 'offset_left' put: offsetLeft ].
	offsetRight ifNotNil: [ u queryAt: 'offset_right' put: offsetRight ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter account' }
TwitterSDK >> accountUpdateProfileWithName: name url: url location: location description: description profileLinkColor: linkColor includeEntities: includeEntities skipStatus: skipStatus [
	"https://dev.twitter.com/rest/reference/post/account/update_profile"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'account';
		addPathSegment: 'update_profile.json'.
	name ifNotNil: [ u queryAt: 'name' put: name ].
	url ifNotNil: [ u queryAt: 'url' put: url ].
	location ifNotNil: [ u queryAt: 'location' put: location ].
	description ifNotNil: [ u queryAt: 'description' put: description ].
	linkColor ifNotNil: [ u queryAt: 'profile_link_color' put: linkColor ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	skipStatus ifNotNil: [ u queryAt: 'skip_status' put: skipStatus ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter account' }
TwitterSDK >> accountUpdateSettingsWithSleepTimeEnabled: sleepTimeEnabled
	startSleepTime: startSleepTime
	endSleepTime: endSleepTime
	timeZone: timeZoneRails
	trendLocationEarthID: trendLocationEarthID
	allowContributorRequest: allowContributorRequest
	lang: lang [

	"https://dev.twitter.com/rest/reference/post/account/settings"

	| url |
	url := TwitterSDKZnUrl create
		addPathSegment: 'account';
		addPathSegment: 'settings.json'.
	sleepTimeEnabled ifNotNil: [ url queryAt: 'sleep_time_enabled' put: sleepTimeEnabled ].
	startSleepTime ifNotNil: [ url queryAt: 'start_sleep_time' put: startSleepTime ].
	endSleepTime ifNotNil: [ url queryAt: 'end_sleep_time' put: endSleepTime ].
	timeZoneRails ifNotNil: [ url queryAt: 'time_zone' put: timeZoneRails ].
	trendLocationEarthID ifNotNil: [ url queryAt: 'trend_location_woeid' put: trendLocationEarthID ].
	allowContributorRequest ifNotNil: [ url queryAt: 'allow_contributor_request' put: allowContributorRequest ].
	lang ifNotNil: [ url queryAt: 'lang' put: lang ].
	^ self executePOSTRequestWithURL: url
]

{ #category : #'Twitter account' }
TwitterSDK >> accountUpdateSettingsWithSleepTimeEnabled: sleepTimeEnabled
	startSleepTime: startSleepTime
	endSleepTime: endSleepTime
	timeZone: timeZoneRails
	trendLocationEarthID: trendLocationEarthID
	lang: lang [

	"https://dev.twitter.com/rest/reference/post/account/settings"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'account';
		addPathSegment: 'settings.json'.
	sleepTimeEnabled ifNotNil: [ u queryAt: 'sleep_time_enabled' put: sleepTimeEnabled ].
	startSleepTime ifNotNil: [ u queryAt: 'start_sleep_time' put: startSleepTime ].
	endSleepTime ifNotNil: [ u queryAt: 'end_sleep_time' put: endSleepTime ].
	timeZoneRails ifNotNil: [ u queryAt: 'time_zone' put: timeZoneRails ].
	trendLocationEarthID ifNotNil: [ u queryAt: 'trend_location_woeid' put: trendLocationEarthID ].
	lang ifNotNil: [ u queryAt: 'lang' put: lang ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter account' }
TwitterSDK >> accountVerifyCredentialsWithEntities: includeEntities skipStatus: skipStatus includeEmail: includeEmail [
	"https://dev.twitter.com/rest/reference/get/account/verify_credentials"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'account';
		addPathSegment: 'verify_credentials.json'.
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	skipStatus ifNotNil: [ u queryAt: 'skip_status' put: skipStatus ].
	includeEmail ifNotNil: [ u queryAt: 'include_email' put: includeEmail ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter application' }
TwitterSDK >> applicationRateLimitStatusWithResources: resources [
	"https://dev.twitter.com/rest/reference/get/application/rate_limit_status"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'application';
		addPathSegment: 'rate_limit_status.json'.
	resources ifNotNil: [ u queryAt: 'resources' put: resources ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter blocks' }
TwitterSDK >> blocksCreateWithScreenName: screenName userID: userID includeEntities: includeEntities skipStatus: skipStatus [
	"https://dev.twitter.com/rest/reference/post/blocks/create"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'blocks';
		addPathSegment: 'create.json'.
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	skipStatus ifNotNil: [ u queryAt: 'skip_status' put: skipStatus ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter blocks' }
TwitterSDK >> blocksDestroyWithScreenName: screenName userID: userID includeEntities: includeEntities skipStatus: skipStatus [
	"https://dev.twitter.com/rest/reference/post/blocks/destroy"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'blocks';
		addPathSegment: 'destroy.json'.
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	skipStatus ifNotNil: [ u queryAt: 'skip_status' put: skipStatus ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter blocks' }
TwitterSDK >> blocksListWithIncludeEntities: includeEntitiesBool skipStatus: skipStatusBool cursor: cursor [
	"https://dev.twitter.com/rest/reference/get/blocks/list"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'blocks';
		addPathSegment: 'list.json'.
	includeEntitiesBool ifNotNil: [ u queryAt: 'include_entities' put: includeEntitiesBool ].
	skipStatusBool ifNotNil: [ u queryAt: 'skip_status' put: skipStatusBool ].
	cursor ifNotNil: [ u queryAt: 'cursor' put: cursor ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter blocks' }
TwitterSDK >> blocksListWithStringifyIDs: stringifyIDs cursor: cursor [
	"https://dev.twitter.com/rest/reference/get/blocks/ids"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'blocks';
		addPathSegment: 'ids.json'.
	stringifyIDs ifNotNil: [ u queryAt: 'stringify_ids' put: stringifyIDs ].
	cursor ifNotNil: [ u queryAt: 'cursor' put: cursor ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter collections' }
TwitterSDK >> collectionsCreateWithName: name description: description url: urlString timelineOrder: timelineOrder [
	"https://dev.twitter.com/rest/reference/post/collections/create"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'collections';
		addPathSegment: 'create.json'.
	name ifNotNil: [ u queryAt: 'name' put: name ].
	description ifNotNil: [ u queryAt: 'description' put: description ].
	urlString ifNotNil: [ u queryAt: 'url' put: urlString ].
	timelineOrder ifNotNil: [ u queryAt: 'timeline_order' put: timelineOrder ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter collections' }
TwitterSDK >> collectionsDestroyWithID: id [
	"https://dev.twitter.com/rest/reference/post/collections/destroy"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'collections';
		addPathSegment: 'destroy.json'.
	id ifNotNil: [ u queryAt: 'id' put: id ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter collections' }
TwitterSDK >> collectionsEntriesAddWithID: id tweetID: tweetID relativeTo: relativeTo above: above [
	"https://dev.twitter.com/rest/reference/post/collections/entries/add"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'collections';
		addPathSegment: 'entries';
		addPathSegment: 'add.json'.
	id ifNotNil: [ u queryAt: 'id' put: id ].
	tweetID ifNotNil: [ u queryAt: 'tweet_id' put: tweetID ].
	relativeTo ifNotNil: [ u queryAt: 'relative_to' put: relativeTo ].
	above ifNotNil: [ u queryAt: 'above' put: above ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter collections' }
TwitterSDK >> collectionsEntriesCurateWithID: idString tweetID: tweetID relativeTo: relativeTo above: above [
	"https://dev.twitter.com/rest/reference/post/collections/entries/curate"

	"TODO"

	
]

{ #category : #'Twitter collections' }
TwitterSDK >> collectionsEntriesMoveWithID: id tweetID: tweetID relativeTo: relativeTo above: above [
	"https://dev.twitter.com/rest/reference/post/collections/entries/move"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'collections';
		addPathSegment: 'entries';
		addPathSegment: 'move.json'.
	id ifNotNil: [ u queryAt: 'id' put: id ].
	tweetID ifNotNil: [ u queryAt: 'tweet_id' put: tweetID ].
	relativeTo ifNotNil: [ u queryAt: 'relative_to' put: relativeTo ].
	above ifNotNil: [ u queryAt: 'above' put: above ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter collections' }
TwitterSDK >> collectionsEntriesRemoveWithID: id tweetID: tweetID [
	"https://dev.twitter.com/rest/reference/post/collections/entries/remove"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'collections';
		addPathSegment: 'entries';
		addPathSegment: 'remove.json'.
	id ifNotNil: [ u queryAt: 'id' put: id ].
	tweetID ifNotNil: [ u queryAt: 'tweet_id' put: tweetID ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter collections' }
TwitterSDK >> collectionsEntriesWithID: id count: count maxPosition: maxPosition minPosition: minPosition [
	"https://dev.twitter.com/rest/reference/get/collections/entries"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'collections';
		addPathSegment: 'entries.json'.
	id ifNotNil: [ u queryAt: 'id' put: id ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	maxPosition ifNotNil: [ u queryAt: 'max_position' put: maxPosition ].
	minPosition ifNotNil: [ u queryAt: 'min_position' put: minPosition ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter collections' }
TwitterSDK >> collectionsListWithUserID: userID screenName: screenName tweetID: tweetID count: count cursor: cursor [
	"https://dev.twitter.com/rest/reference/get/collections/list"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'collections';
		addPathSegment: 'list.json'.
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	tweetID ifNotNil: [ u queryAt: 'tweet_id' put: tweetID ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	cursor ifNotNil: [ u queryAt: 'cursor' put: cursor ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter collections' }
TwitterSDK >> collectionsShowWithID: id [
	"https://dev.twitter.com/rest/reference/get/collections/show"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'collections';
		addPathSegment: 'show.json'.
	id ifNotNil: [ u queryAt: 'id' put: id ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter collections' }
TwitterSDK >> collectionsUpdateWithID: id name: name description: description url: url [
	"https://dev.twitter.com/rest/reference/post/collections/update"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'collections';
		addPathSegment: 'update.json'.
	id ifNotNil: [ u queryAt: 'id' put: id ].
	name ifNotNil: [ u queryAt: 'name' put: name ].
	description ifNotNil: [ u queryAt: 'description' put: description ].
	url ifNotNil: [ u queryAt: 'url' put: url ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter directMessages' }
TwitterSDK >> directMessagesDestroyWithID: id includeEntities: includeEntities [
	"https://dev.twitter.com/rest/reference/post/direct_messages/destroy"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'direct_messages';
		addPathSegment: 'destroy.json'.
	id ifNotNil: [ u queryAt: 'id' put: id ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter directMessages' }
TwitterSDK >> directMessagesNewWithUserID: userID screenName: screenName text: text [
	"https://dev.twitter.com/rest/reference/post/direct_messages/new"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'direct_messages';
		addPathSegment: 'new.json'.
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	text ifNotNil: [ u queryAt: 'text' put: text ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter directMessages' }
TwitterSDK >> directMessagesSentWithSinceID: sinceID maxID: maxID count: count page: page includeEntities: includeEntities [
	"https://dev.twitter.com/rest/reference/get/direct_messages/sent"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'direct_messages';
		addPathSegment: 'sent.json'.
	sinceID ifNotNil: [ u queryAt: 'since_id' put: sinceID ].
	maxID ifNotNil: [ u queryAt: 'max_id' put: maxID ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	page ifNotNil: [ u queryAt: 'page' put: page ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter directMessages' }
TwitterSDK >> directMessagesShowWithID: id [
	"https://dev.twitter.com/rest/reference/get/direct_messages/show"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'direct_messages';
		addPathSegment: 'show.json'.
	id ifNotNil: [ u queryAt: 'id' put: id ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter directMessages' }
TwitterSDK >> directMessagesSinceID: sinceID maxID: maxID count: count includeEntities: includeEntities skipStatus: skipStatus [
	"https://dev.twitter.com/rest/reference/get/direct_messages"

	| u |
	u := TwitterSDKZnUrl create addPathSegment: 'direct_messages.json'.
	sinceID ifNotNil: [ u queryAt: 'since_id' put: sinceID ].
	maxID ifNotNil: [ u queryAt: 'max_id' put: maxID ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	skipStatus ifNotNil: [ u queryAt: 'skip_status' put: skipStatus ].
	^ self executeGETRequestWithURL: u
]

{ #category : #private }
TwitterSDK >> executeGETRequestWithURL: url [
	"Private use"

	| response |
	response := self service executeRequest: (ZnRequest get: url) token: self accessToken.
	response isSuccess
		ifFalse: [ self error: 'GET failed: ' , response contents printString ].
	^ NeoJSONReader fromString: response contents
]

{ #category : #private }
TwitterSDK >> executePOSTRequestWithURL: url [
	"Private use"

	| response |
	response := self service executeRequest: (ZnRequest post: url) token: self accessToken.
	response isSuccess
		ifFalse: [ self error: 'POST failed: ' , response contents printString ].
	^ NeoJSONReader fromString: response contents
]

{ #category : #'Twitter favorites' }
TwitterSDK >> favoritesCreateWithID: id includeEntities: includeEntities [
	"https://dev.twitter.com/rest/reference/post/favorites/create"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'favorites';
		addPathSegment: 'create.json'.
	id ifNotNil: [ u queryAt: 'id' put: id ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter favorites' }
TwitterSDK >> favoritesDestroyWithID: id includeEntities: includeEntities [
	"https://dev.twitter.com/rest/reference/post/favorites/destroy"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'favorites';
		addPathSegment: 'destroy.json'.
	id ifNotNil: [ u queryAt: 'id' put: id ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter favorites' }
TwitterSDK >> favoritesListForUserID: userID screenName: screenName count: count sinceID: sinceID maxID: maxID includeEntities: includeEntities [
	"https://dev.twitter.com/rest/reference/get/favorites/list"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'favorites';
		addPathSegment: 'list.json'.
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	sinceID ifNotNil: [ u queryAt: 'since_id' put: sinceID ].
	maxID ifNotNil: [ u queryAt: 'max_id' put: maxID ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter followers' }
TwitterSDK >> followersIDsWithUserID: userID screenName: screenName cursor: cursor stringifyIDs: stringifyIDs count: count [
	"https://dev.twitter.com/rest/reference/get/followers/ids"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'followers';
		addPathSegment: 'ids.json'.
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	cursor ifNotNil: [ u queryAt: 'cursor' put: cursor ].
	stringifyIDs ifNotNil: [ u queryAt: 'stringify_ids' put: stringifyIDs ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter followers' }
TwitterSDK >> followersListWithUserID: userID screenName: screenName cursor: cursor count: count skipStatus: skipStatus includeUserEntities: includeUserEntities [
	"https://dev.twitter.com/rest/reference/get/followers/list"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'followers';
		addPathSegment: 'list.json'.
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	cursor ifNotNil: [ u queryAt: 'cursor' put: cursor ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	skipStatus ifNotNil: [ u queryAt: 'skip_status' put: skipStatus ].
	includeUserEntities ifNotNil: [ u queryAt: 'include_user_entities' put: includeUserEntities ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter friends' }
TwitterSDK >> friendsIDsWithUserID: userID screenName: screenName cursor: cursor stringifyIDs: stringifyIDs count: count [
	"https://dev.twitter.com/rest/reference/get/friends/ids"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'friends';
		addPathSegment: 'ids.json'.
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	cursor ifNotNil: [ u queryAt: 'cursor' put: cursor ].
	stringifyIDs ifNotNil: [ u queryAt: 'stringify_ids' put: stringifyIDs ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter friends' }
TwitterSDK >> friendsListWithUserID: userID screenName: screenName cursor: cursor count: count skipStatus: skipStatus includeUserEntities: includeUserEntities [
	"https://dev.twitter.com/rest/reference/get/friends/list"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'friends';
		addPathSegment: 'list.json'.
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	cursor ifNotNil: [ u queryAt: 'cursor' put: cursor ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	skipStatus ifNotNil: [ u queryAt: 'skipStatus' put: skipStatus ].
	includeUserEntities ifNotNil: [ u queryAt: 'include_user_entities' put: includeUserEntities ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter friendships' }
TwitterSDK >> friendshipsCreateWithScreenName: screenName userID: userID follow: follow [
	"https://dev.twitter.com/rest/reference/post/friendships/create"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'friendships';
		addPathSegment: 'create.json'.
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	follow ifNotNil: [ u queryAt: 'follow' put: follow ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter friendships' }
TwitterSDK >> friendshipsDestroyWithScreenName: screenName userID: userID [
	"https://dev.twitter.com/rest/reference/post/friendships/destroy"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'friendships';
		addPathSegment: 'destroy.json'.
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter friendships' }
TwitterSDK >> friendshipsIncomingWithCursor: cursor stringifyIDs: stringifyIDs [
	"https://dev.twitter.com/rest/reference/get/friendships/incoming"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'friendships';
		addPathSegment: 'incoming.json'.
	cursor ifNotNil: [ u queryAt: 'cursor' put: cursor ].
	stringifyIDs ifNotNil: [ u queryAt: 'stringify_ids' put: stringifyIDs ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter friendships' }
TwitterSDK >> friendshipsLookupWithScreenNames: screenNames userIDs: userIDs [
	"https://dev.twitter.com/rest/reference/get/friendships/lookup"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'followers';
		addPathSegment: 'list.json'.
	screenNames ifNotNil: [ u queryAt: 'screen_name' put: screenNames ].
	userIDs ifNotNil: [ u queryAt: 'user_id' put: userIDs ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter friendships' }
TwitterSDK >> friendshipsNoRetweetsWithStringifyIDs: stringifyIDs [
	"https://dev.twitter.com/rest/reference/get/friendships/no_retweets/ids"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'friendships';
		addPathSegment: 'no_retweets';
		addPathSegment: 'ids.json'.
	stringifyIDs ifNotNil: [ u queryAt: 'stringify_ids' put: stringifyIDs ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter friendships' }
TwitterSDK >> friendshipsOutgoingWithCursor: cursor stringifyIDs: stringifyIDs [
	"https://dev.twitter.com/rest/reference/get/friendships/outgoing"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'friendships';
		addPathSegment: 'outgoing.json'.
	cursor ifNotNil: [ u queryAt: 'cursor' put: cursor ].
	stringifyIDs ifNotNil: [ u queryAt: 'stringify_ids' put: stringifyIDs ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter friendships' }
TwitterSDK >> friendshipsShowWithSourceID: sourceID sourceScreenName: sourceScreenName targetID: targetID targetScreenName: targetScreenName [
	"https://dev.twitter.com/rest/reference/get/friendships/show"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'friendships';
		addPathSegment: 'show.json'.
	sourceID ifNotNil: [ u queryAt: 'source_id' put: sourceID ].
	sourceScreenName
		ifNotNil: [ u queryAt: 'source_screen_name' put: sourceScreenName ].
	targetID
		ifNotNil: [ u queryAt: 'target_id' put: targetID ].
	targetScreenName
		ifNotNil: [ u queryAt: 'target_screen_name' put: targetScreenName ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter friendships' }
TwitterSDK >> friendshipsUpdateWithScreenName: screenName userID: userID device: device retweets: retweets [
	"https://dev.twitter.com/rest/reference/post/friendships/update"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'friendships';
		addPathSegment: 'update.json'.
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	device
		ifNotNil: [ u queryAt: 'device' put: device ].
	retweets
		ifNotNil: [ u queryAt: 'retweets' put: device ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter geo' }
TwitterSDK >> geoInfoWithPlaceID: idString [
	"https://dev.twitter.com/rest/reference/get/geo/id/%3Aplace_id"

	^self
		executePOSTRequestWithURL:
			(TwitterSDKZnUrl create
				addPathSegment: 'geo';
				addPathSegment: 'id';
				addPathSegment: idString , '.json')
]

{ #category : #'Twitter geo' }
TwitterSDK >> geoPlaceWithName: name containedWithin: containedWithin token: token lat: lat long: long attributeStreetAddress: attributeStreetAddress callback: callback [
	"https://dev.twitter.com/rest/reference/post/geo/place"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'geo';
		addPathSegment: 'place.json'.
	name ifNotNil: [ u queryAt: 'name' put: name ].
	containedWithin ifNotNil: [ u queryAt: 'contained_within' put: containedWithin ].
	token ifNotNil: [ u queryAt: 'token' put: token ].
	lat ifNotNil: [ u queryAt: 'lat' put: lat ].
	long ifNotNil: [ u queryAt: 'long' put: long ].
	attributeStreetAddress ifNotNil: [ u queryAt: 'attribute:street_address' put: attributeStreetAddress ].
	callback ifNotNil: [ u queryAt: 'callback' put: callback ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter geo' }
TwitterSDK >> geoReverseGeocodeWithLat: lat long: long accuracy: accuracy granularity: granularity maxResults: maxResults callback: callback [
	"https://dev.twitter.com/rest/reference/get/geo/reverse_geocode"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'geo';
		addPathSegment: 'reverse_geocode.json'.
	lat ifNotNil: [ u queryAt: 'lat' put: lat ].
	long ifNotNil: [ u queryAt: 'long' put: long ].
	accuracy ifNotNil: [ u queryAt: 'accuracy' put: accuracy ].
	granularity ifNotNil: [ u queryAt: 'granularity' put: granularity ].
	maxResults ifNotNil: [ u queryAt: 'max_results' put: maxResults ].
	callback ifNotNil: [ u queryAt: 'callback' put: callback ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter geo' }
TwitterSDK >> geoSearchWithLat: lat long: long query: query ip: ip granularity: granularity accuracy: accuracy maxResults: maxResults containedWithin: containedWithin attributeStreetAddress: attributeStreetAddress callback: callback [
	"https://dev.twitter.com/rest/reference/get/geo/search"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'geo';
		addPathSegment: 'search.json'.
	lat ifNotNil: [ u queryAt: 'lat' put: lat ].
	long ifNotNil: [ u queryAt: 'long' put: long ].
	query ifNotNil: [ u queryAt: 'query' put: query ].
	ip ifNotNil: [ u queryAt: 'ip' put: ip ].
	granularity ifNotNil: [ u queryAt: 'granularity' put: granularity ].
	accuracy ifNotNil: [ u queryAt: 'accuracy' put: accuracy ].
	maxResults ifNotNil: [ u queryAt: 'max_results' put: maxResults ].
	containedWithin ifNotNil: [ u queryAt: 'contained_within' put: containedWithin ].
	attributeStreetAddress ifNotNil: [ u queryAt: 'attribute:street_address' put: attributeStreetAddress ].
	callback ifNotNil: [ u queryAt: 'callback' put: callback ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter help' }
TwitterSDK >> helpConfiguration [
	"https://dev.twitter.com/rest/reference/get/help/configuration"

	^self
		executeGETRequestWithURL:
			(TwitterSDKZnUrl create
				addPathSegment: 'help';
				addPathSegment: 'configuration.json')
]

{ #category : #'Twitter help' }
TwitterSDK >> helpLanguages [
	"https://dev.twitter.com/rest/reference/get/help/languages"

	^self
		executeGETRequestWithURL:
			(TwitterSDKZnUrl create
				addPathSegment: 'help';
				addPathSegment: 'languages.json')
]

{ #category : #'Twitter help' }
TwitterSDK >> helpPrivacy [
	"https://dev.twitter.com/rest/reference/get/help/privacy"

	^self
		executeGETRequestWithURL:
			(TwitterSDKZnUrl create
				addPathSegment: 'help';
				addPathSegment: 'privacy.json')
]

{ #category : #'Twitter help' }
TwitterSDK >> helpTOS [
	"https://dev.twitter.com/rest/reference/get/help/tos"

	^self
		executeGETRequestWithURL:
			(TwitterSDKZnUrl create
				addPathSegment: 'help';
				addPathSegment: 'tos.json')
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsCreateWithName: name mode: mode description: description [
	"https://dev.twitter.com/rest/reference/post/lists/create"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'create.json'.
	name ifNotNil: [ u queryAt: 'name' put: name ].
	mode ifNotNil: [ u queryAt: 'mode' put: mode ].
	description ifNotNil: [ u queryAt: 'description' put: description ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsDestroyWithOwnerScreenName: ownerScreenName ownerID: ownerID listID: listID slug: slug [
	"https://dev.twitter.com/rest/reference/post/lists/destroy"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'destroy.json'.
	ownerScreenName ifNotNil: [ u queryAt: 'owner_screen_name' put: ownerScreenName ].
	ownerID ifNotNil: [ u queryAt: 'owner_id' put: ownerID ].
	listID ifNotNil: [ u queryAt: 'list_id' put: listID ].
	slug ifNotNil: [ u queryAt: 'slug' put: slug ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsListWithUserID: userID screenName: screenName reverse: reverse [
	"https://dev.twitter.com/rest/reference/get/lists/list"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'list.json'.
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	reverse ifNotNil: [ u queryAt: 'reverse' put: reverse ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsMembersCreateAllWithListID: listID slug: slug screenName: screenName ownerScreenName: ownerScreenName ownerID: ownerID [
	"https://dev.twitter.com/rest/reference/post/lists/members/create_all"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'members';
		addPathSegment: 'create_all.json'.
	listID ifNotNil: [ u queryAt: 'list_id' put: listID ].
	slug ifNotNil: [ u queryAt: 'slug' put: slug ].
	screenName ifNotNil: [ u queryAt: 'screen_name:' put: screenName ].
	ownerScreenName ifNotNil: [ u queryAt: 'owner_screen_name' put: ownerScreenName ].
	ownerID ifNotNil: [ u queryAt: 'owner_id' put: ownerID ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsMembersCreateWithListID: listID slug: slug userID: userID screenName: screenName ownerScreenName: ownerScreenName ownerID: ownerID [
	"https://dev.twitter.com/rest/reference/post/lists/members/create"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'members';
		addPathSegment: 'create.json'.
	listID ifNotNil: [ u queryAt: 'list_id' put: listID ].
	slug ifNotNil: [ u queryAt: 'slug' put: slug ].
	userID ifNotNil: [ u queryAt: 'userID' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	ownerScreenName ifNotNil: [ u queryAt: 'owner_screen_name' put: ownerScreenName ].
	ownerID ifNotNil: [ u queryAt: 'owner_id' put: ownerID ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsMembersDestroyAllWithListID: listID slug: slug userID: userID screenName: screenName ownerScreenName: ownerScreenName ownerID: ownerID [
	"https://dev.twitter.com/rest/reference/post/lists/members/destroy_all"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'members';
		addPathSegment: 'destroy_all.json'.
	listID ifNotNil: [ u queryAt: 'list_id' put: listID ].
	slug ifNotNil: [ u queryAt: 'slug' put: slug ].
	userID ifNotNil: [ u queryAt: 'userID' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	ownerScreenName ifNotNil: [ u queryAt: 'owner_screen_name' put: ownerScreenName ].
	ownerID ifNotNil: [ u queryAt: 'owner_id' put: ownerID ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsMembersDestroyWithListID: listID slug: slug userID: userID screenName: screenName ownerScreenName: ownerScreenName ownerID: ownerID [
	"https://dev.twitter.com/rest/reference/post/lists/members/destroy"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'members';
		addPathSegment: 'destroy.json'.
	listID ifNotNil: [ u queryAt: 'list_id' put: listID ].
	slug ifNotNil: [ u queryAt: 'slug' put: slug ].
	userID ifNotNil: [ u queryAt: 'userID' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	ownerScreenName ifNotNil: [ u queryAt: 'owner_screen_name' put: ownerScreenName ].
	ownerID ifNotNil: [ u queryAt: 'owner_id' put: ownerID ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsMembersShowWithListID: listID slug: slug userID: userID screenName: screenName ownerScreenName: ownerScreenName ownerID: ownerID includeEntities: includeEntities skipStatus: skipStatus [
	"https://dev.twitter.com/rest/reference/get/lists/members/show"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'members';
		addPathSegment: 'show.json'.
	listID ifNotNil: [ u queryAt: 'list_id' put: listID ].
	slug ifNotNil: [ u queryAt: 'slug' put: slug ].
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name:' put: screenName ].
	ownerScreenName ifNotNil: [ u queryAt: 'owner_screen_name' put: ownerScreenName ].
	ownerID ifNotNil: [ u queryAt: 'owner_id' put: ownerID ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	skipStatus ifNotNil: [ u queryAt: 'skip_status' put: skipStatus ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsMembersWithListID: listID slug: slug ownerScreenName: ownerScreenName ownerID: ownerID count: count cursor: cursor includeEntities: includeEntities skipStatus: skipStatus [
	"https://dev.twitter.com/rest/reference/get/lists/members"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'members.json'.
	listID ifNotNil: [ u queryAt: 'list_id' put: listID ].
	slug ifNotNil: [ u queryAt: 'slug' put: slug ].
	ownerScreenName ifNotNil: [ u queryAt: 'owner_screen_name' put: ownerScreenName ].
	ownerID ifNotNil: [ u queryAt: 'owner_id' put: ownerID ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	cursor ifNotNil: [ u queryAt: 'cursor' put: cursor ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	skipStatus ifNotNil: [ u queryAt: 'skip_status' put: skipStatus ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsMembershipsWithUserID: userID screenName: screenName count: count cursor: cursor filterToOwnedLists: filterToOwnedLists [
	"https://dev.twitter.com/rest/reference/get/lists/memberships"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'memberships.json'.
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	cursor ifNotNil: [ u queryAt: 'cursor' put: cursor ].
	filterToOwnedLists ifNotNil: [ u queryAt: 'filter_to_owned_lists' put: filterToOwnedLists ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsOwnershipsWithUserID: userID screenName: screenName count: count cursor: cursor [
	"https://dev.twitter.com/rest/reference/get/lists/ownerships"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'ownerships.json'.
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	cursor ifNotNil: [ u queryAt: 'cursor' put: cursor ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsShowWithListID: listID slug: slug ownerScreenName: ownerScreenName ownerID: ownerID [
	"https://dev.twitter.com/rest/reference/get/lists/show"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'show.json'.
	listID ifNotNil: [ u queryAt: 'list_id' put: listID ].
	slug ifNotNil: [ u queryAt: 'slug' put: slug ].
	ownerScreenName ifNotNil: [ u queryAt: 'owner_screen_name' put: ownerScreenName ].
	ownerID ifNotNil: [ u queryAt: 'owner_id' put: ownerID ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsStatusesWithListID: listID slug: slug ownerScreenName: ownerScreenName ownerID: ownerID sinceID: sinceID maxID: maxID count: count includeEntities: includeEntities includeRetweets: includeRetweets [
	"https://dev.twitter.com/rest/reference/get/lists/statuses"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'statuses.json'.
	listID ifNotNil: [ u queryAt: 'list_id' put: listID ].
	slug ifNotNil: [ u queryAt: 'slug' put: slug ].
	ownerScreenName ifNotNil: [ u queryAt: 'owner_screen_name' put: ownerScreenName ].
	ownerID ifNotNil: [ u queryAt: 'owner_id' put: ownerID ].
	sinceID ifNotNil: [ u queryAt: 'since_id' put: sinceID ].
	maxID ifNotNil: [ u queryAt: 'max_id' put: maxID ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	includeRetweets ifNotNil: [ u queryAt: 'include_rts' put: includeRetweets ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsSubscribersCreateWithOwnerScreenName: ownerScreenName ownerID: ownerID listID: listID slug: slug [
	"https://dev.twitter.com/rest/reference/post/lists/subscribers/create"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'subscribers';
		addPathSegment: 'create.json'.
	ownerScreenName ifNotNil: [ u queryAt: 'owner_screen_name' put: ownerScreenName ].
	ownerID ifNotNil: [ u queryAt: 'owner_id' put: ownerID ].
	listID ifNotNil: [ u queryAt: 'list_id' put: listID ].
	slug ifNotNil: [ u queryAt: 'slug' put: slug ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsSubscribersDestroyWithListID: listID slug: slug ownerScreenName: ownerScreenName ownerID: ownerID [
	"https://dev.twitter.com/rest/reference/post/lists/subscribers/destroy"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'subscribers';
		addPathSegment: 'destroy.json'.
	listID ifNotNil: [ u queryAt: 'list_id' put: listID ].
	slug ifNotNil: [ u queryAt: 'slug' put: slug ].
	ownerScreenName ifNotNil: [ u queryAt: 'owner_screen_name' put: ownerScreenName ].
	ownerID ifNotNil: [ u queryAt: 'owner_id' put: ownerID ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsSubscribersShowWithOwnerScreenName: ownerScreenName ownerID: ownerID listID: listID slug: slug userID: userID screenName: screenName includeEntities: includeEntities skipStatus: skipStatus [
	"https://dev.twitter.com/rest/reference/get/lists/subscribers/show"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'subscribers';
		addPathSegment: 'show.json'.
	ownerScreenName ifNotNil: [ u queryAt: 'owner_screen_name' put: ownerScreenName ].
	ownerID ifNotNil: [ u queryAt: 'owner_id' put: ownerID ].
	listID ifNotNil: [ u queryAt: 'list_id' put: listID ].
	slug ifNotNil: [ u queryAt: 'slug' put: slug ].
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	skipStatus ifNotNil: [ u queryAt: 'skip_status' put: skipStatus ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsSubscribersWithListID: listID slug: slug ownerScreenName: ownerScreenName ownerID: ownerID count: count cursor: cursor includeEntities: includeEntities skipStatus: skipStatus [
	"https://dev.twitter.com/rest/reference/get/lists/subscribers"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'subscribers.json'.
	listID ifNotNil: [ u queryAt: 'list_id' put: listID ].
	slug ifNotNil: [ u queryAt: 'slug' put: slug ].
	ownerScreenName ifNotNil: [ u queryAt: 'owner_screen_name' put: ownerScreenName ].
	ownerID ifNotNil: [ u queryAt: 'owner_id' put: ownerID ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	cursor ifNotNil: [ u queryAt: 'cursor' put: cursor ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	skipStatus ifNotNil: [ u queryAt: 'skip_status' put: skipStatus ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsSubscriptionsWithUserID: userID screenName: screenName count: count cursor: cursor [
	"https://dev.twitter.com/rest/reference/get/lists/subscriptions"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'subscriptions.json'.
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	cursor ifNotNil: [ u queryAt: 'cursor' put: cursor ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter lists' }
TwitterSDK >> listsUpdateWithListID: listID slug: slug name: name mode: mode description: description ownerScreenName: ownerScreenName ownerID: ownerID [
	"https://dev.twitter.com/rest/reference/post/lists/update"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'lists';
		addPathSegment: 'update.json'.
	listID ifNotNil: [ u queryAt: 'list_id' put: listID ].
	slug ifNotNil: [ u queryAt: 'slug' put: slug ].
	name ifNotNil: [ u queryAt: 'name' put: name ].
	mode ifNotNil: [ u queryAt: 'mode' put: mode ].
	description ifNotNil: [ u queryAt: 'description' put: description ].
	ownerScreenName ifNotNil: [ u queryAt: 'owner_screen_name' put: ownerScreenName ].
	ownerID ifNotNil: [ u queryAt: 'owner_id' put: ownerID ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter media' }
TwitterSDK >> mediaUploadChunked [
	"https://dev.twitter.com/rest/reference/post/media/upload-chunked"

	"TODO"
	

]

{ #category : #'Twitter media' }
TwitterSDK >> mediaUploadFile: aFileName additionalOwners: additionalOwners [
	"https://dev.twitter.com/rest/reference/post/media/upload"

	| u part request response |
	u := ZnUrl new
		scheme: #https;
		host: 'upload.twitter.com';
		addPathSegment: '1.1';
		addPathSegment: 'media';
		addPathSegment: 'upload.json'.
	additionalOwners ifNotNil: [ u queryAt: 'additional_owners' put: additionalOwners ].
	request := ZnRequest post: u.
	part := ZnMimePart fieldName: 'media' fileNamed: aFileName.
	request entity: (ZnMultiPartFormDataEntity new addPart: part).
	response := self service executeRequest: request token: self accessToken.
	response isSuccess
		ifFalse: [ self error: 'POST failed: ' , response contents printString ].
	^ NeoJSONReader fromString: response contents
]

{ #category : #'Twitter mutes' }
TwitterSDK >> mutesUsersCreateWithScreenName: screenName userID: userID [
	"https://dev.twitter.com/rest/reference/post/mutes/users/create"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'mutes';
		addPathSegment: 'users';
		addPathSegment: 'create.json'.
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter mutes' }
TwitterSDK >> mutesUsersDestroyWithScreenName: screenName userID: userID [
	"https://dev.twitter.com/rest/reference/post/mutes/users/destroy"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'mutes';
		addPathSegment: 'users';
		addPathSegment: 'destroy.json'.
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter mutes' }
TwitterSDK >> mutesUsersIDs: stringifyIDs cursor: cursor [
	"https://dev.twitter.com/rest/reference/get/mutes/users/ids"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'mutes';
		addPathSegment: 'users';
		addPathSegment: 'ids.json'.
	stringifyIDs ifNotNil: [ u queryAt: 'stringify_ids' put: stringifyIDs ].
	cursor ifNotNil: [ u queryAt: 'cursor' put: cursor ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter mutes' }
TwitterSDK >> mutesUsersListWithCursor: cursor includeEntities: includeEntities skipStatus: skipStatus [
	"https://dev.twitter.com/rest/reference/get/mutes/users/list"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'mutes';
		addPathSegment: 'users';
		addPathSegment: 'list.json'.
	cursor ifNotNil: [ u queryAt: 'cursor' put: cursor ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	skipStatus ifNotNil: [ u queryAt: 'skip_status' put: skipStatus ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter savedSearches' }
TwitterSDK >> savedSearchesCreateWithQuery: query [
	"https://dev.twitter.com/rest/reference/post/saved_searches/create"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'saved_searches';
		addPathSegment: 'create.json'.
	query ifNotNil: [ u queryAt: 'query' put: query ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter savedSearches' }
TwitterSDK >> savedSearchesDestroyWithID: id [
	"https://dev.twitter.com/rest/reference/post/saved_searches/destroy/%3Aid"

	^ self
		executePOSTRequestWithURL:
			(TwitterSDKZnUrl create
				addPathSegment: 'saved_searches';
				addPathSegment: 'destroy';
				addPathSegment: id , '.json')
]

{ #category : #'Twitter savedSearches' }
TwitterSDK >> savedSearchesList [
	"https://dev.twitter.com/rest/reference/get/saved_searches/list"

	^self
		executeGETRequestWithURL:
			(TwitterSDKZnUrl create
				addPathSegment: 'saved_searches';
				addPathSegment: 'list.json')
]

{ #category : #'Twitter savedSearches' }
TwitterSDK >> savedSearchesShowWithID: id [
	"https://dev.twitter.com/rest/reference/get/saved_searches/show/%3Aid"

	^ self
		executeGETRequestWithURL:
			(TwitterSDKZnUrl create
				addPathSegment: 'saved_searches';
				addPathSegment: 'show';
				addPathSegment: id , '.json')
]

{ #category : #'Twitter search' }
TwitterSDK >> searchTweetsWithQuery: query geocode: geocode lang: lang locale: locale resultType: resultType count: count until: until sinceID: sinceID maxID: maxID includeEntities: includeEntities callback: callback [
	"https://dev.twitter.com/rest/public/search"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'search';
		addPathSegment: 'tweets.json'.
		u queryAt: 'tweet_mode' put: 'extended'.
	query ifNotNil: [ u queryAt: 'q' put: query ].
	geocode ifNotNil: [ u queryAt: 'geocode' put: geocode ].
	lang ifNotNil: [ u queryAt: 'lang' put: lang ].
	locale ifNotNil: [ u queryAt: 'locale' put: locale ].
	resultType ifNotNil: [ u queryAt: 'result_type' put: resultType ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	until ifNotNil: [ u queryAt: 'until' put: until ].
	sinceID ifNotNil: [ u queryAt: 'since_id' put: sinceID ].
	maxID ifNotNil: [ u queryAt: 'max_id' put: maxID ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	callback ifNotNil: [ u queryAt: 'callback' put: callback ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'private - accessing' }
TwitterSDK >> service [
	"Private use"
	
	^ service ifNil: [ service := self class defaultService ]
]

{ #category : #'private - accessing' }
TwitterSDK >> service: aZnOAuth1Service [
	"Private use"

	service := aZnOAuth1Service
]

{ #category : #'Twitter statuses' }
TwitterSDK >> statusesDestroyWithID: id trimUser: trimUser [
	"https://dev.twitter.com/rest/reference/post/statuses/destroy/%3Aid"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'statuses';
		addPathSegment: 'destroy';
		addPathSegment: id , '.json'.
	trimUser ifNotNil: [ u queryAt: 'trim_ser' put: trimUser ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter statuses' }
TwitterSDK >> statusesHomeTimelineWithCount: count sinceID: sinceID maxID: maxID trimUser: trimUser excludeReplies: excludeReplies includeEntities: includeEntities [
	"https://dev.twitter.com/rest/reference/get/statuses/home_timeline"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'statuses';
		addPathSegment: 'home_timeline.json'.
	u queryAt: 'tweet_mode' put: 'extended'.
	count ifNotNil: [ u queryAt: 'count' put: count ].
	sinceID ifNotNil: [ u queryAt: 'since_id' put: sinceID ].
	maxID ifNotNil: [ u queryAt: 'max_id' put: maxID ].
	trimUser ifNotNil: [ u queryAt: 'trim_user' put: trimUser ].
	excludeReplies ifNotNil: [ u queryAt: 'exclude_replies' put: excludeReplies ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter statuses' }
TwitterSDK >> statusesLookupWithIDs: idString includeEntities: includeEntities trimUser: trimUser map: map includeExtAltText: includeExtAltText [
	"https://dev.twitter.com/rest/reference/get/statuses/lookup"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'statuses';
		addPathSegment: 'lookup.json'.
	u queryAt: 'tweet_mode' put: 'extended'.
	idString ifNotNil: [ u queryAt: 'id' put: idString ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	trimUser ifNotNil: [ u queryAt: 'trim_user' put: trimUser ].
	map ifNotNil: [ u queryAt: 'map' put: map ].
	includeExtAltText ifNotNil: [ u queryAt: 'include_ext_alt_text' put: includeExtAltText ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter statuses' }
TwitterSDK >> statusesMentionsTimelineWithCount: count sinceID: sinceID maxID: maxID trimUser: trimUser includeEntities: includeEntities [
	"https://dev.twitter.com/rest/reference/get/statuses/mentions_timeline"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'statuses';
		addPathSegment: 'mentions_timeline.json'.
	u queryAt: 'tweet_mode' put: 'extended'.
	count ifNotNil: [ u queryAt: 'count' put: count ].
	sinceID ifNotNil: [ u queryAt: 'since_id' put: sinceID ].
	maxID ifNotNil: [ u queryAt: 'max_id' put: maxID ].
	trimUser ifNotNil: [ u queryAt: 'trim_user' put: trimUser ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter statuses' }
TwitterSDK >> statusesOembedWithID: id url: url maxWidth: maxWidth hideMedia: hideMedia hideThread: hideThread omitScript: omitScript align: align related: related lang: lang theme: theme linkColor: linkColor widgetType: widgetType dnt: dnt [
	"https://dev.twitter.com/rest/reference/get/statuses/oembed"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'statuses';
		addPathSegment: 'oembed.json'.
	u queryAt: 'tweet_mode' put: 'extended'.
	id ifNotNil: [ u queryAt: 'id' put: id ].
	url ifNotNil: [ u queryAt: 'url ' put: url ].
	maxWidth ifNotNil: [ u queryAt: 'maxwidth' put: maxWidth ].
	hideMedia ifNotNil: [ u queryAt: 'hide_media' put: hideMedia ].
	hideThread ifNotNil: [ u queryAt: 'hide_thread' put: hideThread ].
	omitScript ifNotNil: [ u queryAt: 'omit_script' put: omitScript ].
	align ifNotNil: [ u queryAt: 'align' put: align ].
	related ifNotNil: [ u queryAt: 'related' put: related ].
	lang ifNotNil: [ u queryAt: 'lang' put: lang ].
	theme ifNotNil: [ u queryAt: 'theme' put: theme ].
	linkColor ifNotNil: [ u queryAt: 'link_color' put: linkColor ].
	widgetType ifNotNil: [ u queryAt: 'widget_type' put: widgetType ].
	dnt ifNotNil: [ u queryAt: 'dnt' put: dnt ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter statuses' }
TwitterSDK >> statusesRetweetWithID: id trimUser: trimUser [
	"https://dev.twitter.com/rest/reference/post/statuses/retweet/%3Aid"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'statuses';
		addPathSegment: 'retweet';
		addPathSegment: id , '.json'.
	u queryAt: 'tweet_mode' put: 'extended'.
	trimUser ifNotNil: [ u queryAt: 'trim_user' put: trimUser ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter statuses' }
TwitterSDK >> statusesRetweetersWithID: id cursor: cursor stringifyIDs: stringifyIDs [
	"https://dev.twitter.com/rest/reference/get/statuses/retweeters/ids"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'statuses';
		addPathSegment: 'retweeters';
		addPathSegment: 'ids.json'.
	id ifNotNil: [ u queryAt: 'id' put: id ].
	cursor ifNotNil: [ u queryAt: 'cursor' put: cursor ].
	stringifyIDs ifNotNil: [ u queryAt: 'stringify_ids' put: stringifyIDs ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter statuses' }
TwitterSDK >> statusesRetweetsOfMeWithCount: count sinceID: sinceID maxID: maxID trimUser: trimUser includeEntities: includeEntities includeUserEntities: includeUserEntities [
	"https://dev.twitter.com/rest/reference/get/statuses/retweets_of_me"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'statuses';
		addPathSegment: 'retweets_of_me.json'.
		u queryAt: 'tweet_mode' put: 'extended'.
	count ifNotNil: [ u queryAt: 'count' put: count ].
	sinceID ifNotNil: [ u queryAt: 'since_id' put: sinceID ].
	maxID ifNotNil: [ u queryAt: 'max_id' put: maxID ].
	trimUser ifNotNil: [ u queryAt: 'trim_user' put: trimUser ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	includeUserEntities ifNotNil: [ u queryAt: 'invlude_user_entities' put: includeUserEntities ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter statuses' }
TwitterSDK >> statusesRetweetsWithID: idString count: count trimUser: trimUser [
	"https://dev.twitter.com/rest/reference/get/statuses/retweets/%3Aid"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'statuses';
		addPathSegment: 'retweets';
		addPathSegment: idString , '.json'.
		u queryAt: 'tweet_mode' put: 'extended'.
	count ifNotNil: [ u queryAt: 'count' put: count ].
	trimUser ifNotNil: [ u queryAt: 'trim_user' put: trimUser ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter statuses' }
TwitterSDK >> statusesShowWithID: id trimUser: trimUser includeMyRetweet: includeMyRetweet includeEntities: includeEntities includeExtAltText: includeExtAltText [
	"https://dev.twitter.com/rest/reference/get/statuses/show/%3Aid"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'statuses';
		addPathSegment: 'show.json'.
	u queryAt: 'tweet_mode' put: 'extended'.
	id ifNotNil: [ u queryAt: 'id' put: id ].
	trimUser ifNotNil: [ u queryAt: 'trim_user' put: trimUser ].
	includeMyRetweet ifNotNil: [ u queryAt: 'include_my_retweet' put: includeMyRetweet ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	includeExtAltText ifNotNil: [ u queryAt: 'include_ext_alt_text' put: includeExtAltText ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter statuses' }
TwitterSDK >> statusesUpdateWithStatus: status inReplyToStatusID: inReplyToStatusID possiblySensitive: possiblySensitive lat: lat long: long placeID: placeID displayCoordinates: displayCoordinates trimUser: trimUser mediaIDs: mediaIDs enableDMCommands: enableDMCommands failDMCommands: failDMCommands [
	"https://dev.twitter.com/docs/api/1.1/post/statuses/update"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'statuses';
		addPathSegment: 'update.json'.
	u queryAt: 'tweet_mode' put: 'extended'.
	status ifNotNil: [ u queryAt: 'status' put: status ].
	inReplyToStatusID ifNotNil: [ u queryAt: 'in_reply_to_status_id' put: inReplyToStatusID ].
	possiblySensitive ifNotNil: [ u queryAt: 'possibly_sensitive' put: possiblySensitive ].
	lat ifNotNil: [ u queryAt: 'lat' put: lat ].
	long ifNotNil: [ u queryAt: 'long' put: long ].
	placeID ifNotNil: [ u queryAt: 'place_id' put: placeID ].
	displayCoordinates ifNotNil: [ u queryAt: 'display_coordinates' put: displayCoordinates ].
	trimUser ifNotNil: [ u queryAt: 'trim_user' put: trimUser ].
	mediaIDs ifNotNil: [ u queryAt: 'media_ids' put: mediaIDs ].
	enableDMCommands ifNotNil: [ u queryAt: 'enable_dm_commands' put: enableDMCommands ].
	failDMCommands ifNotNil: [ u queryAt: 'fail_dm_commands' put: failDMCommands ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter statuses' }
TwitterSDK >> statusesUserTimelineWithUserID: userID orScreenName: screenName sinceID: sinceID count: count maxID: maxID trimUser: trimUser excludeReplies: excludeReplies includeRetweets: includeRetweets [
	"https://dev.twitter.com/rest/reference/get/statuses/user_timeline"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'statuses';
		addPathSegment: 'user_timeline.json'.
	u queryAt: 'tweet_mode' put: 'extended'.
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	maxID ifNotNil: [ u queryAt: 'max_id' put: maxID ].
	trimUser ifNotNil: [ u queryAt: 'trim_user' put: trimUser ].
	excludeReplies ifNotNil: [ u queryAt: 'exclude_replies' put: excludeReplies ].
	includeRetweets ifNotNil: [ u queryAt: 'include_rts' put: includeRetweets asString ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter trends' }
TwitterSDK >> trendsClosestWithLat: lat long: long [
	"https://dev.twitter.com/rest/reference/get/trends/closest"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'trends';
		addPathSegment: 'closest.json'.
	lat ifNotNil: [ u queryAt: 'lat' put: lat ].
	long ifNotNil: [ u queryAt: 'long' put: long ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter trends' }
TwitterSDK >> trendsPlaceAvailable [
	"https://dev.twitter.com/rest/reference/get/trends/available"

	^self
		executeGETRequestWithURL:
			(TwitterSDKZnUrl create
				addPathSegment: 'trends';
				addPathSegment: 'available.json')
]

{ #category : #'Twitter trends' }
TwitterSDK >> trendsPlaceWithID: id exclude: exclude [
	"https://dev.twitter.com/rest/reference/get/trends/place"

	| url |
	url := TwitterSDKZnUrl create
		addPathSegment: 'trends';
		addPathSegment: 'place.json'.
	id ifNotNil: [ url queryAt: 'id' put: id ].
	exclude ifNotNil: [ url queryAt: 'exclude' put: exclude ].
	^ self executeGETRequestWithURL: url
]

{ #category : #'private - accessing' }
TwitterSDK >> userAccess [
	"Private use"

	^ userAccess ifNil: [ userAccess := self class defaultUserAccess ]
]

{ #category : #'private - accessing' }
TwitterSDK >> userAccess: aZnOAuth1TwitterUserAccess [
	"Private use"

	userAccess := aZnOAuth1TwitterUserAccess
]

{ #category : #'Twitter users' }
TwitterSDK >> usersLookupWithScreenName: screenName userID: userID includeEntities: includeEntities [
	"https://dev.twitter.com/rest/reference/get/users/lookup"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'users';
		addPathSegment: 'lookup.json'.
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter users' }
TwitterSDK >> usersProfileBannerWithUserID: userID screenName: screenName [
	"https://dev.twitter.com/rest/reference/get/users/profile_banner"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'users';
		addPathSegment: 'lookup.json'.
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter users' }
TwitterSDK >> usersReportSpamWithScreenName: screenName userID: userID performBlock: performBlock [
	"https://dev.twitter.com/rest/reference/post/users/report_spam"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'users';
		addPathSegment: 'report_spam.json'.
	screenName ifNotNil: [ u queryAt: 'screenname' put: screenName ].
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	performBlock ifNotNil: [ u queryAt: 'perform_block' put: performBlock ].
	^ self executePOSTRequestWithURL: u
]

{ #category : #'Twitter users' }
TwitterSDK >> usersSearchWithQuery: query page: page count: count includeEntities: includeEntities [
	"https://dev.twitter.com/rest/reference/get/users/search"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'users';
		addPathSegment: 'search.json'.
	query ifNotNil: [ u queryAt: 'q' put: query ].
	page ifNotNil: [ u queryAt: 'page' put: page ].
	count ifNotNil: [ u queryAt: 'count' put: count ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter users' }
TwitterSDK >> usersShowWithUserID: userID screenName: screenName includeEntities: includeEntities [
	"https://dev.twitter.com/rest/reference/get/users/show"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'users';
		addPathSegment: 'show.json'.
	userID ifNotNil: [ u queryAt: 'user_id' put: userID ].
	screenName ifNotNil: [ u queryAt: 'screen_name' put: screenName ].
	includeEntities ifNotNil: [ u queryAt: 'include_entities' put: includeEntities ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter users' }
TwitterSDK >> usersSuggestionsMembersWithSlug: slug [
	"https://dev.twitter.com/rest/reference/get/users/suggestions/%3Aslug"

	^self
		executeGETRequestWithURL:
			(TwitterSDKZnUrl create
				addPathSegment: 'users';
				addPathSegment: 'suggestions';
				addPathSegment: slug , '.json';
				addPathSegment: 'members.json')
]

{ #category : #'Twitter users' }
TwitterSDK >> usersSuggestionsWithLang: lang [
	"https://dev.twitter.com/rest/reference/get/users/suggestions"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'users';
		addPathSegment: 'suggestions.json'.
	lang ifNotNil: [ u queryAt: 'lang' put: lang ].
	^ self executeGETRequestWithURL: u
]

{ #category : #'Twitter users' }
TwitterSDK >> usersSuggestionsWithSlug: slug lang: lang [
	"https://dev.twitter.com/rest/reference/get/users/suggestions/%3Aslug"

	| u |
	u := TwitterSDKZnUrl create
		addPathSegment: 'users';
		addPathSegment: 'suggestions';
		addPathSegment: slug , '.json'.
	lang ifNotNil: [ u queryAt: 'lang' put: lang ].
	^ self executeGETRequestWithURL: u
]
