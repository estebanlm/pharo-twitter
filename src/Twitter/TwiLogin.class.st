Class {
	#name : #TwiLogin,
	#superclass : #Object,
	#instVars : [
		'userAccess',
		'service',
		'accessToken',
		'url'
	],
	#category : #Twitter
}

{ #category : #'instance creation' }
TwiLogin class >> consumerKey: consumerKey consumerSecret: consumerSecret accessToken: aToken accessTokenSecret: aTokenSecret [
	^ super new 
		initializeConsumerKey: consumerKey 
		consumerSecret: consumerSecret 
		accessToken: aToken
		accessTokenSecret: aTokenSecret
]

{ #category : #'instance creation' }
TwiLogin class >> new [
	self error: 'Use #consumerKey:consumerSecret:accessToken:accessTokenSecret:'
]

{ #category : #accessing }
TwiLogin class >> twitterUrl [
	^ 'https://api.twitter.com/1.1' asZnUrl
]

{ #category : #'private accessing' }
TwiLogin >> accessToken [
	^ accessToken
]

{ #category : #'private accessing' }
TwiLogin >> accessToken: anObject [
	accessToken := anObject
]

{ #category : #'private requesting' }
TwiLogin >> executeRequest: requestMethod url: anUrl with: aBlock [
	| request |
	
	"Use ZnClient just as a builder"
	request := ZnClient new
		request: (ZnRequest method: requestMethod url: anUrl);
		in: aBlock;
		request.
	"now I use oath service to send the real request"
	^ self withResponseHandling: [ 
		self service 
			executeRequest: request 
			token: self accessToken ]
]

{ #category : #'private requesting' }
TwiLogin >> get: anUrl [
	^ self get: anUrl with: [ :request | ]
]

{ #category : #'private requesting' }
TwiLogin >> get: anUrl with: aBlock [
	^ STON fromString: (self 
		rawGet: anUrl 
		with: aBlock)
]

{ #category : #initialization }
TwiLogin >> initializeConsumerKey: consumerKey consumerSecret: consumerSecret accessToken: aToken accessTokenSecret: aTokenSecret [
	"Setup your app at https://apps.twitter.com/app/"
	| consumerData accessTokenDict |

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

]

{ #category : #'private requesting' }
TwiLogin >> rawGet: anUrl with: aBlock [
	^ self 
		executeRequest: #GET  
		url: anUrl  
		with: aBlock
]

{ #category : #'private accessing' }
TwiLogin >> service [
	^ service
]

{ #category : #api }
TwiLogin >> timelineHome [
	^ TwiTimelineHome login: self
]

{ #category : #api }
TwiLogin >> timelineUser [
	^ TwiTimelineUser login: self
]

{ #category : #api }
TwiLogin >> timelineUser: aName [
	^ TwiTimelineUser login: self username: aName
]

{ #category : #accessing }
TwiLogin >> url [ 
	^ url ifNil: [ url := self class twitterUrl ]
]

{ #category : #accessing }
TwiLogin >> urlStatuses [
	^ self url / 'statuses'
]

{ #category : #'private requesting' }
TwiLogin >> withResponseHandling: aBlock [
	| response |
	
	response := aBlock value.
	response isSuccess
		ifFalse: [ TwiRequestError signalResponse: response ].
	^ response contents
]
