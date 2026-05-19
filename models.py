from sqlalchemy import Column, Integer, String, Text, DateTime, Date, Boolean, ForeignKey, Numeric, JSON, Enum, func
from sqlalchemy.orm import relationship
from database import Base
import enum

# Opciones
class RolUsuario(enum.Enum):
    dueño = "dueño"
    cuidador = "cuidador"

class EstadoContrato(enum.Enum):
    Pendiente = "Pendiente"
    Aceptado = "Aceptado"
    Rechazado = "Rechazado"
    Completado = "Completado"
    Cancelado = "Cancelado"

# Tabla usuarios generales
class Usuario(Base): # pongo Base para que SQLAlchemy sepa que es una tabla que tiene que buscar en la bbdd
    __tablename__ = "Usuarios"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(50), unique=True, nullable=False)
    email = Column(String(255), unique=True, nullable=False)
    password_hash = Column(String(255), nullable=False)
    nombre = Column(String(100), nullable=False)
    apellido1 = Column(String(100), nullable=False)
    apellido2 = Column(String(100))
    ubicacion = Column(String(150))
    rol = Column(Enum(RolUsuario), nullable=False)
    fecha_registro = Column(DateTime, default=func.now())

    # relaciones de los usuarios generales con los tipos de usuario
    perfil_cuidador = relationship("PerfilCuidador", back_populates="usuario", uselist=False)
    mascota = relationship("Mascota", back_populates="usuario", uselist=False) 
    
    # relaciones con mensajes y contrato
    contratos_como_dueno = relationship("Contrato", foreign_keys="[Contrato.id_dueno]", back_populates="dueno")
    contratos_como_cuidador = relationship("Contrato", foreign_keys="[Contrato.id_cuidador]", back_populates="cuidador")
    mensajes_enviados = relationship("Mensaje", foreign_keys="[Mensaje.id_remitente]", back_populates="remitente")
    mensajes_recibidos = relationship("Mensaje", foreign_keys="[Mensaje.id_destinatario]", back_populates="destinatario")

# tabla cuidadores 
class PerfilCuidador(Base):
    __tablename__ = "Perfiles_Cuidadores"

    id = Column(Integer, primary_key=True, index=True)
    id_usuario = Column(Integer, ForeignKey("Usuarios.id", ondelete="CASCADE"), unique=True, nullable=False)
    foto_url = Column(String(255))
    estudios = Column(String(255), nullable=False)
    cualidades_tags = Column(JSON)
    sobre_mi = Column(Text)
    tarifa = Column(Numeric(6, 2)) # Para guardar precios (ej: 15.50)

    usuario = relationship("Usuario", back_populates="perfil_cuidador")

# tabla mascotas
class Mascota(Base):
    __tablename__ = "Mascotas"

    id = Column(Integer, primary_key=True, index=True)
    id_usuario = Column(Integer, ForeignKey("Usuarios.id", ondelete="CASCADE"), unique=True, nullable=False)
    foto_url = Column(String(255))
    nombre = Column(String(100), nullable=False)
    especie = Column(String(100))
    raza = Column(String(100))
    fecha_nacimiento = Column(Date)
    requisitos_tags = Column(JSON)
    personalidad_libre = Column(Text)

    usuario = relationship("Usuario", back_populates="mascota")

# tabla contrato
class Contrato(Base):
    __tablename__ = "Contratos"

    id = Column(Integer, primary_key=True, index=True)
    id_dueno = Column(Integer, ForeignKey("Usuarios.id", ondelete="CASCADE"), nullable=False)
    id_cuidador = Column(Integer, ForeignKey("Usuarios.id", ondelete="CASCADE"), nullable=False)
    fecha_inicio = Column(DateTime, nullable=False)
    fecha_fin = Column(DateTime, nullable=False)
    estado = Column(Enum(EstadoContrato), default=EstadoContrato.Pendiente)
    precio_total = Column(Numeric(8, 2))
    detalles_servicio = Column(Text)

    dueno = relationship("Usuario", foreign_keys=[id_dueno], back_populates="contratos_como_dueno")
    cuidador = relationship("Usuario", foreign_keys=[id_cuidador], back_populates="contratos_como_cuidador")
    resena = relationship("Resena", back_populates="contrato", uselist=False)

# tabla mensajes
class Mensaje(Base):
    __tablename__ = "Mensajes"

    id = Column(Integer, primary_key=True, index=True)
    id_remitente = Column(Integer, ForeignKey("Usuarios.id", ondelete="CASCADE"), nullable=False)
    id_destinatario = Column(Integer, ForeignKey("Usuarios.id", ondelete="CASCADE"), nullable=False)
    contenido = Column(Text, nullable=False)
    fecha_envio = Column(DateTime)
    leido = Column(Boolean, default=False) # El tinyint(1) de MySQL es un Boolean

    remitente = relationship("Usuario", foreign_keys=[id_remitente], back_populates="mensajes_enviados")
    destinatario = relationship("Usuario", foreign_keys=[id_destinatario], back_populates="mensajes_recibidos")

# tabla reseñas
class Resena(Base):
    __tablename__ = "Resenas"

    id = Column(Integer, primary_key=True, index=True)
    id_contrato = Column(Integer, ForeignKey("Contratos.id", ondelete="CASCADE"), unique=True, nullable=False)
    calificacion = Column(Integer)
    comentario = Column(Text)
    fecha_creacion = Column(DateTime)

    contrato = relationship("Contrato", back_populates="resena")