Extension { #name : #DateAndTime }

{ #category : #'*Twitter' }
DateAndTime class >> fromTwitterString: aString [
	"'Sat Dec 09 15:26:04 +0000 2017'"
	| date time |

	date := aString substrings.
	time := date fourth substrings: ':'.
	^ self 
		year: date sixth asInteger
		month: (#('Jan' 'Feb' 'Mar' 'Apr' 'May' 'Jun' 'Jul' 'Aug' 'Sep' 'Oct' 'Nov' 'Dec') indexOf: date second)  
		day:  date third asInteger
		hour: time first asInteger
		minute: time second asInteger 
		second: time third asInteger
		offset: date fifth asInteger hours
]
