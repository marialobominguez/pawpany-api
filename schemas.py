from pydantic import BaseModel, EmailStr
from typing import Optional
from models import RolUsuario

# datos del usuario general
class UsuarioCreate(BaseModel):
    username: str
    email: EmailStr
    password_hash: str # TODO: ENCRIPTAR
    nombre: str
    apellido1: str
    apellido2: Optional[str] = None
    ubicacion: Optional[str] = None
    rol: RolUsuario # el menú creado en models.py

# Esto es lo que la API nos DEVOLVERÁ (sin la contraseña por seguridad)
class UsuarioOut(BaseModel):
    id: int
    username: str
    email: str
    nombre: str
    rol: RolUsuario

    class Config:
        from_attributes = True # permite a Pydantic leer datos de SQLAlchemy