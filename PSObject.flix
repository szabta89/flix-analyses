namespace SUPT {

	enum PSObject {
		case PSTop,
		case PSObj(Set[Str]),
		case PSBot
	}
	
	def ps_leq(l: PSObject, r: PSObject): Bool = match (l, r) with {
		case (PSObject.PSBot, _) => true
		case (_, PSObject.PSTop) => true
		case (PSObject.PSObj(v1), PSObject.PSObj(v2)) => Set.isSubsetOf(v1, v2)
		case _ => false
	}
	
	def ps_lub(l: PSObject, r: PSObject): PSObject = match (l, r) with {
		case (PSObject.PSBot, _) => r
		case (_, PSObject.PSBot) => l
		case (PSObject.PSObj(v1), PSObject.PSObj(v2)) => PSObject.PSObj(Set.union(v1, v2))
		case _ => PSObject.PSTop
	}
	
	def ps_glb(l: PSObject, r: PSObject): PSObject = match (l, r) with {
		case (PSObject.PSTop, _) => r
		case (_, PSObject.PSTop) => l
		case (PSObject.PSObj(v1), PSObject.PSObj(v2)) => PSObject.PSObj(Set.intersection(v1, v2))
		case _ => PSObject.PSBot
	}
	
	let PSObject<> = (PSObject.PSBot, PSObject.PSTop, ps_leq, ps_lub, ps_glb)
	
	def createPSObjectSingleton(exp: Str): PSObject = PSObject.PSObj(Set.singleton(exp))

}
