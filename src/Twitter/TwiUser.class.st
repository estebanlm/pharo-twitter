"
The User object contains public Twitter account metadata and describes the of the Tweet. Users can be anyone or anything. They Tweet, Retweet, add Quotes to Tweets, follow others, create lists, have a home timeline, can be mentioned, and can be looked up in bulk.
"
Class {
	#name : #TwiUser,
	#superclass : #TwiEntity,
	#category : #Twitter
}

{ #category : #'accessing api' }
TwiUser >> createdAt [
	"The UTC datetime that the user account was created on Twitter. "
	^ DateAndTime fromTwitterString: (self jsonAt: 'created_at')
]

{ #category : #'accessing api' }
TwiUser >> derived [
	"Collection of Enrichment metadata derived for user. Provides the Profile Geo and Klout Enrichment metadata. See referenced documentation for more information, including JSON data dictionaries."
	^ self jsonAt: 'derived'
]

{ #category : #'accessing api' }
TwiUser >> description [
	"Nullable . The user-defined UTF-8 string describing their account."
	^ self jsonAt: 'description'
]

{ #category : #'accessing api' }
TwiUser >> favouritesCount [
	"The number of Tweets this user has liked in the account’s lifetime. British spelling used in the field name for historical reasons."
	^ self jsonAt: 'favourites_count'
]

{ #category : #'accessing api' }
TwiUser >> followersCount [
	"The number of followers this account currently has. Under certain conditions of duress, this field will temporarily indicate ""0""."
	^ self jsonAt: 'followers_count'
]

{ #category : #'accessing api' }
TwiUser >> friendsCount [
	"The number of users this account is following (AKA their ""followings""). Under certain conditions of duress, this field will temporarily indicate ""0"""
	^ self jsonAt: 'friends_count'
]

{ #category : #'accessing api' }
TwiUser >> id [
	"The integer representation of the unique identifier for this User. This number is greater than 53 bits and some programming languages may have difficulty/silent defects in interpreting it. Using a signed 64 bit integer for storing this identifier is safe. Use id_str for fetching the identifier to stay on the safe side. See Twitter IDs, JSON and Snowflake"
	^ self jsonAt: 'id'
]

{ #category : #'accessing api' }
TwiUser >> idStr [
	"The string representation of the unique identifier for this User. Implementations should use this rather than the large, possibly un-consumable integer in id."
	^ self jsonAt: 'id_str'
]

{ #category : #'accessing api' }
TwiUser >> isContributorsEnabled [
	"Indicates that the user has an account with 'contributor mode' enabled, allowing for Tweets issued by the user to be co-authored by another account. Rarely true (this is a legacy field)"
	^ self jsonAt: 'contributors_enabled'
]

{ #category : #'accessing api' }
TwiUser >> isDefaultProfile [
	"When true, indicates that the user has not altered the theme or background of their user profile."
	^ self jsonAt: 'default_profile'.
]

{ #category : #'accessing api' }
TwiUser >> isDefaultProfileImage [
	"When true, indicates that the user has not uploaded their own profile image and a default image is used instead. "
	^ self jsonAt: 'default_profile_image'.
]

{ #category : #'accessing api' }
TwiUser >> isGeoEnabled [
	"When true, indicates that the user has enabled the possibility of geotagging their Tweets. This field must be true for the current user to attach geographic data when using POST statuses / update ."
	^ self jsonAt: 'geo_enabled'
]

{ #category : #'accessing api' }
TwiUser >> isProfileBackgroundTile [
	"When true, indicates that the user’s profile_background_image_url should be tiled when displayed."
	^ self jsonAt: 'profile_background_tile'
]

{ #category : #'accessing api' }
TwiUser >> isProfileUseBackgroundImage [
	"When true, indicates the user wants their uploaded background image to be used"
	^ self jsonAt: 'profile_use_background_image'.
]

{ #category : #'accessing api' }
TwiUser >> isProtected [
	"When true, indicates that this user has chosen to protect their Tweets. See About Public and Protected Tweets ."
	^ self jsonAt: 'protected'
]

{ #category : #'accessing api' }
TwiUser >> isVerified [
	"When true, indicates that the user has a verified account. See Verified Accounts."
	^ self jsonAt: 'verified'
]

{ #category : #'accessing api' }
TwiUser >> lang [
	"The BCP 47 code for the user’s self-declared user interface language. May or may not have anything to do with the content of their Tweets."
	^ self jsonAt: 'lang'
]

{ #category : #'accessing api' }
TwiUser >> listedCount [
	"The number of public lists that this user is a member of. "
	^ self jsonAt: 'listed_count'
]

{ #category : #'accessing api' }
TwiUser >> location [
	"Nullable . The user-defined location for this account’s profile. Not necessarily a location, nor machine-parseable. This field will occasionally be fuzzily interpreted by the Search service."
	^ self jsonAt: 'location'
]

{ #category : #'accessing api' }
TwiUser >> name [
	"The name of the user, as they’ve defined it. Not necessarily a person’s name. Typically capped at 20 characters, but subject to change."
	^ self jsonAt: 'name'
]

{ #category : #'accessing api' }
TwiUser >> profileBackgroundColor [
	"The hexadecimal color chosen by the user for their background."
	^ self jsonAt: 'profile_background_color'
]

{ #category : #'accessing api' }
TwiUser >> profileBackgroundImageUrl [
	"A HTTP-based URL pointing to the background image the user has uploaded for their profile."
	^ self jsonAt: 'profile_background_image_url'
]

{ #category : #'accessing api' }
TwiUser >> profileBackgroundImageUrlHttps [
	"A HTTPS-based URL pointing to the background image the user has uploaded for their profile."
	^ self jsonAt: 'profile_background_image_url_https'
]

{ #category : #'accessing api' }
TwiUser >> profileBannerUrl [
	"The HTTPS-based URL pointing to the standard web representation of the user’s uploaded profile banner. By adding a final path element of the URL, it is possible to obtain different image sizes optimized for specific displays. For size variants, please see User Profile Images and Banners ."
	^ self jsonAt: 'profile_banner_url'
]

{ #category : #'accessing api' }
TwiUser >> profileImageUrl [
	"A HTTP-based URL pointing to the user’s profile image. See User Profile Images and Banners."
	^ self jsonAt: 'profile_image_url'
]

{ #category : #'accessing api' }
TwiUser >> profileImageUrlHttps [
	"A HTTPS-based URL pointing to the user’s profile image."
	^ self jsonAt: 'profile_image_url_https'
]

{ #category : #'accessing api' }
TwiUser >> profileLinkColor [
	"The hexadecimal color the user has chosen to display links with in their Twitter UI."
	^ self jsonAt: 'profile_link_color'
]

{ #category : #'accessing api' }
TwiUser >> profileSidebarBorderColor [
	"The hexadecimal color the user has chosen to display sidebar borders with in their Twitter UI."
	^ self jsonAt: 'profile_sidebar_border_color'
]

{ #category : #'accessing api' }
TwiUser >> profileSidebarFillColor [
	"The hexadecimal color the user has chosen to display sidebar backgrounds with in their Twitter UI."
	^ self jsonAt: 'profile_sidebar_fill_color'
]

{ #category : #'accessing api' }
TwiUser >> profileTextColor [
	"The hexadecimal color the user has chosen to display text with in their Twitter UI."
	^ self jsonAt: 'profile_text_color'.
]

{ #category : #'accessing api' }
TwiUser >> screenName [
	"The screen name, handle, or alias that this user identifies themselves with. screen_names are unique but subject to change. Use id_str as a user identifier whenever possible. Typically a maximum of 15 characters long, but some historical accounts may exist with longer names."
	^ self jsonAt: 'screen_name'
]

{ #category : #'accessing api' }
TwiUser >> statusesCount [
	"The number of Tweets (including retweets) issued by the user."
	^ self jsonAt: 'statuses_count'
]

{ #category : #'accessing api' }
TwiUser >> timeZone [
	"Nullable . A string describing the Time Zone this user declares themselves within."
	^ self jsonAt: 'time_zone'
]

{ #category : #'accessing api' }
TwiUser >> url [
	"Nullable . A URL provided by the user in association with their profile. "
	^ self jsonAt: 'url'
]

{ #category : #'accessing api' }
TwiUser >> utcOffset [
	"Nullable . The offset from GMT/UTC in seconds."
	^ self jsonAt: 'utc_offset'
]

{ #category : #'accessing api' }
TwiUser >> withheldInCountries [
	"When present, indicates a textual representation of the two-letter country codes this user is withheld from. "
	^ self jsonAt: 'withheld_in_countries'.
]

{ #category : #'accessing api' }
TwiUser >> withheldScope [
	"When present, indicates whether the content being withheld is the ""status"" or a ""user."""
	^ self jsonAt: 'withheld_scope'.
]
