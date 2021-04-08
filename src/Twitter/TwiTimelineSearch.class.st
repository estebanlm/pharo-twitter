Class {
	#name : #TwiTimelineSearch,
	#superclass : #TwiTimeline,
	#instVars : [
		'search'
	],
	#category : #Twitter
}

{ #category : #'as yet unclassified' }
TwiTimelineSearch class >> login: aLogin search: aString [

	^ self new
		login: aLogin;
		search: aString;
		yourself
]

{ #category : #private }
TwiTimelineSearch >> retrieveStatusesSince: anId [
	| result |

	result := (self login 
		get: self url
		with: [ :request | 
			request 
				queryAt: 'q' put: self search;
				queryAt: 'tweet_mode' put: 'extended';
				queryAt: 'count' put: self class readLimit.
			anId ifNotNil: [ request queryAt: 'since_id' put: anId ].
			self addParametersToRequest: request ]).
	
	^ (result at: #statuses) collect: [ :each |
			TwiStatus login: self login json: each ]
]

{ #category : #accessing }
TwiTimelineSearch >> search [
	
	^ search
]

{ #category : #accessing }
TwiTimelineSearch >> search: aString [

	search := aString
]

{ #category : #accessing }
TwiTimelineSearch >> url [
	^ self login url / 'search' / 'tweets.json'
]
