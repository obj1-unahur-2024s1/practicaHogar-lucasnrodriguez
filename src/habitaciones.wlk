import personas.*
import casasYFamilias.*

class Habitacion {
	const property ocupantes = #{}
	method nivelDeConfortQueAporta(persona) = 10
	method estaVacia() = ocupantes.isEmpty() //Indica si la habitación está vacía
	method puedeEntrar(unaPersona)
}

class UsoGeneral inherits Habitacion {
	override method puedeEntrar(unaPersona) = true
}

class Dormitorio inherits Habitacion {
	var property cantPersonas
	override method nivelDeConfortQueAporta(persona){
		return super(persona) + if(persona.duermeEn(self)) 10 / cantPersonas else 0
	}
	override method puedeEntrar(unaPersona) {
		return persona.duermeEn(self) or ocupantes.all({p => p.todosOcupantesDuermen() or self.estaVacia()})
	}
	method todosOcupantesDuermen() = ocupantes.count({p => p.duermeEn(self)}) == cantPersonas
}

class Banio inherits Habitacion {
	override method nivelDeConfortQueAporta(persona){
		return super(persona) + if(persona.esMenorOIgualDe(4)) 2 else 4
	}
	method hayUnNinio() = ocupantes.any({p => p.esMenorOIgualDe(4)})
	override method puedeEntrar(unaPersona) = self.estaVacia() or self.hayUnNinio()
}

class Cocina inherits Habitacion {
	const property metrosCuadrados
	override method nivelDeConfortQueAporta(persona){
		return super(persona) + if (persona.tieneHabilidadesDeCocina()) metrosCuadrados * configValor.porcentajeConfortCocina() else 0
	}
	override method puedeEntrar(persona) {
		return self.estaVacia() or (not self.existeYaCocinero() and persona.tieneHabilidadesDeCocina())
	}
	method existeYaCocinero() = ocupantes.any({p => p.tieneHabilidadesDeCocina()}) //punto de puede entrar sin resolver
}

object configValor {
	var property porcentajeConfortCocina = 0.1
}

