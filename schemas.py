from pydantic import BaseModel, EmailStr
from typing import List, Optional
from models import EstadoContrato, RolUsuario
from datetime import datetime, date

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

# lo que devuelve la API (sin la contraseña por seguridad)
class UsuarioOut(BaseModel):
    id: int
    username: str
    email: str
    nombre: str
    rol: RolUsuario

    class Config:
        from_attributes = True # permite a Pydantic leer datos de SQLAlchemy

# datos de las mascotas
class MascotaCreate(BaseModel):
    id_usuario: int
    nombre: str
    especie: Optional[str] = None
    raza: Optional[str] = None
    fecha_nacimiento: Optional[date] = None
    requisitos_tags: Optional[List] = None  # al ser JSON en la bbdd, le pido una lista
    personalidad_libre: Optional[str] = None
    foto_url: Optional[str] = None

class MascotaOut(BaseModel):
    id: int
    id_usuario: int
    nombre: str
    especie: Optional[str] = None
    foto_url: Optional[str] = None

    class Config:
        from_attributes = True

# datos de los cuidadores
class PerfilCuidadorCreate(BaseModel):
    id_usuario: int
    estudios: str  
    tarifa: float  
    cualidades_tags: Optional[List] = None
    sobre_mi: Optional[str] = None
    foto_url: Optional[str] = None

class PerfilCuidadorOut(BaseModel):
    id: int
    id_usuario: int
    tarifa: float

    class Config:
        from_attributes = True


# datos de los contratos
class ContratoCreate(BaseModel):
    id_dueno: int     
    id_cuidador: int  
    fecha_inicio: datetime
    fecha_fin: datetime
    precio_total: float
    detalles_servicio: Optional[str] = None
    estado: Optional[EstadoContrato] = EstadoContrato.Pendiente # un estado de los de la enumeración en models.py

class ContratoOut(BaseModel):
    id: int
    id_dueno: int
    id_cuidador: int
    estado: EstadoContrato
    precio_total: float

    class Config:
        from_attributes = True


# datos de los mensajes
class MensajeCreate(BaseModel):
    id_remitente: int     
    id_destinatario: int  
    contenido: str

class MensajeOut(BaseModel):
    id: int
    id_remitente: int
    id_destinatario: int
    contenido: str

    class Config:
        from_attributes = True


# datos de las reseñas
class ResenaCreate(BaseModel):
    id_contrato: int  
    id_autor: int
    calificacion: int
    comentario: Optional[str] = None

class ResenaOut(BaseModel):
    id: int
    id_contrato: int
    id_autor: int
    calificacion: int
    fecha_creacion: datetime

    class Config:
        from_attributes = True