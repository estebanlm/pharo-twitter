"
I fill a collection of the most recent Tweets posted by the user indicated by the screen_name or user_id parameters.
User timelines belonging to protected users may only be requested when the authenticated user either “owns” the timeline or is an approved follower of the owner.
The timeline returned is the equivalent of the one seen as a user’s profile on twitter.com.
This method can only return up to 3,200 of a user’s most recent Tweets. Native retweets of other statuses by the user is included in this total, regardless of whether include_rts is set to false when requesting this resource.
"
Class {
	#name : #TwiTimelineUser,
	#superclass : #TwiTimeline,
	#instVars : [
		'username'
	],
	#category : #Twitter
}

{ #category : #'as yet unclassified' }
TwiTimelineUser class >> login: aLogin username: aName [
	^ self new
		login: aLogin;
		username: aName;
		yourself
]

{ #category : #private }
TwiTimelineUser >> addParametersToRequest: request [
	self username 
		ifNotNil: [ request queryAt: 'screen_name' put: self username ]
]

{ #category : #accessing }
TwiTimelineUser >> url [
	^ self login urlStatuses / 'user_timeline.json'
]

{ #category : #accessing }
TwiTimelineUser >> username [
	^ username
]

{ #category : #accessing }
TwiTimelineUser >> username: anObject [
	username := anObject
]
