"
I represent a twitter entity. 
Entities are any kind of input/output that can traverse the twitter api.
"
Class {
	#name : #TwiEntity,
	#superclass : #Object,
	#instVars : [
		'json'
	],
	#category : #Twitter
}

{ #category : #'instance creation' }
TwiEntity class >> json: aJson [
	^ self new json: aJson
]

{ #category : #accessing }
TwiEntity >> json [
	^ json
]

{ #category : #accessing }
TwiEntity >> json: anObject [
	json := anObject
]

{ #category : #accessing }
TwiEntity >> jsonAt: aString [
	^ self json at: aString
]

{ #category : #accessing }
TwiEntity >> jsonAt: aString ifAbsent: aBlock [
	^ self json 
		at: aString
		ifAbsent: aBlock
]

{ #category : #accessing }
TwiEntity >> jsonAt: aString ifAbsentPut: aBlock [
	^ self json 
		at: aString
		ifAbsentPut: aBlock
]

{ #category : #accessing }
TwiEntity >> jsonAt: aString ifPresent: presentBlock ifAbsent: absentBlock [
	^ self json 
		at: aString
		ifPresent: presentBlock
		ifAbsent: absentBlock
]

{ #category : #accessing }
TwiEntity >> jsonAt: aString put: anObject [
	^ self json 
		at: aString
		put: anObject
]
