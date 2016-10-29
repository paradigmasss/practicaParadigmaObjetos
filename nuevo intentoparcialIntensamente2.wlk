object riley{
	var pensamiento
	var recuerdosDelDia=#{}
	var pensamientosCentrales=#{}
	var emocionesDominantes=#{}
	var nivelDeFelicidad=1000
	var memoriALargoPlazo=[]
	method agregarPensamientosCentrales(recuerdo){pensamientosCentrales.add(recuerdo)
			}
	method emocionesDominantes(emocion)=emocionesDominantes.add(emocion)
	method emocionesDominantes()=emocionesDominantes
	method crearRecuerdo(recuerdo){
		recuerdosDelDia.add(recuerdo)
	}
	method niega(recuerdo)=emocionesDominantes.any({emocion=>emocion.negar(recuerdo)})
	method recuerdoCentral(recuerdo)= pensamientosCentrales.contains(recuerdo)
	
	method profundizarRecuerdo(recuerdo){
		if(not self.niega(recuerdo) && not self.recuerdoCentral(recuerdo) ){
			memoriALargoPlazo.add(recuerdo)
			recuerdosDelDia.remove(recuerdo)
		}
	}
	method recuerdoRepetidoPCyMLP()=memoriALargoPlazo.intersection(pensamientosCentrales)!=[]
	method mismoSentimientoTodosLosRecuerdos()= recuerdosDelDia.all({recuerdo=>recuerdo.emocionesDominantes()==recuerdosDelDia.head().emocionesDominantes()})
	method desequilibrioHormonal(){
		nivelDeFelicidad-=nivelDeFelicidad*0.15
		pensamientosCentrales.remove(pensamientosCentrales.last())
		pensamientosCentrales.remove(pensamientosCentrales.last())
		pensamientosCentrales.remove(pensamientosCentrales.last())		
	}
	method controlHormonal(){
		if(self.mismoSentimientoTodosLosRecuerdos()||self.recuerdoRepetidoPCyMLP()){
			self.desequilibrioHormonal()
		}
	}
	method liberacionDeRecuerdosDelDia(){
		recuerdosDelDia.clean()
	}
	method restauracionCognitiva(){
		nivelDeFelicidad.min(nivelDeFelicidad+100,1000)
	}
	method profundizar(){
		recuerdosDelDia.map({recuerdo=>self.profundizarRecuerdo(recuerdo)})
	}
	method asentar(){
		recuerdosDelDia.map({recuerdo=>self.asentarUn(recuerdo)})
	}
	method asentarUn(recuerdo){
		if(recuerdo.esAlegre() && nivelDeFelicidad>500){
			self.agregarPensamientosCentrales(recuerdo)
		}
		if(recuerdo.esTriste())
		{ self.agregarPensamientosCentrales(recuerdo)
		  nivelDeFelicidad.max(1,nivelDeFelicidad-nivelDeFelicidad*0.01)}
		  }
	
	method aparicionesEnMALPDe(recuerd)=memoriALargoPlazo.filter({recuerdo=>recuerdo==recuerd})
	method cantidadDeRepeticionesEnMALP(recuerd)=self.aparicionesEnMALPDe(recuerd).size()
	method recuerdoRepetido(recuerd){
		if(not memoriALargoPlazo.contains(recuerd)){return false}
		if(self.aparicionesEnMALPDe(recuerd).size()>1){return true}
		return false
	}  
	method dormir(){
		self.controlHormonal()
		self.asentar()
		self.liberacionDeRecuerdosDelDia()
		self.restauracionCognitiva()
		self.profundizar()
	}
	method pensar(recuerdo){
		pensamiento=recuerdo
	}
	method deyavu(recuerdo)=self.recuerdoRepetido(recuerdo)&& pensamiento==recuerdo
	

}
class Recuerdo{
	var descripcion=  ""
	var fecha
	constructor(_descripcion,_fecha)
{	descripcion=_descripcion
	fecha=_fecha
}
	method emocionesDominates()=riley.emocionesDominantes()
	method esAlegre()=riley.emocionesDominantes().any({emocion=>emocion.esAlegre()})
	method esTriste()=riley.emocionesDominantes().any({emocion=>emocion.esTriste()})
	method esDificilDeExplicar()= descripcion.word().size()>10
	
}


class Emociones{
	method esAlegre()=false
	method esTriste()=false
	method negar(recuerdo)= false
}
object alegria inherits Emociones{
	override method esAlegre()=true
	override method negar(recuerdo)= not recuerdo.esAlegre()
}
object tristeza inherits Emociones{
	override method esTriste()=true
	override method negar(recuerdo)=  recuerdo.esAlegre()
}
object disgusto inherits Emociones{
	
}
object furia inherits Emociones{
	
}
object temor inherits Emociones{
	
}