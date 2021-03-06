namespace SUPT {

	enum Object {
		case Top,
		case SObj(SObject),
		case PSObj(PSObject),
		case Bot
	}
	
	def o_eq(l: Object, r: Object): Bool = match (l, r) with {
		case (Object.Bot, Object.Bot) => true
		case (Object.Top, Object.Top) => true
		case (Object.SObj(v1), Object.SObj(v2)) => s_eq(v1, v2)
		case (Object.PSObj(v1), Object.PSObj(v2)) => ps_eq(v1, v2)
		case _ => false
	}
	
	def o_leq(l: Object, r: Object): Bool = match (l, r) with {
		case (Object.Bot, _) => true
		case (_, Object.Top) => true
		case (Object.SObj(v1), Object.SObj(v2)) => s_leq(v1, v2)
		case (Object.PSObj(v1), Object.PSObj(v2)) => ps_leq(v1, v2)
		case _ => false
	}
	
	def o_lub(l: Object, r: Object): Object = match (l, r) with {
		case (Object.Bot, _) => r
		case (_, Object.Bot) => l
		case (Object.SObj(v1), Object.SObj(v2)) => Object.SObj(s_lub(v1, v2))		
		case (Object.PSObj(v1), Object.PSObj(v2)) => Object.PSObj(ps_lub(v1, v2))
		case _ => Object.Top
	}
	
	def o_glb(l: Object, r: Object): Object = match (l, r) with {
		case (Object.Top, _) => r
		case (_, Object.Top) => l
		case (Object.SObj(v1), Object.SObj(v2)) => Object.SObj(s_glb(v1, v2))
		case (Object.PSObj(v1), Object.PSObj(v2)) => Object.PSObj(ps_glb(v1, v2))
		case _ => Object.Bot
	}
	
	let Object<> = (Object.Bot, Object.Top, o_eq, o_leq, o_lub, o_glb)

	def createWrappedSObjectSingleton(exp: SObject): Object = Object.SObj(exp)
	
	def createWrappedPSObjectSingleton(exp: Str): Object = Object.PSObj(createPSObjectSingleton(exp))

}
