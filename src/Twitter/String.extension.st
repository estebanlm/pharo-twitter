Extension { #name : #String }

{ #category : #'*Twitter' }
String >> asTwitterPostStatus [
	^ TwiPostStatus content: self
]
