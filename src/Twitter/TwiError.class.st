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

{ #category : #private }
TwiError class >> classFor: aResponse json: jsonDictionary [
	^ self allSubclasses 
		detect: [ :each | each willHandle: aResponse json: jsonDictionary ]
		ifNone: [ self defaultErrorClass ]
]

{ #category : #private }
TwiError class >> defaultErrorClass [
	^ TwiRequestError
]

{ #category : #signalling }
TwiError class >> signalCode: aNumber json: jsonDictionary [
	^ self new
		code: aNumber;
		json: jsonDictionary;
		signal
]

{ #category : #signalling }
TwiError class >> signalResponse: aResponse [
	| json |
	json := STON fromString: aResponse contents.
	^ (self classFor: aResponse json: json)
		signalCode: aResponse code 
		json: json
]

{ #category : #private }
TwiError class >> willHandle: aResponse json: aJson [
	^ false
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
