"
I'm a request error while comminicating with twitter.
"
Class {
	#name : #TwiRequestError,
	#superclass : #TwiError,
	#instVars : [
		'code'
	],
	#category : #Twitter
}

{ #category : #accessing }
TwiRequestError >> messageText [
	^ '{1}:{2}' format: { 
	self code.	
	STON toString: self json }
]
