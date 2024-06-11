class Persona {
	var property dormitorio
	var edad
	var property tieneHabilidadesDeCocina = false
	method duermeEn(unDormitorio) = dormitorio == unDormitorio
	method cumplirAnio() = edad + 1
	method edad() = edad
	method esMenorOIgualDe(unaEdad) = edad <= unaEdad
	
	
}
