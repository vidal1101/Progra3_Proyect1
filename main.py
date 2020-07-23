#importaciones basicas  
from flask import Flask , request  , render_template, redirect
from flask.helpers import url_for

#objeto de la clase flask para las rutas 
objflask = Flask(__name__,template_folder="Vista")


@objflask.route('/login', methods=['GET', 'POST'])
def Login():
    return render_template('login.html')

@objflask.route('/menu', methods=['GET', 'POST'])
def menu():
    return render_template('menu.html')

@objflask.route('/habitat', methods=['GET', 'POST'])
def habitat():
    return render_template('habitat.html')

@objflask.route('/especies', methods=['GET', 'POST'])
def especies():
    return render_template('/especies.html')

@objflask.route('/historial', methods=['GET', 'POST'])
def historial():
    return render_template('/historial.html')

@objflask.route('/usuarios', methods=['GET', 'POST'])
def usuario():
    return render_template('/usuarios.html')

@objflask.route('/agregarUsuario', methods=['GET', 'POST'])
def agregarUsuario():
    return render_template('/agregarUsuario.html')

@objflask.route('/agregarHabitat', methods=['GET', 'POST'])
def agregarHabitat():
    return render_template('/agregarHabitat.html')

@objflask.route('/animales', methods=['GET', 'POST'])
def animales():
    return render_template('/animales.html')

@objflask.route('/agregarAnimales', methods=['GET', 'POST'])
def agregarAnimal():
    return render_template('/agregarAnimales.html')

    
@objflask.route('/guardado',methods=['POST'])
def guardado():
    #verifica que se esta obteniendo los datos del metodo post
    if(request.method == 'POST'):
        NomHabitat = request.form['txtnombreH']
        Clima = request.form['txtClima']
        Vegetacion = request.form['txtVege']
        EstadoHabitat = request.form['txtEstado']

        

        myControlador.enviar(NomHabitat, Clima, Vegetacion, EstadoHabitat)

    return redirect(url_for('habitat'))

#-------------------- finalizo las rutas de mi osquetador  -----------------------------


# de puede conf. el puerto de salida , true&false para mantener el servidor abierto mientras se efctua codigo en python
# y el use_reloader mantiene y ejecuta la pagina 
if __name__ == "__main__":
    objflask.run(port=80, debug=True, use_reloader=True)

