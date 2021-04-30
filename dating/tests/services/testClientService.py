import os
import psycopg2
from unittest.mock import patch

from django.core.files.uploadedfile import UploadedFile
from django.http import HttpRequest, QueryDict
from django.test import TestCase

from base import settings
from dating.models.Client import Client
from dating.services.ClientService import ClientService
from dating.tests.DBDriver import DBDriver
from dating.utils.utils import get_upload_to


# Run TestClient from project root using unittests:
# python manage.py test dating.tests.services.testClientService

class TestClientService(TestCase):
    """Tests class ClientService."""

    @classmethod
    def setUpClass(cls):
        super(TestClientService, cls).setUpClass()
        db_params = {
            'database': settings.DATABASES['default']['TEST']['NAME'],
            'host': settings.DATABASES['default']['HOST'],
            'password': settings.DATABASES['default']['PASSWORD'],
            'port': settings.DATABASES['default']['PORT'],
            'user': settings.DATABASES['default']['USER']
        }
        cls.db_driver = DBDriver(psycopg2, db_params)

    def setUp(self):
        """Actions before each test."""

        self.service = ClientService()
        self.data = [
            {
                'first_name': 'Foo',
                'last_name': 'Bar',
                'email': 'foo@mail.ru',
                'gender': Client.Gender.MALE.value,
                'avatar': 'avatars/no-photo.png'
            },
            {
                'first_name': 'John',
                'last_name': 'Dow',
                'email': 'JohnDow@gmail.ru',
                'gender': Client.Gender.MALE.value,
                'avatar': 'avatars/no-photo.png'
            }
        ]

        keys = []
        values = []
        for k in self.data[1]:
            keys.append(k)
            values.append(self.data[1][k])
        query = "insert into {0} ({1}) values ('{2}')".format(
            Client._meta.db_table, ','.join(keys), "','".join(values)
        )
        self.db_driver.insert(query)
        query = 'select id from ' + Client._meta.db_table
        query += " where email = '{0}'".format(self.data[1]['email'])
        result = self.db_driver.select(query)
        self.data[1]['id'] = result[0]['id']

        self.post_request = HttpRequest()
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

        self.get_request = HttpRequest()
        self.get_request.GET = QueryDict().copy()
        self.get_request.POST['first_name'] = self.data[0]['first_name']

    def tearDown(self):
        """Actions after each test."""

        # Delete file from production folder after test ends.
        path = settings.MEDIA_ROOT + self.upload_to
        if os.path.exists(path):
            os.remove(path)

        query = 'delete from ' + Client._meta.db_table
        self.db_driver.delete(query)
        self.db_driver.close()

    def test_create_success(self):
        """Tests create(self, request) -> Dict.
        Success."""

        actual = self.service.create(self.post_request)
        expected = {
            'data': Client.objects.get(email=self.data[0]['email']),
            'errors': {}
        }
        self.assertEqual(expected, actual)

    def test_create_exception(self):
        """Tests create(self, request) -> Dict
        Throws an exception."""

        self.post_request.FILES['avatar'] = None
        actual = self.service.create(self.post_request)
        expected = {
            'data': None,
            'errors': {
                'service': "The 'avatar' attribute has no file associated with it."
            }
        }
        self.assertEqual(expected, actual)

    def test_read_success(self):
        """Tests read(self, request) -> Dict.
        Success."""

        expected = {
            'data': [
                {'id': self.data[1]['id'],
                 'first_name': self.data[1]['first_name'],
                 'last_name': self.data[1]['last_name'],
                 'email': self.data[1]['email'],
                 'gender': self.data[1]['gender'],
                 'avatar': self.data[1]['avatar'],
                 'coord_x': None,
                 'coord_y': None
                 }
            ],
            'errors': {}
        }

        actual = self.service.read(self.get_request)
        self.assertEqual(expected, actual)

    def test_read_with_params_success(self):
        """Tests read(self, request) -> Dict.
        request.GET['email']
        Success."""

        query = 'select * from ' + Client._meta.db_table
        query += " where first_name = '{0}'".format(
            self.data[1]['first_name']
        )
        result = self.db_driver.select(query)
        expected = {
            'data': result,
            'errors': {}
        }

        self.get_request.GET['first_name'] = self.data[1]['first_name']
        actual = self.service.read(self.get_request)
        self.assertEqual(expected, actual)

    @patch('django.db.models.query.QuerySet.all')
    def test_read_exception(self, mocked):
        """Tests read(self, request) -> Dict.
        Throws an exception."""

        error_message = 'Custom exception message'
        mocked.side_effect = Exception(error_message)
        expected = {
            'data': [],
            'errors': {'service': 'Custom exception message'}
        }

        self.get_request.GET['gender'] = 'fake value'
        actual = self.service.read(self.get_request)
        self.assertEqual(expected, actual)
