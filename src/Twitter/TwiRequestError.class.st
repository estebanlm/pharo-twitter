"
I'm a request error while comminicating with twitter.
"
Class {
	#name : #TwiRequestError,
	#superclass : #TwiError,
	#instVars : [
		'code',
		'json'
	],
	#category : #Twitter
}

{ #category : #signalling }
TwiRequestError class >> signalCode: aNumber json: jsonDictionary [
	^ self new
		code: aNumber;
		json: jsonDictionary;
		signal
]

{ #category : #signalling }
TwiRequestError class >> signalResponse: aResponse [
	^ self 
		signalCode: aResponse code 
		json: (STON fromString: aResponse contents)
]

{ #category : #accessing }
TwiRequestError >> code [
	^ code
]

{ #category : #accessing }
TwiRequestError >> code: anObject [
	code := anObject
]

{ #category : #accessing }
TwiRequestError >> json [
	^ json
]

{ #category : #accessing }
TwiRequestError >> json: anObject [
	json := anObject
]

{ #category : #accessing }
TwiRequestError >> messageText [
	^ '{1}:{2}' format: { 
	self code.	
	STON toString: self json }
]
