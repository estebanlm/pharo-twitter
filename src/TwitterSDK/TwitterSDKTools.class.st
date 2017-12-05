"
I am TwitterSDKTools, an object to interact with the Twitter API (version 1.1). More info at <https://brackendev.github.io/TwitterSDK-Pharo/>.

Example usage:

	twitter := TwitterSDK createWithConsumerKey: CONSUMER_KEY consumerSecret: CONSUMER_SECRET accessToken: ACCESS_TOKEN accessTokenSecret: TOKEN_SECRET.
	TwitterSDKTools postTweet: twitter status: 'Test' image: 'test.jpg'. 
"
Class {
	#name : #TwitterSDKTools,
	#superclass : #Object,
	#category : #'TwitterSDK-Tools'
}

{ #category : #private }
TwitterSDKTools class >> entitiesForTweet: aTweet [
	(aTweet includesKey: 'extended_entities')
		ifTrue: [ ^ aTweet at: 'extended_entities' ]
		ifFalse: [ (aTweet includesKey: 'entities')
				ifTrue: [ ^ aTweet at: 'entities' ]
				ifFalse: [ ^ nil ]
			]
]

{ #category : #private }
TwitterSDKTools class >> mediaForTweetEntities: tweetEntities [
	(tweetEntities includesKey: 'media')
		ifTrue: [ (tweetEntities at: 'media') ifEmpty: [ ^ nil ] ifNotEmpty: [ ^ tweetEntities at: 'media' ] ]
		ifFalse: [ ^ nil ]
]

{ #category : #public }
TwitterSDKTools class >> mediaURLsForTweet: aTweet [
	| entities media urls |
	entities := self entitiesForTweet: aTweet.
	(entities isNil or: [ entities isEmpty ])
		ifTrue: [ ^ OrderedCollection new ].
	media := self mediaForTweetEntities: entities.
	(media isNil or: [ media isEmpty ])
		ifTrue: [ ^ OrderedCollection new ].
	urls := self urlsForTweetMedia: media.
	(urls isNil or: [ urls isEmpty ])
		ifTrue: [ ^ OrderedCollection new ]
		ifFalse: [ ^ urls ]
]

{ #category : #public }
TwitterSDKTools class >> mediaURLsForTweetID: aTwitterSDK tweetID: anInteger [
	^ self mediaURLsForTweet: (TwitterSDKTools
		retrieveTweet: aTwitterSDK
		tweetID: anInteger)
]

{ #category : #public }
TwitterSDKTools class >> postTweet: aTwitterSDK status: aString image: aFileName [
	| response mediaID |
	aFileName ifNotNil: [ response := aTwitterSDK mediaUploadFile: aFileName additionalOwners: nil.
	mediaID := response at: 'media_id' ].
	^ aTwitterSDK
		statusesUpdateWithStatus: aString
		inReplyToStatusID: nil
		possiblySensitive: nil
		lat: nil
		long: nil
		placeID: nil
		displayCoordinates: nil
		trimUser: nil
		mediaIDs: mediaID
		enableDMCommands: nil
		failDMCommands: nil
]

{ #category : #public }
TwitterSDKTools class >> retrieveTweet: aTwitterSDK tweetID: anInteger [
	| response |
	response := aTwitterSDK
		statusesLookupWithIDs: anInteger
		includeEntities: true
		trimUser: true
		map: nil
		includeExtAltText: true.
	(response isNil or: [ response isEmpty ])
		ifTrue: [ ^ nil ]
		ifFalse: [ ^ response last ]
]

{ #category : #private }
TwitterSDKTools class >> textForTweet: aTweet [
	(aTweet includesKey: 'full_text')
		ifTrue: [ ^ aTweet at: 'full_text' ]
		ifFalse: [ ^ 	(aTweet includesKey: 'text')
		ifTrue: [ ^ aTweet at: 'text' ]
		ifFalse: [ ^ nil ] ]
]

{ #category : #public }
TwitterSDKTools class >> textForTweetID: aTwitterSDK tweetID: anInteger [
	| response |
	response := aTwitterSDK
		statusesLookupWithIDs: anInteger
		includeEntities: true
		trimUser: true
		map: nil
		includeExtAltText: true.
	(response isNil or: [ response isEmpty ])
		ifTrue: [ ^ nil ]
		ifFalse: [ ^ self textForTweet: response last ]
]

{ #category : #private }
TwitterSDKTools class >> urlsForTweetMedia: tweetMedia [
	| oc |
	oc := OrderedCollection new.
	tweetMedia
		do: [ :each | 
			(each includesKey: 'media_url')
				ifTrue: [ oc add: (each at: 'media_url') ]
			].
	^ oc
]
