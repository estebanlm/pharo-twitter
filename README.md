# pharo-twitter
a [Pharo](http://pharo.org) API for Twitter

## Installation 
- You need Pharo 7.0

```Smalltalk
Metacello new 
  repository: 'github://estebanlm/pharo-twitter/src';
  baseline: 'Twitter';
  load.
```

## Examples

### Reading your timeline.

```Smalltalk
twitterLogin := TwiLogin 
	consumerKey: 'CONSUMER_KEY' 
	consumerSecret: 'CONSUMER_SECRET'
	accessToken: 'ACCESS_TOKEN'
	accessTokenSecret: 'ACCESS_TOKEN_SECRET'.

twitterLogin timelineUser includeRTs: true; next.
twitterLogin timelineHome next.
```
