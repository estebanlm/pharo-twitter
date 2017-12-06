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
TwiLogin >> addAuthorizationTo: aRequest [
	| calculator |
	
	calculator := self service providerAccount newCalculator.
	calculator 
		token: self accessToken value;
		tokenSecret: self accessToken secret.
	
	aRequest setAuthorization: (calculator getAuthorizationHeader: aRequest)
]

{ #category : #'private requesting' }
TwiLogin >> get: anUrl [
	^ self get: anUrl with: [ :request | ]
]

{ #category : #'private requesting' }
TwiLogin >> get: anUrl with: aBlock [
	^ ZnClient new
		url: anUrl;
		in: aBlock;
		method: #GET;
		in: [ :aClient | self addAuthorizationTo: aClient request ];
		execute;
		response
]

{ #category : #initialization }
TwiLogin >> initializeConsumerKey: consumerKey consumerSecret: consumerSecret accessToken: aToken accessTokenSecret: aTokenSecret [
	"Setup your app at https://apps.twitter.com/app/"
	| consumerData accessTokenDict newUserAccess newService newAccessToken |

	consumerData := ZnOAuth1ConsumerData newForTwitterAuthentication.
	consumerData consumer: consumerKey.
	consumerData consumerSecret: consumerSecret.
	newService := ZnOAuth1Service new.
	newService providerAccount: consumerData.
	accessTokenDict := Dictionary new.
	accessTokenDict at: 'oauth_token' put: aToken.
	accessTokenDict at: 'oauth_token_secret' put: aTokenSecret.
	newAccessToken := ZnOAuth1Token newFromDictionary: accessTokenDict.
	newUserAccess := ZnOAuth1TwitterUserAccess new oauth1Service: newService.
	newUserAccess accessToken: newAccessToken.
	
	self 
		service: newService;
		userAccess: newUserAccess;
		accessToken: newAccessToken
]

{ #category : #'private accessing' }
TwiLogin >> service [
	^ service
]

{ #category : #'private accessing' }
TwiLogin >> service: anObject [
	service := anObject
]

{ #category : #api }
TwiLogin >> timelineHome [
	^ self get: self urlStatuses / 'home_timeline.json'
	
]

{ #category : #accessing }
TwiLogin >> url [ 
	^ url ifNil: [ url := self class twitterUrl ]
]

{ #category : #accessing }
TwiLogin >> urlStatuses [
	^ self url / 'statuses'
]

{ #category : #'private accessing' }
TwiLogin >> userAccess [
	^ userAccess
]

{ #category : #'private accessing' }
TwiLogin >> userAccess: anObject [
	userAccess := anObject
]
