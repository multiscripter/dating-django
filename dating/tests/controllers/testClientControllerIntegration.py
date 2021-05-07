import json
import os
from unittest.mock import patch

import django
from django.test import TestCase
from rest_framework import status

from base import settings
from dating.models.Client import Client
from dating.models.ClientSerializer import ClientSerializer
from utils.utils import get_upload_to


# Run TestClient from project root using unittests:
# python manage.py test dating.tests.controllers.testClientControllerIntegration

class TestClientControllerIntegration(TestCase):
    """controllers.client integration tests."""

    def setUp(self):
        """Actions before each test."""

        self.client = django.test.Client()
        self.data = []
        for a in range(2):
            self.data.append({
                'first_name': f'Foo-{a}',
                'last_name': f'Bar-{a}',
                'email': f'foo-{a}@mail.ru',
                'gender': Client.Gender.MALE.value,
                'avatar': 'avatars/no-photo.png'
            })

        self.avatar_path = ''
        for filename in ['Тестовое фото клиента.jpeg', 'test-client-foto.jpeg']:
            self.upload_to = get_upload_to(Client(), filename)
            path = settings.MEDIA_ROOT + filename
            if os.path.isfile(path):
                self.avatar_path = path
                break

    def tearDown(self):
        """Actions after each test."""

        # Delete file from production folder after test ends.
        path = settings.MEDIA_ROOT + self.upload_to
        if os.path.exists(path):
            os.remove(path)

    def test_create_success(self):
        """Tests controllers.client.create(request) -> JsonResponse.
        Request method is POST.
        Returned HTTP status: 201 Created.
        """

        self.data[0]['avatar'] = open(self.avatar_path, 'rb')
        response = self.client.post('/api/clients/create', data=self.data[0])
        self.assertEqual(status.HTTP_201_CREATED, response.status_code)

    @patch('django.db.models.base.Model.save')
    def test_create_error_bad_request(self, mocked):
        """Tests controllers.client.create(request: HttpRequest) -> JsonResponse.
        Throws an exception during creating client.
        Returned HTTP status: 400 Bad Request."""

        error_message = 'Custom exception message'
        mocked.side_effect = Exception(error_message)
        expected = {
            'data': None,
            'errors': {'ClientService.create': error_message}
        }

        response = self.client.post('/api/clients/create', data=self.data[0])
        self.assertEqual(status.HTTP_400_BAD_REQUEST, response.status_code)

        actual = json.loads(response.content.decode('utf-8'))
        self.assertEqual(expected, actual)

    def test_create_error_method_not_allowed(self):
        """Tests ClientController.post(self, request: HttpRequest) -> JsonResponse.
        Request method is GET.
        Error. 405 Method Not Allowed."""

        response = self.client.get('/api/clients/create')
        self.assertEqual(
            status.HTTP_405_METHOD_NOT_ALLOWED, response.status_code
        )

    def test_get_list_success(self):
        """Tests controllers.client.get_list(request: HttpRequest) -> JsonResponse.
        Request method is GET.
        Returned HTTP status: 200 Ok.
        """

        clients = []
        for a in self.data:
            c = Client(**a)
            c.save()
            clients.append(ClientSerializer(c).data)
        expected = {
            'data': clients,
            'errors': {}
        }

        response = self.client.get('/api/list')
        self.assertEqual(status.HTTP_200_OK, response.status_code)

        actual = json.loads(response.content.decode('utf-8'))
        self.assertEqual(expected, actual)

    @patch('django.db.models.query.QuerySet.all')
    def test_get_list_error_bad_request(self, mocked):
        """Tests controllers.client.get_list(request: HttpRequest) -> JsonResponse.
        Throws an exception during fetching clients.
        Returned HTTP status: 400 Bad Request."""

        error_message = 'Custom exception message'
        mocked.side_effect = Exception(error_message)
        expected = {
            'data': [],
            'errors': {'ClientService.read': error_message}
        }
        data = {'gender': 'fake value'}
        response = self.client.get('/api/list', data=data)
        self.assertEqual(status.HTTP_400_BAD_REQUEST, response.status_code)

        actual = json.loads(response.content.decode('utf-8'))
        self.assertEqual(expected, actual)

    def test_get_list_error_method_not_allowed(self):
        """Tests controllers.client.create(request) -> JsonResponse.
        Request method is POST.
        Returned HTTP status: 405 Method Not Allowed."""

        response = self.client.post('/api/list')
        self.assertEqual(
            status.HTTP_405_METHOD_NOT_ALLOWED, response.status_code
        )
