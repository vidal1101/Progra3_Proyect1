from modelo import ModeloEspe

mymodelo  = ModeloEspe

# a mostrar todas las especies
def showEspecies():
    res = mymodelo.showEspeciesTotales()
    print(res)
    return res