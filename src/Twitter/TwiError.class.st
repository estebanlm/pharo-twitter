"
I'm a generic twitter error.
"
Class {
	#name : #TwiError,
	#superclass : #Error,
	#instVars : [
		'json'
	],
	#category : #Twitter
}

{ #category : #signalling }
TwiError class >> signalCode: aNumber json: jsonDictionary [
	^ self new
		code: aNumber;
		json: jsonDictionary;
		signal
]

{ #category : #signalling }
TwiError class >> signalResponse: aResponse [
	^ self 
		signalCode: aResponse code 
		json: (STON fromString: aResponse contents)
]

{ #category : #accessing }
TwiError >> code [
	^ code
]

{ #category : #accessing }
TwiError >> code: anObject [
	code := anObject
]

{ #category : #accessing }
TwiError >> json [
	^ json
]

{ #category : #accessing }
TwiError >> json: anObject [
	json := anObject
]
