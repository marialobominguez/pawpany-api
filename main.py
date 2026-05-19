from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session

from database import get_db
from models import Usuario, Mascota, PerfilCuidador, Contrato, Mensaje, Resena
from schemas import UsuarioCreate, UsuarioOut

# creo la aplicación
app = FastAPI(
    title="PawPany API",
    description="La API de mi TFG para conectar la BBDD con la app móvil.",
    version="1.0.0"
)

# La ruta de prueba
@app.get("/")
def inicio():
    return {"mensaje": "Holiii^-^ La API de PawPany funciona bien :D."}

# CRUD - READ/GET

# usuarios
@app.get("/usuarios")
def obtener_usuarios(db: Session = Depends(get_db)):
    lista_usuarios = db.query(Usuario).all()
    return lista_usuarios

# mascotas
@app.get("/mascotas")
def obtener_mascotas(db: Session = Depends(get_db)):
    return db.query(Mascota).all()


# cuidadores
@app.get("/perfiles-cuidadores")
def obtener_cuidadores(db: Session = Depends(get_db)):
    return db.query(PerfilCuidador).all()


# contratos
@app.get("/contratos")
def obtener_contratos(db: Session = Depends(get_db)):
    return db.query(Contrato).all()


# mensajes
@app.get("/mensajes")
def obtener_mensajes(db: Session = Depends(get_db)):
    return db.query(Mensaje).all()


# reseñas
@app.get("/resenas")
def obtener_resenas(db: Session = Depends(get_db)):
    return db.query(Resena).all()

# FIN CRUD - LEER


# CRUD - CREATE/INSERT

@app.post("/usuarios", response_model=UsuarioOut)
def crear_usuario(usuario: UsuarioCreate, db: Session = Depends(get_db)):
    # 1. creo el usuario con los datos de schemas.py
    nuevo_usuario = Usuario(
        username=usuario.username,
        email=usuario.email,
        password_hash=usuario.password_hash,
        nombre=usuario.nombre,
        apellido1=usuario.apellido1,
        apellido2=usuario.apellido2,
        ubicacion=usuario.ubicacion,
        rol=usuario.rol
    )
    
    # 2. lo guardo en la bbdd
    db.add(nuevo_usuario)
    db.commit() # confirmo cambios
    db.refresh(nuevo_usuario) # recargar para obtener el ID que le asigne MySQL
    
    return nuevo_usuario

