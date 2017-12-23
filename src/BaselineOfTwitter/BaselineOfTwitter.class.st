Class {
	#name : #BaselineOfTwitter,
	#superclass : #BaselineOf,
	#category : #BaselineOfTwitter
}

{ #category : #baselines }
BaselineOfTwitter >> baseline: spec [
	<baseline>

	spec for: #common do: [
		self oauth1: spec.
		spec package: 'Twitter' with: [ 
			spec requires: #('oauth1') ] ]

]

{ #category : #'external projects' }
BaselineOfTwitter >> oauth1: spec [
	spec 
		configuration: 'NeoJSON' 
		with: [ spec repository: 'http://mc.stfx.eu/Neo' ].
	spec 
		package: 'Zinc-SSO-OAuth1-Core' 
		with: [ 
			spec 
				repository: 'http://mc.stfx.eu/ZincHTTPComponents';
				requires: #('NeoJSON') ].

	spec group: 'oauth1' with: #('Zinc-SSO-OAuth1-Core')
]
