#importaciones basicas  
from flask import Flask , request  , render_template, redirect
from flask.helpers import url_for


#importaciones de controladores y modelos y sus objetos glabales 
from controlador import ControladorHa , ControladorEspec

#objetos de los controladores 
conthabi = ControladorHa
contespec = ControladorEspec

#objeto de la clase flask para las rutas 
objflask = Flask(__name__,template_folder="Vista")

#iniccio del programa .. primer ruta
@objflask.route('/login', methods=['GET', 'POST'])
def Login():
    return render_template('login.html')


# menu principal 
@objflask.route('/menu', methods=['GET', 'POST'])
def menu():
    return render_template('menu.html')



#---------------------------------------------------------- HABITATS ------------------------------------------------------

#se muestra todos los habitats 
@objflask.route('/habitat', methods=['GET', 'POST'])
def habitat():
    datos  = conthabi.showhabitats()
    return render_template('habitat.html',datos=datos)

# a inserta un habitats
@objflask.route('/agregarHabitat', methods=['GET', 'POST'])
def agregarHabitat():
    btn='nuevo'
    datos =['']
    return render_template('/agregarHabitat.html',btn=btn,datos=datos)


# se guarda para insertar o editar 
@objflask.route('/guardadoHabitats',methods=['POST','GET'])
def guardado():
    #verifica que se esta obteniendo los datos del metodo post
    if(request.method == 'POST'):
        try:
         
            NomHabitat = request.form['txtnombreH']
            Clima = request.form['txtClima']
            Vegetacion = request.form['txtVege']
            EstadoHabitat = request.form['txtEstado']
            
            btnvalor = request.form['btnHabitat']
            print('btn : '+str(btnvalor)+''+str(NomHabitat))
         
            #en el primero gurado 
            if(btnvalor=='nuevo'):
                conthabi.enviar(NomHabitat, Clima, Vegetacion, EstadoHabitat)
            elif(btnvalor=='editar'): 
                idhab = request.form['idHabitats']
                conthabi.editar(idhab, NomHabitat, Clima, Vegetacion, EstadoHabitat) 
                
        except Exception : 
            #falta perfecionar esa pagina de errores 
            error  ='Solicitud imcopleta, Faltan Datos '
            ruta='/agregarHabitat'
            btn='Volver al formulario '
            return render_template('Errores.html',erro=error,rut=ruta,btn=btn)   
             
    return redirect(url_for('habitat'))  
    

#obtengo los datos a mostrar en el formulario de editado
@objflask.route('/getHabitats', methods=['GET', 'POST'])
def get_cliente(): 
    btn = 'editar'
    idhabitats =request.args.get('idhabi')
    datos = conthabi.obtenerhabitats(idhabitats)
    return render_template('/agregarHabitat.html', datos=datos,btn=btn)     
    
    
    
# modico el estado del habitats
@objflask.route('/cambiarestadoHabitats/<id>', methods=['GET', 'POST'])
def cambioestadohabi(id):   
    conthabi.cambioestado(id)
    return redirect(url_for('habitat'))          
        


#especies segun el habitats de su zona
@objflask.route('/especiesHabitas/<idhabi>', methods=['GET', 'POST'])
def verhabiEspecies(idhabi):
    datos = conthabi.mostrarhabbitatsEspecies(idhabi)
    return render_template('/especies.html', datos=datos)

#---------------------------------------------------------- ESPECIES ------------------------------------------------------


#ruta especial de espescie
@objflask.route('/especies', methods=['GET', 'POST'])
def especies():
    datos = contespec.showEspecies()
    return render_template('/especies.html', datos=datos)











#---------------------------------------------------------- HISTORIAL   ------------------------------------------------------

@objflask.route('/historial', methods=['GET', 'POST'])
def historial():
    return render_template('/historial.html')

@objflask.route('/usuarios', methods=['GET', 'POST'])
def usuario():
    return render_template('/usuarios.html')

@objflask.route('/agregarUsuario', methods=['GET', 'POST'])
def agregarUsuario():
    return render_template('/agregarUsuario.html')

#----------------------------------------------- animmales ---------------------------------------------------------

#ruta de lo animales 
@objflask.route('/animales', methods=['GET', 'POST'])
def animales():
    return render_template('/animales.html')



@objflask.route('/agregarAnimales', methods=['GET', 'POST'])
def agregarAnimal():
    return render_template('/agregarAnimales.html')






#-------------------- finalizo las rutas de mi osquetador  -----------------------------


# de puede conf. el puerto de salida , true&false para mantener el servidor abierto mientras se efctua codigo en python
# y el use_reloader mantiene y ejecuta la pagina 
if __name__ == "__main__":
    objflask.run(port=80, debug=True, use_reloader=True)

