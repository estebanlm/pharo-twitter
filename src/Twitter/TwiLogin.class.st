Class {
	#name : #TwiLogin,
	#superclass : #Object,
	#instVars : [
		'userAccess',
		'service',
		'accessToken'
	],
	#category : #Twitter
}

{ #category : #'as yet unclassified' }
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
TwiLogin >> accessToken [
	^ accessToken
]

{ #category : #accessing }
TwiLogin >> accessToken: anObject [
	accessToken := anObject
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

{ #category : #accessing }
TwiLogin >> service [
	^ service
]

{ #category : #accessing }
TwiLogin >> service: anObject [
	service := anObject
]

{ #category : #api }
TwiLogin >> timeline [
	
]

{ #category : #accessing }
TwiLogin >> userAccess [
	^ userAccess
]

{ #category : #accessing }
TwiLogin >> userAccess: anObject [
	userAccess := anObject
]
