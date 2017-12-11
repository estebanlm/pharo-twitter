"
I fill user's 'home' timeline.

Returns a collection of the most recent Tweets and Retweets posted by the authenticating user and the users they follow. The home timeline is central to how most users interact with the Twitter service.
Up to 800 Tweets are obtainable on the home timeline. It is more volatile for users that follow many users or follow users who Tweet frequently.
"
Class {
	#name : #TwiTimelineHome,
	#superclass : #TwiTimeline,
	#category : #Twitter
}

{ #category : #accessing }
TwiTimelineHome >> url [
	^ self login urlApiStatuses / 'home_timeline.json'
]
