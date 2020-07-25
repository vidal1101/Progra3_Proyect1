#importar la clase conexion de la base de datos
from modelo import Database
#dar acceso a la clase
conexion = Database.Mysql(None)


#se muestra todas las especies
def showEspeciesTotales():
    esp ='especies'
    rs  = conexion.call_store_procedure_return("stp_mostrarTablas", [esp])
    return rs

