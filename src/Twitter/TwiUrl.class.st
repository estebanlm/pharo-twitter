"
I represent an url from the expandedEntities of a TwiStatus.

https://developer.twitter.com/en/docs/tweets/data-dictionary/overview/entities-object
"
Class {
	#name : #TwiUrl,
	#superclass : #TwiEntity,
	#category : #Twitter
}

{ #category : #'accessing api' }
TwiUrl >> displayUrl [
	"URL pasted/typed into Tweet."
	^ self jsonAt: 'display_url'
]

{ #category : #'accessing api' }
TwiUrl >> expandedUrl [
	"Expanded version of 'display_url'"
	^ self jsonAt: 'expanded_url'
]

{ #category : #'accessing api' }
TwiUrl >> indices [
	"An array of integers representing offsets within the Tweet text where the URL begins and ends. The first integer represents the location of the first character of the URL in the Tweet text. The second integer represents the location of the first non-URL character after the end of the URL."
	^ self jsonAt: 'indices'
]

{ #category : #'accessing api' }
TwiUrl >> url [
	"Wrapped URL, corresponding to the value embedded directly into the raw Tweet text, and the values for the indices parameter"
	^ self jsonAt: 'url'
]
