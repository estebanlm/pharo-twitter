"
I'm a media attachment as it is anwered for TwiPostMedia.

"
Class {
	#name : #TwiMediaAttachment,
	#superclass : #TwiEntity,
	#category : #Twitter
}

{ #category : #'accessing api' }
TwiMediaAttachment >> expiresAfterSecs [
	""
	^ self jsonAt: 'expires_after_secs'.
]

{ #category : #'accessing api' }
TwiMediaAttachment >> image [
	""
	^ self jsonAt: 'image'.
]

{ #category : #'accessing api' }
TwiMediaAttachment >> mediaId [
	""
	^ self jsonAt: 'media_id'.
]

{ #category : #'accessing api' }
TwiMediaAttachment >> mediaIdString [
	""
	^ self jsonAt: 'media_id_string'.
]

{ #category : #'accessing api' }
TwiMediaAttachment >> size [
	""
	^ self jsonAt: 'size'.
]
