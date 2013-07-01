from pyramid.response import Response
from pyramid.view import view_config

from sqlalchemy.exc import DBAPIError

@view_config(route_name='mapbox', renderer='../templates/mapbox.pt')
def welcome_kalle(request):
  return {'name':'Jakob'}

