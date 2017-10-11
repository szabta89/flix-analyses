namespace SUPT {

lat VarPointsTo_Before_FS(node : Str, var : Str, targetHeapLoc : SObject)
lat VarPointsTo_After_FS(node : Str, var : Str, targetHeapLoc : SObject)
lat VarPointsTo_At_FS(node : Str, var : Str, targetHeapLoc : SObject)
rel VarPointsTo_At_FS0(node : Str, var : Str)
lat FieldPointsTo_After_FS(node : Str, sourceHeapLoc : Str, field : Str, targetHeapLoc : SObject)
lat FieldPointsTo_Before_FS(node : Str, sourceHeapLoc : Str, field : Str, targetHeapLoc : SObject)
lat FieldPointsTo_At_FS(node : Str, sourceHeapLoc : Str, field : Str, targetHeapLoc : SObject)
lat TargetHeapLocation_FS(node : Str, exp : Str, targetHeapLocWrapped : Str, targetHeapLoc : SObject)

VarPointsTo_Before_FS(node : Str, var : Str, targetHeapLoc : SObject) :- 
	CFGEdge(source, node),
	VarPointsTo_After_FS(source, var, targetHeapLoc).
	
VarPointsTo_After_FS(node : Str, var : Str, targetHeapLoc : SObject) :- 
	!WriteToVariable(node, var),	
  	VarPointsTo_Before_FS(node, var, targetHeapLoc).

VarPointsTo_After_FS(node : Str, var : Str, targetHeapLoc : SObject) :- 
	VarPointsTo_At_FS0(node, var0),
	neq(var, var0),
  	VarPointsTo_Before_FS(node, var, targetHeapLoc).
  	
VarPointsTo_After_FS(node : Str, var : Str, targetHeapLoc : SObject) :- 	
	TypeInBaseVariableDeclaration(var, type),
	NotPrimitiveType(type),
	VarPointsTo_At_FS(node, var, targetHeapLoc).
	
VarPointsTo_At_FS(node : Str, var : Str, targetHeapLoc : SObject) :-
	AssignmentSides(node, left, right),
	VariableInExpression(left, var),
	TargetHeapLocation_FS(node, right, _, targetHeapLoc).
	
VarPointsTo_At_FS0(node : Str, var : Str) :- 
	AssignmentSides(node, left, _),
	VariableInExpression(left, var).
	
FieldPointsTo_Before_FS(node : Str, sourceHeapLoc : Str, field : Str, targetHeapLoc : SObject) :- 
	CFGEdge(source, node),
	FieldPointsTo_After_FS(source, sourceHeapLoc, field, targetHeapLoc).

FieldPointsTo_After_FS(node : Str, sourceHeapLoc : Str, field : Str, targetHeapLoc : SObject) :- 
	!WriteToField(node, field),
	FieldPointsTo_Before_FS(node, sourceHeapLoc, field, targetHeapLoc).

FieldPointsTo_After_FS(node : Str, sourceHeapLoc : Str, field : Str, targetHeapLoc : SObject) :- 
	FieldPointsTo_At_FS(node, sourceHeapLoc0, field, targetHeapLoc0),
	FieldPointsTo_Before_FS(node, sourceHeapLoc, field, targetHeapLoc),
	neq(sourceHeapLoc0, sourceHeapLoc).

FieldPointsTo_After_FS(node : Str, sourceHeapLoc : Str, field : Str, targetHeapLoc : SObject) :- 
	FieldPointsTo_At_FS(node, sourceHeapLoc, field, targetHeapLoc).	
	
FieldPointsTo_At_FS(node : Str, getExpression(sourceHeapLoc), field : Str, targetHeapLoc : SObject) :-
	AssignmentSides(node, left, right),
	FieldAccessInExpression(left, sourceExp, field),
	TargetHeapLocation_FS(node, sourceExp, _, sourceHeapLoc),
	isNotTop(sourceHeapLoc),
	TargetHeapLocation_FS(node, right, _, targetHeapLoc).

FieldPointsTo_At_FS(node : Str, sourceHeapLoc, field : Str, targetHeapLoc : SObject) :-
	AssignmentSides(node, left, right),
	FieldAccessInExpression(left, sourceExp, field),
	TargetHeapLocation_FS(node, sourceExp, _, sourceHeapLoc0),
	isTop(sourceHeapLoc0),
	TargetHeapLocation_FI(sourceExp, sourceHeapLoc),
	TargetHeapLocation_FS(node, right, _, targetHeapLoc).

TargetHeapLocation_FS(node : Str, exp : Str, exp, createSObjectSingleton(exp)) :-
	Ancestor(exp, node),
	NotVariableReference(exp),
	NotFieldAccessInExpression(exp),
	NotNullLiteral(exp),
	Expression(exp).
	
TargetHeapLocation_FS(node : Str, exp : Str, getExpression(targetHeapLoc), targetHeapLoc : SObject) :-
	Ancestor(exp, node),
	VariableInExpression(exp, var),
	VarPointsTo_Before_FS(node, var, targetHeapLoc).

TargetHeapLocation_FS(node : Str, exp : Str, "", createSObjectTop()) :-
	Ancestor(exp, node),
	FieldAccessInExpression(exp, sourceExp, field),
	TargetHeapLocation_FS(node, sourceExp, _, sourceHeapLoc),
	isTop(sourceHeapLoc).

TargetHeapLocation_FS(node : Str, exp : Str, getExpression(targetHeapLoc), targetHeapLoc : SObject) :-
	Ancestor(exp, node),
	FieldAccessInExpression(exp, sourceExp, field),
	TargetHeapLocation_FS(node, sourceExp, sourceHeapLocWrapped, sourceHeapLoc),
	isNotTop(sourceHeapLoc),
	FieldPointsTo_Before_FS(node, sourceHeapLocWrapped, field, targetHeapLoc).
	
}