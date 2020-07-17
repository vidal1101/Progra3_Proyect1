#importaciones basicas  
from flask import Flask , request  , render_template, redirect
from flask.helpers import url_for
#objeto de la clase flask para las rutas 
objflask = Flask(__name__,template_folder="vistas")


@objflask.route('/', methods=['GET', 'POST'])
def Login():
    return 'hello'









#-------------------- finalizo las rutas de mi osquetador  -----------------------------


# de puede conf. el puerto de salida , true&false para mantener el servidor abierto mientras se efctua codigo en python
# y el use_reloader mantiene y ejecuta la pagina 
if __name__ == "__main__":
    objflask.run(port=80, debug=True, use_reloader=True)

