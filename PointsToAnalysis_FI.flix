namespace SUPT {

rel VarPointsTo_FI(var : Str, targetHeapLoc : Str)
rel FieldPointsTo_FI(sourceHeapLoc : Str, field : Str, targetHeapLoc : Str)
rel TargetHeapLocation_FI(exp : Str, targetHeapLoc : Str)

VarPointsTo_FI(var : Str, targetHeapLoc : Str) :- 
	ICFGNode(node), 
	AssignmentSides(node, left, right),
	VariableInExpression(left, var),
	TypeInBaseVariableDeclaration(var, type),
	NotPrimitiveType(type),
	TargetHeapLocation_FI(right, targetHeapLoc).	

FieldPointsTo_FI(sourceHeapLoc : Str, field : Str, targetHeapLoc : Str) :-
	ICFGNode(node),
	AssignmentSides(node, left, right),
	FieldAccessInExpression(left, leftExp, field),
	TargetHeapLocation_FI(leftExp, sourceHeapLoc),
	TargetHeapLocation_FI(right, targetHeapLoc).

TargetHeapLocation_FI(exp : Str, targetHeapLoc : Str) :-
	VariableInExpression(exp, var),
	VarPointsTo_FI(var, targetHeapLoc).
		
TargetHeapLocation_FI(exp : Str, exp : Str) :-
	NotVariableReference(exp),
	NotFieldAccessInExpression(exp),
	NotNullLiteral(exp),
	Expression(exp).

TargetHeapLocation_FI(exp : Str, targetHeapLoc : Str) :-
	FieldAccessInExpression(exp, fromExp, fromField),
	TargetHeapLocation_FI(fromExp, sourceHeapLoc),
	FieldPointsTo_FI(sourceHeapLoc, fromField, targetHeapLoc).
	
}