Class {
	#name : #BaselineOfTwitter,
	#superclass : #BaselineOf,
	#category : #BaselineOfTwitter
}

{ #category : #'as yet unclassified' }
BaselineOfTwitter >> baseline: spec [
	<baseline>

	spec for: #common do: [
		self zincSSO: spec.
		spec package: 'Twitter' with: [ 
			spec requires: #('ZincSSO') ] ]

]

{ #category : #baselines }
BaselineOfTwitter >> zincSSO: spec [
	spec 
		configuration: 'ZincHTTPComponents'
		with: [ 
			spec
				loads: #('SSO');
				repository: 'http://smalltalkhub.com/mc/Phari/MetaRepoForPharo60/main' ]
]
