import logging
import traceback
from typing import Dict

from django.http import HttpRequest
from geopy.distance import distance, great_circle

from dating.models.Client import Client


class ClientService:
    """Client service."""

    def __init__(self):
        self.cur = None
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
            if 'radius' in request.GET:
                nearest = self.get_nearest(request)
                if not nearest['errors']:
                    clients = nearest['data']
            for field in ['first_name', 'last_name', 'gender']:
                if field in request.GET:
                    name = field + '__iexact'
                    f = {name: request.GET[field]}
                    clients = clients.filter(**f)
            if 'radius' in request.GET:
                result['data'] = list(filter(lambda c: great_circle(
                    (self.cur.coord_x, self.cur.coord_y),
                    (c.coord_x, c.coord_y)
                ).km < request.GET['radius'], clients.all()))
            else:
                clients = clients.all()
            result['data'] = [c for c in clients]
        except Exception as ex:
            self.logger.error(traceback.format_exc())
            result['errors'] = {'ClientService.read': ex.__str__()}
        finally:
            return result

    def get_nearest(self, request: HttpRequest) -> Dict:
        """
        Gets nearest clients as list.
        :param request: HTTP request object.
        :return: List with nearest clients.
        """

        result = {
            'data': [],
            'errors': {}
        }
        try:
            self.cur = Client.objects.get(id=request.GET['id'])
            point_n = distance(kilometers=request.GET['radius'])\
                .destination((self.cur.coord_x, self.cur.coord_y), bearing=0)
            point_e = distance(kilometers=request.GET['radius'])\
                .destination((self.cur.coord_x, self.cur.coord_y), bearing=90)
            point_s = distance(kilometers=request.GET['radius'])\
                .destination((self.cur.coord_x, self.cur.coord_y), bearing=180)
            point_w = distance(kilometers=request.GET['radius'])\
                .destination((self.cur.coord_x, self.cur.coord_y), bearing=-90)

            result['data'] = Client.objects.exclude(id=self.cur.id).filter(
                coord_x__range=(point_s.latitude, point_n.latitude),
                coord_y__range=(point_w.longitude, point_e.longitude)
            )
        except Exception as ex:
            self.logger.error(traceback.format_exc())
            result['errors'] = {'ClientService.get_nearest': ex.__str__()}
        finally:
            return result
