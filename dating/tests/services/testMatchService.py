import psycopg2
from unittest.mock import patch

from django.test import TestCase

from base import settings
from dating.models.Client import Client
from dating.models.Match import Match
from dating.services.MatchService import MatchService


# Run TestClient from project root using unittests:
# python manage.py test dating.tests.services.testMatchService
from dating.tests.DBDriver import DBDriver


class TestMatchService(TestCase):
    """Tests class ClientService."""

    @classmethod
    def setUpClass(cls):
        super(TestMatchService, cls).setUpClass()
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

        self.service = MatchService()
        self.data = [
            {
                'first_name': 'Foo',
                'last_name': 'Bar',
                'email': 'foo@mail.ru',
                'gender': Client.Gender.MALE.value,
                'avatar': 'avatars/no-photo.png'
            },
            {
                'first_name': 'Jane',
                'last_name': 'Dow',
                'email': 'JaneDow@gmail.ru',
                'gender': Client.Gender.FEMALE.value,
                'avatar': 'avatars/no-photo.png'
            }
        ]
        self.clients = []
        for a in self.data:
            client = Client(**a)
            client.save()
            self.clients.append(client)

    def tearDown(self):
        """Actions after each test."""

        # query = 'delete from ' + Client._meta.db_table
        # self.db_driver.delete(query)
        self.db_driver.close()

    def test_create_success(self):
        """Tests create(self, params: Dict) -> Dict
        Success."""

        params = {
            'from_id': self.clients[0],
            'to_id': self.clients[1]
        }
        actual = self.service.create(params)
        match = Match.objects.all()[0]
        expected = {
            'data': match,
            'errors': {},
            'is_created': True
        }
        self.assertEqual(expected, actual)

    @patch('django.db.models.query.QuerySet.get_or_create')
    def test_create_exception(self, mocked):
        """Tests create(self, params: Dict) -> Dict
        Throws an exception."""

        error_message = 'Custom exception message'
        mocked.side_effect = Exception(error_message)
        expected = {
            'data': None,
            'errors': {'service': 'Custom exception message'},
            'is_created': None
        }

        actual = self.service.create({})
        self.assertEqual(expected, actual)
