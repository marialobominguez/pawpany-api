from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session

from database import get_db
from models import Usuario, Mascota, PerfilCuidador, Contrato, Mensaje, Resena
from schemas import (
    UsuarioCreate, UsuarioOut, 
    MascotaCreate, MascotaOut,
    PerfilCuidadorCreate, PerfilCuidadorOut,
    ContratoCreate, ContratoOut,
    MensajeCreate, MensajeOut,
    ResenaCreate, ResenaOut
)

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

# otra forma de hacerlo: usando desempaquetado de diccionarios (**)
# los ** extraen automáticamente todas las variables del Schema y las encajan en el modelo
@app.post("/mascotas", response_model=MascotaOut)
def crear_mascota(mascota: MascotaCreate, db: Session = Depends(get_db)):
    nueva_mascota = Mascota(**mascota.model_dump())
    db.add(nueva_mascota)
    db.commit()
    db.refresh(nueva_mascota)
    return nueva_mascota

@app.post("/perfiles-cuidadores", response_model=PerfilCuidadorOut)
def crear_perfil_cuidador(perfil: PerfilCuidadorCreate, db: Session = Depends(get_db)):
    nuevo_perfil = PerfilCuidador(**perfil.model_dump())
    db.add(nuevo_perfil)
    db.commit()
    db.refresh(nuevo_perfil)
    return nuevo_perfil

@app.post("/contratos", response_model=ContratoOut)
def crear_contrato(contrato: ContratoCreate, db: Session = Depends(get_db)):
    nuevo_contrato = Contrato(**contrato.model_dump())
    db.add(nuevo_contrato)
    db.commit()
    db.refresh(nuevo_contrato)
    return nuevo_contrato

@app.post("/mensajes", response_model=MensajeOut)
def crear_mensaje(mensaje: MensajeCreate, db: Session = Depends(get_db)):
    nuevo_mensaje = Mensaje(**mensaje.model_dump())
    db.add(nuevo_mensaje)
    db.commit()
    db.refresh(nuevo_mensaje)
    return nuevo_mensaje

@app.post("/resenas", response_model=ResenaOut)
def crear_resena(resena: ResenaCreate, db: Session = Depends(get_db)):
    nueva_resena = Resena(**resena.model_dump())
    db.add(nueva_resena)
    db.commit()
    db.refresh(nueva_resena)
    return nueva_resena

# FIN CRUD - INSERT

# CRUD - DELETE

# usuario general
@app.delete("/usuarios/{id}")
def borrar_usuario(id: int, db: Session = Depends(get_db)):
    usuario = db.query(Usuario).filter(Usuario.id == id).first()
    if not usuario:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")
    
    db.delete(usuario)
    db.commit()
    return {"mensaje": "Usuario eliminado correctamente"}

# mascotas
@app.delete("/mascotas/{id}")
def borrar_mascota(id: int, db: Session = Depends(get_db)):
    mascota = db.query(Mascota).filter(Mascota.id == id).first()
    if not mascota:
        raise HTTPException(status_code=404, detail="Mascota no encontrada")
    
    db.delete(mascota)
    db.commit()
    return {"mensaje": "Mascota eliminada correctamente"}


# cuidadores
@app.delete("/perfiles-cuidadores/{id}")
def borrar_perfil_cuidador(id: int, db: Session = Depends(get_db)):
    perfil = db.query(PerfilCuidador).filter(PerfilCuidador.id == id).first()
    if not perfil:
        raise HTTPException(status_code=404, detail="Cuidadpr no encontrado")
    
    db.delete(perfil)
    db.commit()
    return {"mensaje": "Cuidador eliminado correctamente"}


# contratos
@app.delete("/contratos/{id}")
def borrar_contrato(id: int, db: Session = Depends(get_db)):
    contrato = db.query(Contrato).filter(Contrato.id == id).first()
    if not contrato:
        raise HTTPException(status_code=404, detail="Contrato no encontrado")
    
    db.delete(contrato)
    db.commit()
    return {"mensaje": "Contrato eliminado correctamente"}

# mensajes
@app.delete("/mensajes/{id}")
def borrar_mensaje(id: int, db: Session = Depends(get_db)):
    mensaje = db.query(Mensaje).filter(Mensaje.id == id).first()
    if not mensaje:
        raise HTTPException(status_code=404, detail="Mensaje no encontrado")
    
    db.delete(mensaje)
    db.commit()
    return {"mensaje": "Mensaje eliminado correctamente"}


# reseñas
@app.delete("/resenas/{id}")
def borrar_resena(id: int, db: Session = Depends(get_db)):
    resena = db.query(Resena).filter(Resena.id == id).first()
    if not resena:
        raise HTTPException(status_code=404, detail="Reseña no encontrada")
    
    db.delete(resena)
    db.commit()
    return {"mensaje": "Reseña eliminada correctamente"}

# FIN CRUD - DELETE