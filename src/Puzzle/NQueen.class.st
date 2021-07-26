"
N Queen Solver
"
Class {
	#name : #NQueen,
	#superclass : #Object,
	#instVars : [
		'bordSize',
		'bordBound',
		'teritories',
		'results'
	],
	#category : #'Puzzle-base'
}

{ #category : #'private - utility' }
NQueen class >> convertResult: result [

	| aCollection aLink |
	aLink := result.
	aCollection := OrderedCollection new.
	[aLink notNil] whileTrue: 
		[ aCollection add: aLink value.
		aLink := aLink nextLink ].

	^aCollection asSortedCollection: [ :p1 :p2 | p1 x < p2 x ]
]

{ #category : #constants }
NQueen class >> directions [

	^{ (-1)@0 . (-1)@1 . 0@1 . 1@1 . 1@0 . 1@(-1) . 0@(-1) . (-1)@(-1) }
]

{ #category : #'instance creation' }
NQueen class >> solve: anInteger [
	
	"NQueen solve: 8"
	
	^self new
		bordSize: anInteger;
		solve.
]

{ #category : #accessing }
NQueen >> bordSize: anInteger [
	
	bordSize := anInteger.
	bordBound := 0 @ 0 corner: (bordSize @ bordSize).
]

{ #category : #execution }
NQueen >> candidates [

	| candidates |
	candidates := OrderedCollection new.
	0 to: bordSize - 1 do: [ :x |
		0 to: bordSize - 1 do: [ :y |
			candidates add: (x @ y) ] ].
	^candidates

]

{ #category : #initialization }
NQueen >> initialize [
	
	self bordSize: 8.
	teritories := Dictionary new.
	results := OrderedCollection new.
]

{ #category : #initialization }
NQueen >> makeTeritory: aPoint [
	| teritory |
	teritory := OrderedCollection new.
	self class directions do: [:direction |
		self makeTeritory: aPoint direction: direction on: teritory].
	teritory add: aPoint.
	^teritory
]

{ #category : #initialization }
NQueen >> makeTeritory: aPoint direction: direction on: aCollection [

	| p |
	p := aPoint + direction.
	[ bordBound containsPoint: p ]
		whileTrue: 
			[ aCollection add: p.
			p := p + direction ]

]

{ #category : #execution }
NQueen >> solve [

	| candidates |
	candidates := self candidates.
	
	candidates do: [ :aPoint |
		teritories at: aPoint put: (self makeTeritory: aPoint)].
	
	self solve: candidates on: nil size: 0.
	
	^results
]

{ #category : #execution }
NQueen >> solve: candidates on: acc size: n [
	
	n = bordSize ifTrue:
			 [ results add: (self class convertResult: acc).
				^self].
	
	candidates do:
		[ :aPoint |
			aPoint x > n ifTrue: [ ^self ].
			self
				solve: (candidates reject: [ :each | (teritories at: aPoint) includes: each])
				on: aPoint ~~> acc 
				size: n + 1].


]
