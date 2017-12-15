"
I represent a media file to be uploaded with a new status. 
While I can upload them separately, usually that does not has sense outside a status post.

"
Class {
	#name : #TwiPostMedia,
	#superclass : #Object,
	#instVars : [
		'login',
		'fileName',
		'reference'
	],
	#category : #Twitter
}

{ #category : #'instance creation' }
TwiPostMedia class >> fileName: aString reference: aReference [
	^ self new 
		fileName: aString;
		reference: aReference;
		yourself
]

{ #category : #private }
TwiPostMedia >> entityForReference [
	| mimeType fileStream size |
	mimeType := ZnMimeType forFilenameExtension: self fileName asFileReference extension.
	fileStream := self reference readStream.
	mimeType isBinary ifTrue: [ fileStream binary ].
	size := self reference entry size.
	^ (ZnStreamingEntity type: mimeType length: size)
		stream: fileStream;
		yourself
]

{ #category : #accessing }
TwiPostMedia >> fileName [
	^ fileName
]

{ #category : #accessing }
TwiPostMedia >> fileName: anObject [
	fileName := anObject
]

{ #category : #accessing }
TwiPostMedia >> login [
	^ login
]

{ #category : #accessing }
TwiPostMedia >> login: anObject [
	login := anObject
]

{ #category : #accessing }
TwiPostMedia >> reference [
	^ reference
]

{ #category : #accessing }
TwiPostMedia >> reference: anObject [
	reference := anObject
]

{ #category : #api }
TwiPostMedia >> upload [
	^ TwiMedia json: (self login 
		post: self login urlApiUploadMedia / 'upload.json'
		with: [ :request |
			request addPart: (ZnMimePart 
				fieldName: 'media' 
				fileName: self fileName 
				entity: self entityForReference) ])
]
