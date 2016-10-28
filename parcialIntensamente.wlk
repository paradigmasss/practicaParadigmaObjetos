object riley{
	var recuerdosDelDia=[]
	var nivelFelicidad=1000
	var emocionDominante
	var pensamientosCentrales=#{}
	var memoriaALargoPlazo=[]
	method pensamientosCentrales()=pensamientosCentrales
	method emocionDominante(emocion){emocionDominante=emocion}
	method emocionDominante()= emocionDominante
	method realizarRecuerdo(recuerdo){recuerdosDelDia.add(recuerdo)}
	method asentarRecuerdo(recuerdo){
		if(recuerdo.emocionDominante().esFeliz()&& (nivelFelicidad> 500))
	{pensamientosCentrales.add(recuerdo)}
	if(recuerdo.emocionDominante().esTriste())
	{pensamientosCentrales.add(recuerdo)
	nivelFelicidad.max(1,nivelFelicidad-= nivelFelicidad*10/100)
	}}
	method recuerdosRecientes()= recuerdosDelDia.take(5)
	method aptosParaMemoriaALargoPlazo()= recuerdosDelDia.filter({recuerdo=>(not(recuerdo.central())&&not(emocionDominante.negarRecuerdo(recuerdo)))})
	method mandarRecuerdosAMLargoPlazo()= self.aptosParaMemorizar()
	}

	


class Recuerdo{
	var descripcion=""
	var fecha
	constructor(_descripcion,_fecha)
	{descripcion=_descripcion
	 fecha=_fecha}
	 method fecha()=fecha
	 method felicidadMinimaParaSentimientoCentral()=500
	 method descripcion()=descripcion	 
	 method emocionDominante()= riley.emocionDominante()
	 method central()= riley.pensamientosCentrales().contains(self)
	 
}
class Sentimiento{
	method esFeliz()= false
	method esTriste()=false
	method negarRecuerdo(recuerdo)=false
}

object feliz inherits Sentimiento{
	override method esFeliz()=true
	override method negarRecuerdo(recuerdo)=not(recuerdo.esFeliz())
	
	}
	

object triste inherits Sentimiento{ 
	override method esTriste()=true
	override method negarRecuerdo(recuerdo)=not(recuerdo.esTriste())
}
object desagradable inherits Sentimiento{
	
}
object furia inherits Sentimiento{
	
}
object temor inherits Sentimiento{
	
}
