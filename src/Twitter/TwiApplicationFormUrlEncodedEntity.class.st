"
I'm a twitter post entity. 
Because twitter requires a standard percent  encoding, the safe-set of my parent does not satisfy requirements so I need to override that encoding with my own.
"
Class {
	#name : #TwiApplicationFormUrlEncodedEntity,
	#superclass : #ZnApplicationFormUrlEncodedEntity,
	#category : #Twitter
}

{ #category : #private }
TwiApplicationFormUrlEncodedEntity >> encode: key with: encoder [
	^ ZnResourceMetaUtils 
		encodePercent: key 
		safeSet: #rfc3986SafeSet 
		encoder: encoder
]

{ #category : #private }
TwiApplicationFormUrlEncodedEntity >> writeQueryFields: dictionary withEncoder: encoder on: stream [
	| first |
	first := true.
	dictionary keysAndValuesDo: [ :key :value | 
		first ifFalse: [ stream nextPut: $& ].
		first := false.
		stream nextPutAll: (self encode: key with: encoder).
		value ifNotNil: [ 
			stream
				nextPut: $=;
				nextPutAll: (self encode: key with: encoder) ] ]
]

{ #category : #writing }
TwiApplicationFormUrlEncodedEntity >> writeRepresentationOn: stream [
	| encoder |
	
	encoder := self contentType charSet
		ifNotNil: [ :charSet | (ZnCharacterEncoder newForEncoding: charSet) ]
		ifNil: [ ZnCharacterEncoder utf8 ].

	self
		writeQueryFields: self fields 
		withEncoder: encoder 
		on: stream
]
