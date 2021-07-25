"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPuzzle,
	#superclass : #PackageManifest,
	#category : #'Puzzle-Manifest'
}

{ #category : #'code-critics' }
ManifestPuzzle class >> ruleModifiesCollectionRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#NQueen #solve:on:size: #false)) #'2021-07-24T18:48:52.513595+09:00') )
]
