#acceso
from modelo import ModeloHa
myControlador = ModeloHa



#Envia a guardar los datos
def enviar(NomHabitat, Clima, Vegetacion, EstadoHabitat):
    myControlador.agrega(NomHabitat, Clima, Vegetacion, EstadoHabitat)
    
# muestro todo los habitats
def showhabitats(): 
    res = myControlador.mostrarHabitats() 
    return res  

#se cmabia el estado de habitats
def cambioestado(id):
    myControlador.cambiarEstado(id)
    
#obtengo el habitats a editar 
def obtenerhabitats(id): 
    rs = myControlador.gethabitats(id)   
    return rs
    
def editar(id,NomHabitat, Clima, Vegetacion, EstadoHabitat):  
    myControlador.editarHabi(id, NomHabitat, Clima, Vegetacion, EstadoHabitat)  
    
def mostrarhabbitatsEspecies(idhabi):  
    rs = myControlador.verHabitatsEspecies(idhabi)  
    return rs 
