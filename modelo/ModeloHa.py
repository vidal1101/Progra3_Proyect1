#importar la clase conexion de la base de datos
from modelo import Database
#dar acceso a la clase
conexion = Database.Mysql(None)

#Agrega un registro
def agrega(NomHabitat, Clima, Vegetacion, EstadoHabitat):
    conexion.Execute_Procedure("stp_saveHabitats",[NomHabitat, Clima, Vegetacion, EstadoHabitat])
    
# muestra todos los registros de habitats    
def  mostrarHabitats(): 
    habit = 'habitats'
    rs  = conexion.call_store_procedure_return("stp_mostrarTablas", [habit])  
    return rs

#se cambia el estado..
def cambiarEstado(id):
    conexion.Execute_Procedure("stp_cambiarEstaHabitats", [id,True])
    
#obtengo un habitats
def gethabitats(idhabi):    
    result = conexion.call_store_procedure_return("stp_obtenerHabitats",[idhabi])
    return result

##edita y guarda los cambios en la  base de datos 
def editarHabi(id,NomHabitat, Clima, Vegetacion, EstadoHabitat):
    conexion.Execute_Procedure("stp_modificarHabitats", [id,NomHabitat, Clima, Vegetacion, EstadoHabitat])
    
#mustra los especies relacionado a ese habitats     
def verHabitatsEspecies(idhabi): 
    result = conexion.call_store_procedure_return("stp_verEspecies",[idhabi] )   
    return result
    