

//Esta clase no debe existir, 
//está para que el test compile al inicio del examen
//al finalizar el examen hay que borrar esta clase
//class XXX {
//	var property talle= null
//	var property desgaste= null
//	var property min= null
//	var property max= null
//	var property prendas= null
//	var property ninios= null
//	var property edad= null
//	var property juguete = null
//	var property abrigo = null
//}

class Prenda{
	const property talle=null;
	var abrigo=1;
	var property desgaste=0;
	
	method puntosDesgaste(){
		return if(desgaste>=3) 3 else desgaste
	}
	
	method puntosTalle(ninio){
		return if (ninio.talle()==self.talle()) 8 else 0 
	}
	
	method comodidad(ninio){
		return self.puntosTalle(ninio)-self.puntosDesgaste()
	}
	
	method nivelAbrigo(){
		return abrigo
	}
	

}

class PrendaDePares inherits Prenda{

	var property izquierdo;
	var property derecho;
	
	method desgastePromedio(){
		return (izquierdo.desgaste()+derecho.desgaste())/2
	}
	
	method puntosEdad(ninio){
		return if(ninio.edad()<4) 1 else 0
	}
	
	override method puntosDesgaste(){
		return if(self.desgastePromedio()>=3) 3 else self.desgastePromedio()
	}

	override method comodidad(ninio){
		return super(ninio)-self.puntosEdad(ninio)
	}
	
	method mismoTalle(prendaPares){
		return prendaPares.talle()==self.talle()
	}
	
	method intercambiar(prendaPares){
		if(self.mismoTalle(prendaPares)){
			var aux=prendaPares.derecho()
			prendaPares.derecho(self.derecho())
			self.derecho(aux)
		}else{
			self.error("no son del mismo talle")
		}
	}
	
	override method nivelAbrigo(){
		return izquierdo.nivelAbrigo()+derecho.nivelAbrigo()
	}
	
	method desgastar(){
		izquierdo.desgaste(izquierdo.desgaste()+0.8)
		derecho.desgaste(derecho.desgaste()+1.2)
	}
}

class PrendaLiviana inherits Prenda{
	override method comodidad(ninio){
		return super(ninio)+2
	}
	override method nivelAbrigo(){
		 return abrigo
	}
	
	method nivelAbrigo(_abrigo){
		 abrigo=_abrigo
	}
	
	method desgastar(){
		desgaste++
	}
	
}

class PrendaPesada inherits Prenda{
	method desgastar(){
		desgaste++
	}

}

class Ninio{
	var property talle;
	var property edad;
	var prendas=#{}
	
		
	method cantidadPrendas(){
		return prendas.size()>=5
	}
	
	method conAbrigoSuficiente(){
		return prendas.any({prenda=>prenda.nivelAbrigo()>=3})
	}
	
	method prendasDeCalidad(){
		return prendas.all({prenda=>prenda.nivelAbrigo()+prenda.comodidad(self)>=8})
	}
	
	method puedeSalir(){
		return self.cantidadPrendas() and self.conAbrigoSuficiente() and self.prendasDeCalidad()
	}
	
	method infaltable(){
		return prendas.max({prenda=>prenda.nivelAbrigo()+prenda.comodidad(self)})
	}
	
	method esMenorDe4(){
		return edad<4
	}
	
	method desgastar(){
		prendas.forEach({prenda=>prenda.desgastar()})
	}
	
}

class NinioProblematico inherits Ninio{
	var juguete;
	
	override method cantidadPrendas(){
		return prendas.size()>=4
	}
	
	method jugueteApto(){
		return edad>juguete.min() and edad<juguete.max()
	}
	
	override method puedeSalir(){
		return self.jugueteApto() and super()
	}
}

class Familia{
	var ninios=#{}

	method puedePasear(){
		return ninios.all({ninio=>ninio.puedeSalir()})
	}
	
	method infaltables(){
		return ninios.map({ninio=>ninio.infaltable()}).asSet()
	}
	
	method chiquitos(){
		return ninios.filter({ninio=>ninio.esMenorDe4()})
	}
	
	method pasear(){
		if(self.puedePasear()){
			ninios.forEach({ninio=>ninio.desgastar()})
		}else{
			self.error("Esta familia no puede pasear")
		}
	}
}

class Juguete{
	var property min
	var property max
}


//Objetos usados para los talles
object xs {
}

object s {
}
object m {
	
}
object l{
	
}
object xl{
	
}