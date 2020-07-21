#acceso
from modelo import ModeloHa
myControlador = ModeloHa



#Envia a guardar los datos
def enviar(NomHabitat, Clima, Vegetacion, EstadoHabitat):
    myControlador.agrega(NomHabitat, Clima, Vegetacion, EstadoHabitat)