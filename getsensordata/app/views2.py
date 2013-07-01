from pyramid.response import Response
from pyramid.view import view_config

from sqlalchemy.exc import DBAPIError

@view_config(route_name='welcome', renderer='../templates/base.pt')
def welcome_kalle(request):
  return {'name':'Jakob'}
