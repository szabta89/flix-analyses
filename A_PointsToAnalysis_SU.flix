namespace SUPT {

lat VarPointsTo_SU(node : Str, var : Str, targetHeapLoc : Object)
lat FieldPointsTo_SU(node : Str, sourceHeapLoc : Str, field : Str, targetHeapLoc : Object)

VarPointsTo_SU(node : Str, var : Str, createWrappedSObjectSingleton(targetHeapLoc)) :-
	VarPointsTo_After_FS(node, var, targetHeapLoc),
	isNotTop(targetHeapLoc).
	
VarPointsTo_SU(node : Str, var : Str, createWrappedPSObjectSingleton(targetHeapLoc)) :-
	VarPointsTo_After_FS(node, var, targetHeapLoc0),
	isTop(targetHeapLoc0),
	VarPointsTo_FI(var, targetHeapLoc).
	
FieldPointsTo_SU(node : Str, sourceHeapLoc : Str, field : Str, createWrappedSObjectSingleton(targetHeapLoc)) :-
	FieldPointsTo_After_FS(node, sourceHeapLoc, field, targetHeapLoc),
	isNotTop(targetHeapLoc).
	                                                                                                                                                                                                                                                                                                                                                                                                       
FieldPointsTo_SU(node : Str, sourceHeapLoc : Str, field : Str, createWrappedPSObjectSingleton(targetHeapLoc)) :-
	FieldPointsTo_After_FS(node, sourceHeapLoc, field, targetHeapLoc0),
	isTop(targetHeapLoc0),
	FieldPointsTo_FI(sourceHeapLoc, field, targetHeapLoc).
	
}