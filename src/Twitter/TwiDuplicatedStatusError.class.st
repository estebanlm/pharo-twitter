"
I'm an error that happens when I try to post a duplicated status.
"
Class {
	#name : #TwiDuplicatedStatusError,
	#superclass : #TwiError,
	#category : #Twitter
}

{ #category : #private }
TwiDuplicatedStatusError class >> willHandle: aResponse json: jsonDictionary [
	^ aResponse code = 403 
		and: [ (jsonDictionary at: 'code') = 187 ]
]
