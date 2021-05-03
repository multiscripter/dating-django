from django.http import HttpRequest, QueryDict
from django.test import TestCase
from unittest.mock import patch

from dating.models.Client import Client
from dating.services.ClientService import ClientService


# Run TestClient from project root using unittests:
# python manage.py test dating.tests.services.testClientServiceGetNearest

class TestClientServiceGetNearest(TestCase):
    """Tests method ClientService.get_nearest(request)."""

    def setUp(self):
        """Actions before each test."""

        self.service = ClientService()
        coordinates = [
            [53.31445021613165, 34.30845257302439],  # 0
            [53.58336732914775, 34.33153505759788],  # 29.94 km
            [53.530009345429725, 33.73617239222088],  # 44.85 km
            [52.5686287280632, 34.562924641662235],  # 84.59 km
            [53.44408194067252, 35.99787550304133]  # 112.93 km
        ]
        self.clients = []
        for a in range(5):
            client = Client()
            client.first_name = f'Foo-name-{a}'
            client.last_name = f'Foo-family-{a}'
            client.email = f'foo-{a}@gmail.com'
            client.gender = Client.Gender.FEMALE.value \
                if a % 2 else Client.Gender.MALE.value
            client.coord_x = coordinates[a][0]
            client.coord_y = coordinates[a][1]
            client.save()
            self.clients.append(client)

        self.get_request = HttpRequest()
        self.get_request.GET = QueryDict().copy()
        self.get_request.GET['id'] = self.clients[0].id

    @patch('django.db.models.query.QuerySet.exclude')
    def test_get_nearest_error(self, mocked):
        """Tests get_nearest(self, request: HttpRequest) -> Dict;
        Throws exception."""

        error_message = 'Custom exception message'
        mocked.side_effect = Exception(error_message)
        expected = {
            'data': [],
            'errors': {'ClientService.get_nearest': error_message}
        }
        self.get_request.GET['radius'] = 123
        actual = self.service.get_nearest(self.get_request)
        self.assertEqual(expected, actual)

    def test_get_nearest_radius_30km(self):
        """Tests get_nearest(self, request: HttpRequest) -> Dict;
        Radius: 30 km.
        Success."""

        expected = {
            'data': [self.clients[1]],
            'errors': {}
        }
        self.get_request.GET['radius'] = 30
        actual = self.service.read(self.get_request)
        self.assertEqual(expected, actual)

    def test_get_nearest_radius_45km(self):
        """Tests get_nearest(self, request: HttpRequest) -> Dict;
        Radius: 45 km.
        Success."""

        expected = {
            'data': self.clients[1:3],
            'errors': {}
        }
        self.get_request.GET['radius'] = 45
        actual = self.service.read(self.get_request)
        self.assertEqual(expected, actual)

    def test_get_nearest_radius_85km(self):
        """Tests get_nearest(self, request: HttpRequest) -> Dict;
        Radius: 85 km.
        Success."""

        expected = {
            'data': self.clients[1:4],
            'errors': {}
        }
        self.get_request.GET['radius'] = 85
        actual = self.service.read(self.get_request)
        self.assertEqual(expected, actual)

    def test_get_nearest_radius_113km(self):
        """Tests get_nearest(self, request: HttpRequest) -> Dict;
        Radius: 113 km.
        Success."""

        expected = {
            'data': self.clients[1:5],
            'errors': {}
        }
        self.get_request.GET['radius'] = 113
        actual = self.service.read(self.get_request)
        self.assertEqual(expected, actual)

    def test_read_with_params_nearest(self):
        """Tests read(self, request) -> Dict.
        GET parameters: gender=2, radius=50
        Success."""

        expected = {
            'data': [self.clients[1]],
            'errors': {}
        }
        self.get_request.GET['gender'] = Client.Gender.FEMALE.value
        self.get_request.GET['radius'] = 50
        actual = self.service.read(self.get_request)
        self.assertEqual(expected, actual)
