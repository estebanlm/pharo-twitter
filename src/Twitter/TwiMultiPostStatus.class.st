"
I'm a cascade post (when text is longer than 280 characters, it will be splitted into a cascade)
"
Class {
	#name : #TwiMultiPostStatus,
	#superclass : #TwiPostStatus,
	#category : #Twitter
}

{ #category : #private }
TwiMultiPostStatus class >> isValidFor: aString [
	^ aString size > self postMaxSize
]
