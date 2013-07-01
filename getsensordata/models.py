from datetime import datetime

from sqlalchemy import (
    Column,
    Integer,
    Unicode, 
    Text,
    DateTime, 
    MetaData, 
    )

from sqlalchemy.ext.declarative import declarative_base

from sqlalchemy.orm import (
    scoped_session,
    sessionmaker,
    )
    
from geoalchemy2 import Geometry

from zope.sqlalchemy import ZopeTransactionExtension

metadata = MetaData()

DBSession = scoped_session(sessionmaker(extension=ZopeTransactionExtension()))
Base = declarative_base(metadata=metadata)

class MyModel(Base):
    __tablename__ = 'models'
    id = Column(Integer, primary_key=True)
    name = Column(Text, unique=True)
    value = Column(Integer)

    def __init__(self, name, value):
        self.name = name
        self.value = value

class Road(Base):
    __tablename__ = 'roads'
    id = Column(Integer, primary_key=True)
    name = Column(Unicode, nullable=False)
    width = Column(Integer)
    created = Column(DateTime, default=datetime.now())
    # geom = Column(Geometry(geometry_type='POINT', srid=4326))
    geom = Column(Geometry('POLYGON'))
    
    
# class SensorOffering(Base):
#   """ A sensor offering """
#   id = Column(Integer, primary_key=True)
#   gmlId = Column(Unicode, nullable=False)
#   name = Column(Unicode)
#   description = Column(Unicode)
#   srsName = Column(Unicode)
#   geom = Column(Geometry(geometry_type='POLYGON', srid=4326))
  
  
