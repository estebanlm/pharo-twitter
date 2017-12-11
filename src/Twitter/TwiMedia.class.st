"
The entities section will contain a media array containing a single media object if any media object has been ‘attached’ to the Tweet. If no native media has been attached, there will be no media array in the entities. For the following reasons the extended_entities section should be used to process Tweet native media:
+ Media type will always indicate ‘photo’ even in cases of a video and GIF being attached to Tweet.
+ Even though up to four photos can be attached, only the first one will be listed in the entities section.
"
Class {
	#name : #TwiMedia,
	#superclass : #TwiEntity,
	#category : #Twitter
}

{ #category : #'accessing api' }
TwiMedia >> displayUrl [
	"URL of the media to display to clients."
	^ self jsonAt: 'display_url'.
]

{ #category : #'accessing api' }
TwiMedia >> expandedUrl [
	"An expanded version of display_url. Links to the media display page."
	^ self jsonAt: 'expanded_url'.
]

{ #category : #'accessing api' }
TwiMedia >> id [
	"ID of the media expressed as a 64-bit integer."
	^ self jsonAt: 'id'.
]

{ #category : #'accessing api' }
TwiMedia >> idStr [
	"ID of the media expressed as a string. "
	^ self jsonAt: 'id_str'.
]

{ #category : #'accessing api' }
TwiMedia >> indices [
	"An array of integers indicating the offsets within the Tweet text where the URL begins and ends. The first integer represents the location of the first character of the URL in the Tweet text. The second integer represents the location of the first non-URL character occurring after the URL (or the end of the string if the URL is the last part of the Tweet text)."
	^ self jsonAt: 'indices'.
]

{ #category : #'accessing api' }
TwiMedia >> mediaUrl [
	"An http:// URL pointing directly to the uploaded media file."
	^ self jsonAt: 'media_url'.
]

{ #category : #'accessing api' }
TwiMedia >> mediaUrlHttps [
	"An https:// URL pointing directly to the uploaded media file, for embedding on https pages."
	^ self jsonAt: 'media_url_https'.
]

{ #category : #'accessing api' }
TwiMedia >> sizes [
	"An object showing available sizes for the media file."
	^ self jsonAt: 'sizes'.
]

{ #category : #'accessing api' }
TwiMedia >> sourceStatusId [
	"Nullable. For Tweets containing media that was originally associated with a different tweet, this ID points to the original Tweet. "
	^ self jsonAt: 'source_status_id'.
]

{ #category : #'accessing api' }
TwiMedia >> sourceStatusIdStr [
	"Nullable. For Tweets containing media that was originally associated with a different tweet, this string-based ID points to the original Tweet."
	^ self jsonAt: 'source_status_id_str'.
]

{ #category : #'accessing api' }
TwiMedia >> type [
	"Type of uploaded media. Possible types include photo, video, and animated_gif."
	^ self jsonAt: 'type'.
]

{ #category : #'accessing api' }
TwiMedia >> url [
	"Wrapped URL for the media link. This corresponds with the URL embedded directly into the raw Tweet text, and the values for the indices parameter."
	^ self jsonAt: 'url'.
]
