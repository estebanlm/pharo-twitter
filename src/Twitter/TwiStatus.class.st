"
I represent a status (a twit) from twitter.

https://developer.twitter.com/en/docs/tweets/data-dictionary/overview/tweet-object
"
Class {
	#name : #TwiStatus,
	#superclass : #TwiEntity,
	#instVars : [
		'login'
	],
	#category : #Twitter
}

{ #category : #'instance creation' }
TwiStatus class >> login: aLogin json: aJson [
	^ self new 
		login: aLogin;
		json: aJson;
		yourself
]

{ #category : #'accessing api' }
TwiStatus >> createdAt [
	"UTC time when this Tweet was created"
	^ self jsonAt: 'created_at'
]

{ #category : #gtinspector }
TwiStatus >> gtInspectorStatusIn: composite [
	"<gtInspectorPresentationOrder: 0>  
	 
	composite text
		title: self account acct, ' at ', self createdAt asLocalStringYMDHM;
		display: self content"
]

{ #category : #'accessing api' }
TwiStatus >> id [
	"The integer representation of the unique identifier for this Tweet. This number is greater than 53 bits and some programming languages may have difficulty/silent defects in interpreting it. Using a signed 64 bit integer for storing this identifier is safe. Use id_str for fetching the identifier to stay on the safe side. See Twitter IDs, JSON and Snowflake"
	^ self jsonAt: 'id'
]

{ #category : #accessing }
TwiStatus >> login [
	^ login
]

{ #category : #accessing }
TwiStatus >> login: anObject [
	login := anObject
]
