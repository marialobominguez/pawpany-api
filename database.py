from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

USUARIO = "root"
CONTRASENA = "1234"  
SERVIDOR = "127.0.0.1"
PUERTO = "3307"
BASE_DE_DATOS = "pawpany_db"      

URL_CONEXION = f"mysql+pymysql://{USUARIO}:{CONTRASENA}@{SERVIDOR}:{PUERTO}/{BASE_DE_DATOS}"

# el motor de la bbdd
engine = create_engine(URL_CONEXION)

# Creo las sesiones: cada vez que alguien use la app, se abre una sesión y luego se cierra
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# base para crear los modelos (tablas)
Base = declarative_base()

# función para conseguir conexión
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()