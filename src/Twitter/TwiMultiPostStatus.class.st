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

{ #category : #api }
TwiMultiPostStatus >> postStatus [
	| statuses savedMedias |
	
	savedMedias := mediaAttachments.
	mediaAttachments := nil.
	statuses := self content splitFullWordsWithLimit: self class postMaxSize - 6.

	"first I post all status without media"
	statuses allButLast withIndexDo: [ :each :index | 
		self content: each, (' ({1}/{2})' format: { index. statuses size }).
		super postStatus ].
	"now I post final status with medias included"
	mediaAttachments := savedMedias.
	self content: statuses last, (' ({1}/{1})' format: { statuses size }).
	super postStatus
]
