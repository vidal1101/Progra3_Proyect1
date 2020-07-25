import pymysql




#import pymysql.connector
#from pymysql import errorcode

class Mysql(object):
    __instance = None
    __host = None
    __user = None
    __password = None
    __database = None

    __session = None
    __connection = None
   

    def __new__(cls, *args, **kwargs):
        if not cls.__instance:
            cls.__instance = super(Mysql, cls).__new__(cls, *args, **kwargs)
        return cls.__instance

    def __init__(self, host='localhost', user='root', password='Runo1101', database='proyectozoologico'):
        self.__host = host
        self.__user = user
        self.__password = password
        self.__database = database
      

    #Open connection with database
    def _open(self):
        try:
            cnx = pymysql.connect(host=self.__host, user=self.__user, password=self.__password,
                                          database=self.__database)
            self.__connection = cnx
            self.__session = cnx.cursor()
            print('Database conectada con exito')
        except pymysql.Error as err:
           
            print('Something is wrong with your user name or password') #
            
            print('Database does not exists')# errorcode.ER_BAD_DB_ERROR:
           
            print(err)

    def _close(self):
        self.__session.close()
        self.__connection.close()

    def insert(self, table, *args, **kwargs):
        values = None
        query = "INSERT INTO %s " % table
        if kwargs:
            keys = kwargs.keys()
            values = kwargs.values()
            query += "(" + ",".join(["`%s`"]*len(keys)) % tuple(keys) + ") VALUES(" + ",".join(["%s"]*len(values)) + ")"
        elif args:
            values = args
            query += " VALUES(" + ",".join(["%s"]*len(values)) + ")"
        self._open()
        self.__session.execute(query, values)
        self.__connection.commit()
        self._close()
        return self.__session.lastrowid

    def select(self, table, where=None, *args):
        result = None
        query = "SELECT "
        keys = args
        l = len(keys) - 1
        for i, key in enumerate(keys):
            query += "`"+key+"`"
            if i < l:
                query += ","
        query += " FROM %s" % table
        if where:
            query += " WHERE %" % where
        self._open()
        self.__session.execute(query)
        self.__connection.commit()
        for result in self.__session.stored_results():
            result = result.fetchall()
        self._close()
        return result

    def update(self, table, index, **kwargs):
        query = "UPDATE %s SET" % table
        keys = kwargs.keys()
        values = kwargs.values()
        l = len(keys) - 1
        for i, key in enumerate(keys):
            query += "`"+key+"`=%s"
            if i < l:
                query += ","
        query += " WHERE index=%d" % index
        self._open()
        self.__session.execute(query, values)
        self.__connection.commit()
        self._close()

    def delete(self, table, index):
        query = "DELETE FROM %s WHERE uuid=%d" % (table, index)
        self._open()
        self.__session.execute(query)
        self.__connection.commit()
        self._close()

    def call_store_procedure_return(self, name, args):
        self._open()
        cursor = self.__session
        if args != [] :
            print('args : '+str(args)+'')
            cursor.callproc(name, args)
            self.__connection.close()
            return cursor.fetchall()
        else:
            cursor.callproc(name)
        self.__connection.close()
        return cursor.fetchall()

    def Execute_Procedure(self, name, args):
        try:
            self._open()
            self.__session.callproc(name, args)
            self.__connection.commit()
            self._close()
            print('consulta completada')
            return 'Ejecutado'
        except Exception  :
            print('error al insertar datos ,ese seria el error ')
            return 'Error'

    def call_store_procedureDates(self, name, *args):
        result_sp = None
        self._open()
        self.__session.callproc(name, args)
        self.__connection.commit()
        for result in self.__session.stored_results():
            result_sp = result.fetchall()
        self._close()
        return result_sp
cls = Mysql()
cls._open()

