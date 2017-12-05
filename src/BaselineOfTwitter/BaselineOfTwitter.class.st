Class {
	#name : #BaselineOfTwitter,
	#superclass : #BaselineOf,
	#category : #BaselineOfTwitter
}

{ #category : #baselines }
BaselineOfTwitter >> baseline: spec [
	<baseline>

	spec for: #common do: [
		self zincSSO: spec.
		spec package: 'Twitter' with: [ 
			spec requires: #('ZincHTTPComponents') ] ]

]

{ #category : #baselines }
BaselineOfTwitter >> zincSSO: spec [
	spec 
		configuration: 'ZincHTTPComponents'
		with: [ 
			spec
				loads: #('SSO');
				repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo60/main' ]
]
