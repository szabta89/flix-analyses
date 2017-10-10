namespace SUPT {

	index Parent({child}, {child, parent})
    index Ancestor({descendant}, {descendant, ancestor})
    index AssignmentSides({node}, {node, right}, {node, left})
    index FieldAccessInExpression({container}, {container, exp})

	// Input relations
	rel Expression(exp : Str) //
	rel ExpressionStatement(stmt : Str) //
	rel BaseAssignmentExpression(exp : Str) //
	rel IAncestorRelevantNode(node : Str) //
	rel LValueInBaseAssignmentExpression(exp : Str, left : Str) //
	rel RValueInBaseAssignmentExpression(exp : Str, right : Str) //
	rel ExpressionInExpressionStatement(stmt : Str, exp : Str) //
	
	rel BaseVariableDeclaration(var : Str) //
	rel VariableReference(exp : Str) //
	rel VariableDeclarationInVariableReference(exp : Str, var : Str) //
	
	rel DotExpression(exp : Str) //
	rel OperandInDotExpression(exp : Str, operand : Str) //
	rel OperationInDotExpression(exp : Str, operation : Str) //
	rel FieldReferenceOperation(operation : Str) //
	rel FieldDeclaration(field : Str) //
	rel FieldDeclarationInFieldReferenceOperation(operation : Str, field : Str) //
	rel TypeInBaseVariableDeclaration(var : Str, type : Str) //
	
	// Derived relations
	rel AssignmentSides(node : Str, left : Str, right : Str) //
	rel VariableInExpression(exp : Str, var : Str) //
	rel FieldAccessInExpression(container : Str, exp : Str, field : Str) //
	rel Ancestor(descendant : Str, ancestor : Str) //
	rel Parent(child : Str, parent : Str) //
	
	rel NotVariableReference(exp : Str) //
	rel NotFieldAccessInExpression(exp : Str) //
	rel NotPrimitiveType(type : Str) //
	rel NotNullLiteral(exp : Str) //
	rel NoWriteToVariable(node : Str)
	rel NoWriteToField(node : Str)
	
	// Control flow
	rel CFGEdge(src : Str, trg : Str) //
	rel ICFGNode(node : Str) //
	
	AssignmentSides(node : Str, left : Str, right : Str) :-
		ExpressionStatement(node),
		ExpressionInExpressionStatement(node, exp),
		BaseAssignmentExpression(exp),
		LValueInBaseAssignmentExpression(exp, left),
		RValueInBaseAssignmentExpression(exp, right).
		
	VariableInExpression(exp : Str, var : Str) :-
		VariableReference(exp),
		VariableDeclarationInVariableReference(exp, var).
		
	FieldAccessInExpression(container : Str, exp : Str, field : Str) :-
		DotExpression(container),
		OperandInDotExpression(container, exp),
		OperationInDotExpression(container, op),
		FieldReferenceOperation(op),
		FieldDeclarationInFieldReferenceOperation(op, field),
		FieldDeclaration(field).

	Ancestor(descendant : Str, ancestor : Str) :-
		Parent(descendant, ancestor),
		IAncestorRelevantNode(ancestor).
		
	Ancestor(descendant : Str, ancestor : Str) :-
		Parent(descendant, parent),
		Ancestor(parent, ancestor),
		IAncestorRelevantNode(ancestor).

	def eq(l: Str, r: Str): Bool = l == r		
	def neq(l: Str, r: Str): Bool = l != r
	
}
