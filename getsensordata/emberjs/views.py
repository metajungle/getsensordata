from pyramid.response import Response
from pyramid.view import view_config

from sqlalchemy.exc import DBAPIError

@view_config(route_name='emberjs', renderer='emberjs.mak')
def emberjs(request):
  return {'name':'Jakob'}

@view_config(route_name='embertest', renderer='embertest.mak')
def test(request):
  return {'name':'Jakob'}

