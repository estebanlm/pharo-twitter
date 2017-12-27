"
I'm an authentication error. 
This error is tricky because twitter answers authentication problem when something went wrong (like bad coding or something)
"
Class {
	#name : #TwiAuthenticationRequiredError,
	#superclass : #TwiError,
	#category : #Twitter
}

{ #category : #accessing }
TwiAuthenticationRequiredError >> messageText [
	^ '{1}: {2}' format: { self code. (self json at: 'errors') first at: 'message' }
]
