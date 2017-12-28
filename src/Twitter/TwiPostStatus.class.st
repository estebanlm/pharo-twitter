"
I'm a post status: a status to create a post. 
This is different to a regular status because data sent is different to data received and responsibilities of each one is different. 

I'm used to post a new status. 
I can have a content text, reply status and medias. 

NOTE: the medias I will add are also special objects, instances of MdnPostMedia.

example: 

TwiPostStatus new
	login: aLogin;
	content: 'some text';
	addMedia: (MdnPostMedia fileName: 'a name' reference: aFileReference );
	post.
	
"
Class {
	#name : #TwiPostStatus,
	#superclass : #Object,
	#instVars : [
		'login',
		'content',
		'medias',
		'mediaAttachments',
		'json'
	],
	#category : #Twitter
}

{ #category : #private }
TwiPostStatus class >> classFor: aString [
	^ self withAllSubclasses 
		detect: [ :each | each isValidFor: aString ]
]

{ #category : #'instance creation' }
TwiPostStatus class >> content: aString [
	^ (self classFor: aString) new content: aString
]

{ #category : #private }
TwiPostStatus class >> isValidFor: aString [
	^ aString size <= self postMaxSize
]

{ #category : #private }
TwiPostStatus class >> postMaxSize [
	^ 280
]

{ #category : #accessing }
TwiPostStatus >> addMedia: aPostMedia [
	medias ifNil: [ medias := #() ].
	medias := medias copyWith: aPostMedia
]

{ #category : #private }
TwiPostStatus >> addPostParametersTo: request [
	"request formAt: 'tweet_mode' put: 'extended'."

	request formAt: 'status' put: self content.
	mediaAttachments isEmptyOrNil ifFalse: [ 
		request 
			formAt: 'media_ids' 
			put: (mediaAttachments collect: #mediaId) asCommaString ].
	
	"may or may not be present"
	self inReplyToStatusId 
		ifNotNil: [ :value | request formAt: 'in_reply_to_status_id' put: value ].
	self excludeReplyUserIds 
		ifNotNil: [ :value | request formAt: 'exclude_reply_user_ids' put: value  ].
	self attachmentUrl
		ifNotNil: [ :value | request formAt: 'attachment_url' put: value  ].
	self lat
		ifNotNil: [ :value | request formAt: 'lat' put: value  ].
	self long
		ifNotNil: [ :value | request formAt: 'long' put: value  ].
	self placeId
		ifNotNil: [ :value | request formAt: 'place_id' put: value  ].
	"this are booleans, but they are niled because their presence is optional "
	self isAutoPopulateReplyMetadata
		ifNotNil: [ :value | request formAt: 'auto_populate_reply_metadata' put: value asString ].
	(self isPossiblySensitive notNil and: [ self isPossiblySensitive ])
		ifTrue: [ :value | request formAt: 'possibly_sensitive' put: value asString ].
	self isTrimUser
		ifNotNil: [ :value | 	request formAt: 'trim_user' put: value asString ].
	self isEnableDmCommands
		ifNotNil: [ 	:value | request formAt: 'enable_dm_commands' put: value asString ].
	self isFailDmCommands
		ifNotNil: [ 	:value | request formAt: 'fail_dm_commands' put: value asString ].
	self isDisplayCoordinates
		ifNotNil: [ 	:value | request formAt: 'display_coordinates' put: value asString ]
]

{ #category : #converting }
TwiPostStatus >> asTwitterPostStatus [
	^ self
]

{ #category : #'accessing api' }
TwiPostStatus >> attachmentUrl [
	""
	^ self jsonAt: 'attachment_url'.
]

{ #category : #'accessing api' }
TwiPostStatus >> attachmentUrl: anObject [
	^ self jsonAt: 'attachment_url' put: anObject.
]

{ #category : #'accessing api' }
TwiPostStatus >> autoPopulateReplyMetadata: anObject [
	^ self jsonAt: 'auto_populate_reply_metadata' put: anObject.
]

{ #category : #accessing }
TwiPostStatus >> content [
	^ content
]

{ #category : #accessing }
TwiPostStatus >> content: anObject [
	content := anObject
]

{ #category : #'accessing api' }
TwiPostStatus >> displayCoordinates: anObject [
	^ self jsonAt: 'display_coordinates' put: anObject.
]

{ #category : #'accessing api' }
TwiPostStatus >> enableDmCommands: anObject [
	^ self jsonAt: 'enable_dm_commands' put: anObject.
]

{ #category : #'accessing api' }
TwiPostStatus >> excludeReplyUserIds [
	""
	^ self jsonAt: 'exclude_reply_user_ids'.
]

{ #category : #'accessing api' }
TwiPostStatus >> excludeReplyUserIds: anObject [
	^ self jsonAt: 'exclude_reply_user_ids' put: anObject.
]

{ #category : #'accessing api' }
TwiPostStatus >> failDmCommands: anObject [
	^ self jsonAt: 'fail_dm_commands' put: anObject.
]

{ #category : #'accessing api' }
TwiPostStatus >> inReplyToStatusId [
	""
	^ self jsonAt: 'in_reply_to_status_id'.
]

{ #category : #'accessing api' }
TwiPostStatus >> inReplyToStatusId: anObject [
	^ self jsonAt: 'in_reply_to_status_id' put: anObject.
]

{ #category : #initialization }
TwiPostStatus >> initialize [
	super initialize.
	json := Dictionary new
]

{ #category : #'accessing api' }
TwiPostStatus >> isAutoPopulateReplyMetadata [
	""
	^ self jsonAt: 'auto_populate_reply_metadata'.
]

{ #category : #'accessing api' }
TwiPostStatus >> isDisplayCoordinates [
	""
	^ self jsonAt: 'display_coordinates'.
]

{ #category : #'accessing api' }
TwiPostStatus >> isEnableDmCommands [
	""
	^ self jsonAt: 'enable_dm_commands'.
]

{ #category : #'accessing api' }
TwiPostStatus >> isFailDmCommands [
	""
	^ self jsonAt: 'fail_dm_commands'.
]

{ #category : #'accessing api' }
TwiPostStatus >> isPossiblySensitive [
	""
	^ self jsonAt: 'possibly_sensitive'.
]

{ #category : #'accessing api' }
TwiPostStatus >> isTrimUser [
	""
	^ self jsonAt: 'trim_user'.
]

{ #category : #accessing }
TwiPostStatus >> json [
	^ json
]

{ #category : #accessing }
TwiPostStatus >> jsonAt: aName [
	^ self json at: aName ifAbsent: [ nil ]
]

{ #category : #accessing }
TwiPostStatus >> jsonAt: aName put: anObject [
	^ self json at: aName put: anObject
]

{ #category : #'accessing api' }
TwiPostStatus >> lat [
	""
	^ self jsonAt: 'lat'.
]

{ #category : #'accessing api' }
TwiPostStatus >> lat: anObject [
	^ self jsonAt: 'lat' put: anObject.
]

{ #category : #accessing }
TwiPostStatus >> login [
	^ login
]

{ #category : #accessing }
TwiPostStatus >> login: anObject [
	login := anObject
]

{ #category : #'accessing api' }
TwiPostStatus >> long [
	""
	^ self jsonAt: 'long'.
]

{ #category : #'accessing api' }
TwiPostStatus >> long: anObject [
	^ self jsonAt: 'long' put: anObject.
]

{ #category : #'accessing api' }
TwiPostStatus >> mediaIds [
	""
	^ self jsonAt: 'media_ids'.
]

{ #category : #'accessing api' }
TwiPostStatus >> mediaIds: anObject [
	^ self jsonAt: 'media_ids' put: anObject.
]

{ #category : #accessing }
TwiPostStatus >> medias [
	^ medias
	
]

{ #category : #accessing }
TwiPostStatus >> medias: aCollection [
	medias := aCollection
]

{ #category : #'accessing api' }
TwiPostStatus >> placeId [
	""
	^ self jsonAt: 'place_id'.
]

{ #category : #'accessing api' }
TwiPostStatus >> placeId: anObject [
	^ self jsonAt: 'place_id' put: anObject.
]

{ #category : #'accessing api' }
TwiPostStatus >> possiblySensitive: anObject [
	^ self jsonAt: 'possibly_sensitive' put: anObject.
]

{ #category : #api }
TwiPostStatus >> post [
	"First try to collect post medias" 
	self medias ifNotNil: [ self uploadMedias ].
	"then actually post (and answer a status)"
	^ self postStatus
]

{ #category : #api }
TwiPostStatus >> postStatus [
	^ TwiStatus
		login: self login
		json: (self login 
			post: self login urlApiStatuses / 'update.json'
			with: [ :request | self addPostParametersTo: request ])
]

{ #category : #'accessing api' }
TwiPostStatus >> trimUser: anObject [
	^ self jsonAt: 'trim_user' put: anObject.
]

{ #category : #private }
TwiPostStatus >> uploadMedia: aPostMedia [
	^ aPostMedia 
		login: self login;
		upload
]

{ #category : #private }
TwiPostStatus >> uploadMedias [
	mediaAttachments := self medias collect: [ :each | self uploadMedia: each ]	
]
