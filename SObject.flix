namespace SUPT {

	enum SObject {
		case STop,
		case SObj(Str),
		case SBot
	}
	                        
	def s_leq(l: SObject, r: SObject): Bool = match (l, r) with {
		case (SObject.SBot, _) => true
		case (_, SObject.STop) => true
		case (SObject.SObj(v1), SObject.SObj(v2)) => v1 == v2
		case _ => false
	}

	def s_lub(l: SObject, r: SObject): SObject = match (l, r) with {
		case (SObject.SBot, _) => r
		case (_, SObject.SBot) => l
		case (SObject.SObj(v1), SObject.SObj(v2)) => if (v1 == v2) l else SObject.STop
		case _ => SObject.STop
	}
	
	def s_glb(l: SObject, r: SObject): SObject = match (l, r) with {
		case (SObject.STop, _) => r
		case (_, SObject.STop) => l
		case (SObject.SObj(v1), SObject.SObj(v2)) => if (v1 == v2) l else SObject.SBot
		case _ => SObject.SBot
	}
	
	let SObject<> = (SObject.SBot, SObject.STop, s_leq, s_lub, s_glb)

	def createSObjectTop: SObject = SObject.STop

	def createSObjectSingleton(exp: Str): SObject = SObject.SObj(exp)

	def isNotTop(e: SObject): Bool = match (e) with {
		case (SObject.STop) => false
		case _ => true
	}
	
	def isTop(e: SObject): Bool = !isNotTop(e)
	
	def getExpression(e: SObject): Str = match (e) with {
		case (SObject.SObj(v)) => v
		case _ => ""
	}
}
