import logging
import traceback
from typing import Dict

from django.http import HttpRequest

from dating.models.Client import Client


class ClientService:
    """Client service."""

    def __init__(self):
        self.logger = logging.getLogger('django')

    def create(self, request: HttpRequest) -> Dict:
        """
        Creates a client.
        :param request: HTTP request object.
        :return: result.
        """

        result = {
            'data': None,
            'errors': {}
        }
        client = Client()
        client.first_name = request.POST['first_name']
        client.last_name = request.POST['last_name']
        client.email = request.POST['email']
        client.gender = Client.Gender(request.POST['gender'])
        client.avatar = request.FILES['avatar'] \
            if 'avatar' in request.FILES and request.FILES['avatar'] \
            else None
        try:
            client.save()
            result['data'] = client
        except Exception as ex:
            self.logger.error(traceback.format_exc())
            result['errors'] = {'ClientService.create': ex.__str__()}
        finally:
            return result

    def read(self, request: HttpRequest) -> Dict:
        """
        Gets client list.
        :param request: HTTP request object.
        :return: result.
        """

        result = {
            'data': [],
            'errors': {}
        }
        try:
            clients = Client.objects
            for field in ['first_name', 'last_name', 'gender']:
                if field in request.GET:
                    name = field + '__iexact'
                    f = {name: request.GET[field]}
                    clients = clients.filter(**f)
            clients = clients.all()
            if len(clients):
                for c in clients:
                    result['data'].append(c.to_dict())
        except Exception as ex:
            self.logger.error(traceback.format_exc())
            result['errors'] = {'ClientService.read': ex.__str__()}
        finally:
            return result
