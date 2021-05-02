import json
import os
from unittest.mock import patch

from django.core.files.uploadedfile import UploadedFile
from django.http import HttpRequest, QueryDict
from django.test import TestCase

from base import settings
from dating.models.Client import Client
from dating.controllers.client import create, get_list
from dating.utils.utils import get_upload_to


# Run TestClient from project root using unittests:
# python manage.py test dating.tests.controllers.testClientController

class TestClientController(TestCase):
    """Tests functions from controllers.client"""

    def setUp(self):
        """Actions before each test."""

        self.data = []
        for a in range(2):
            self.data.append({
                'first_name': f'Foo-{a}',
                'last_name': f'Bar-{a}',
                'email': f'foo-{a}@mail.ru',
                'gender': Client.Gender.MALE.value,
                'avatar': 'avatars/no-photo.png'
            })

        self.post_request = HttpRequest()
        self.post_request.method = 'POST'
        self.post_request.POST = QueryDict().copy()
        self.post_request.POST['first_name'] = self.data[0]['first_name']
        self.post_request.POST['last_name'] = self.data[0]['last_name']
        self.post_request.POST['email'] = self.data[0]['email']
        self.post_request.POST['gender'] = self.data[0]['gender']

        self.post_request.FILES = QueryDict().copy()
        filename = 'Тестовое фото клиента.jpeg'
        self.upload_to = get_upload_to(Client(), filename)
        path = settings.MEDIA_ROOT + filename
        self.post_request.FILES['avatar'] = UploadedFile(
            file=open(path, 'rb'),
            name=filename
        )

    def tearDown(self):
        """Actions after each test."""

        # Delete file from production folder after test ends.
        path = settings.MEDIA_ROOT + self.upload_to
        if os.path.exists(path):
            os.remove(path)

    def test_create_success(self):
        """Tests create(request).
        Client successfully created.
        Returned HTTP status: 201 Created."""

        response = create(self.post_request)
        self.assertEqual(201, response.status_code)

        content = response.content.decode('utf-8')
        actual = json.loads(content)
        expected = {
            'data': Client.objects.get(email=self.data[0]['email']).to_dict(),
            'errors': {}
        }
        self.assertEqual(expected, actual)

    @patch('django.db.models.base.Model.save')
    def test_create_error_bad_request(self, mocked):
        """Tests create(request).
        Throws an exception during creating client.
        Returned HTTP status: 400 Bad Request."""

        error_message = 'Custom exception message'
        mocked.side_effect = Exception(error_message)
        expected = {
            'data': None,
            'errors': {'ClientService.create': error_message}
        }

        response = create(self.post_request)
        self.assertEqual(400, response.status_code)

        content = response.content.decode('utf-8')
        actual = json.loads(content)
        self.assertEqual(expected, actual)

    def test_create_error_method_not_allowed(self):
        """Tests create(request).
        Request method is GET.
        Error. 405 Method Not Allowed."""

        request = HttpRequest()
        request.method = 'GET'
        response = create(request)
        self.assertEqual(405, response.status_code)

    def test_get_list_success(self):
        """Tests get_list(request).
        Returned HTTP status: 200 OK."""

        clients = []
        for a in self.data:
            c = Client(**a)
            c.save()
            clients.append(c.to_dict())
        expected = {
            'data': clients,
            'errors': {}
        }

        request = HttpRequest()
        request.method = 'GET'
        response = get_list(request)
        self.assertEqual(200, response.status_code)

        content = response.content.decode('utf-8')
        actual = json.loads(content)
        self.assertEqual(expected, actual)

    @patch('django.db.models.query.QuerySet.all')
    def test_get_list_error_bad_request(self, mocked):
        """Tests get_list(request).
        Throws an exception during fetching clients.
        Returned HTTP status: 400 Bad Request."""

        error_message = 'Custom exception message'
        mocked.side_effect = Exception(error_message)
        expected = {
            'data': [],
            'errors': {'ClientService.read': error_message}
        }

        request = HttpRequest()
        request.method = 'GET'
        request.GET = QueryDict().copy()
        request.GET['gender'] = 'fake value'
        response = get_list(request)
        self.assertEqual(400, response.status_code)

        content = response.content.decode('utf-8')
        actual = json.loads(content)
        self.assertEqual(expected, actual)

    def test_get_list_error_method_not_allowed(self):
        """Tests get_list(request).
        Request method is POST.
        Returned HTTP status: 405 Method Not Allowed."""

        response = get_list(self.post_request)
        self.assertEqual(405, response.status_code)
