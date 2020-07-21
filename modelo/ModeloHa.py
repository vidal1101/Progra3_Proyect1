#importar la clase conexion de la base de datos
from modelo import Database
#dar acceso a la clase
conexion = Database.Mysql(None)

#Agrega un registro
def agrega(NomHabitat, Clima, Vegetacion, EstadoHabitat):
    result = conexion.Execute_Procedure("stp_saveHabitats",[NomHabitat, Clima, Vegetacion, EstadoHabitat])