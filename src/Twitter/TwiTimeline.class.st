"
I'm an abstract front-end to query timelines. 
my children bring the concrete timelines taking the right address. 

at start, a timeline is empty. It can be filled using #next (who will bring next statuses 20 to 20) or by #restart, which will reload from zero (performing a refresh of status, bringing new ones if there are).
"
Class {
	#name : #TwiTimeline,
	#superclass : #Object,
	#instVars : [
		'login',
		'statuses'
	],
	#category : #Twitter
}

{ #category : #'instance creation' }
TwiTimeline class >> login: aLogin [
	^ self new login: aLogin
]

{ #category : #private }
TwiTimeline >> addParametersToRequest: request [
		
]

{ #category : #initialization }
TwiTimeline >> initialize [
	super initialize.
	statuses := #()
]

{ #category : #accessing }
TwiTimeline >> login [
	^ login
]

{ #category : #accessing }
TwiTimeline >> login: anObject [
	login := anObject
]

{ #category : #api }
TwiTimeline >> next [
	^ statuses := statuses, (self retrieveStatusesSince: (statuses 
		ifNotEmpty: [ statuses last id ]
		ifEmpty: [ nil ]))
]

{ #category : #api }
TwiTimeline >> restart [
	statuses := #().
	^ self next
]

{ #category : #private }
TwiTimeline >> retrieveStatusesSince: anId [
	^ (self login 
		get: self url
		with: [ :request | 
			request queryAt: 'tweet_mode' put: 'extended'.
			anId ifNotNil: [ 
				request queryAt: 'since_id' put: anId ].
			self addParametersToRequest: request ])
		collect: [ :each | TwiStatus login: self login json: each ]
]

{ #category : #accessing }
TwiTimeline >> statuses [
	^ statuses
]

{ #category : #accessing }
TwiTimeline >> statuses: anObject [
	statuses := anObject
]

{ #category : #accessing }
TwiTimeline >> url [
	^ self subclassResponsibility
]
