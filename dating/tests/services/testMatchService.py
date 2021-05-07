from unittest.mock import patch

from django.http import HttpRequest, QueryDict
from django.test import TestCase

from dating.models.Client import Client
from dating.models.Match import Match
from dating.models.MatchSerializer import MatchSerializer
from dating.services.MatchService import MatchService


# Run TestClient from project root using unittests:
# python manage.py test dating.tests.services.testMatchService


class TestMatchService(TestCase):
    """Tests class ClientService."""

    def setUp(self):
        """Actions before each test."""

        self.service = MatchService()
        self.data = []
        self.clients = []
        for a in range(4):
            self.data.append({
                'first_name': f'Foo-{a}',
                'last_name': f'Bar-{a}',
                'email': f'foo-{a}@mail.ru',
                'gender': Client.Gender.FEMALE.value if
                a % 2 else Client.Gender.MALE.value,
                'avatar': 'avatars/no-photo.png'
            })
            client = Client(**self.data[a])
            client.save()
            self.clients.append(client)
        self.match = Match()
        self.match.from_id = self.clients[2]
        self.match.to_id = self.clients[3]
        self.match.save()

        self.post_request = HttpRequest()
        self.post_request.POST = QueryDict().copy()
        self.post_request.POST['id'] = self.clients[1].id

    def test_create_success(self):
        """Tests create(self, params: Dict) -> Dict
        Success."""

        actual = self.service.create(self.post_request, self.clients[0].id)
        match = Match.objects.filter(
            from_id=self.clients[0], to_id=self.clients[1]
        )[0]
        expected = {
            'data': match,
            'errors': {},
            'is_created': True
        }
        self.assertEqual(expected, actual)

    def test_create_many_matches_success(self):
        """Tests create(self, params: Dict) -> Dict
        One client has several matches.
        Success."""

        actual_1 = self.service.create(self.post_request, self.clients[0].id)
        self.post_request.POST['id'] = self.clients[3].id
        actual_2 = self.service.create(self.post_request, self.clients[0].id)
        actual = [actual_1['data'], actual_2['data']]
        expected = Match.objects.filter(from_id=self.clients[0])
        expected = [e for e in expected]
        self.assertEqual(expected, actual)

    @patch('django.db.models.query.QuerySet.get_or_create')
    def test_create_exception(self, mocked):
        """Tests create(self, params: Dict) -> Dict
        Throws an exception."""

        error_message = 'Custom exception message'
        mocked.side_effect = Exception(error_message)
        expected = {
            'data': None,
            'errors': {'MatchService.create': 'Custom exception message'},
            'is_created': None
        }

        actual = self.service.create(self.post_request, self.clients[0].id)
        self.assertEqual(expected, actual)

    def test_read_success(self):
        """Tests read(self, params: Dict) -> Dict
        Success."""

        expected = {
            'data': [MatchSerializer(self.match).data],
            'errors': {}
        }
        self.post_request.POST['id'] = self.clients[2].id
        actual = self.service.read(self.post_request, self.clients[3].id)
        actual['data'] = [MatchSerializer(m).data for m in actual['data']]
        self.assertEqual(expected, actual)

    @patch('django.db.models.query.QuerySet.all')
    def test_read_exception(self, mocked):
        """Tests read(self, request) -> Dict.
        Throws an exception."""

        error_message = 'Custom exception message'
        mocked.side_effect = Exception(error_message)
        expected = {
            'data': [],
            'errors': {'MatchService.read': error_message}
        }

        actual = self.service.read(self.post_request, self.clients[3].id)
        self.assertEqual(expected, actual)

    def test_update_success(self):
        """Tests update(self, match: Match, params: Dict) -> Dict
        Success."""

        expected = {
            'data': self.match,
            'errors': {}
        }
        actual = self.service.update(self.match, {'is_mutually': True})
        self.assertEqual(expected, actual)

    @patch('django.db.models.base.Model.save')
    def test_update_exception(self, mocked):
        """Tests update(self, match: Match, params: Dict) -> Dict
        Throws an exception."""

        error_message = 'Custom exception message'
        mocked.side_effect = Exception(error_message)
        expected = {
            'data': None,
            'errors': {'MatchService.update': error_message}
        }
        actual = self.service.update(self.match, {'is_mutually': True})
        self.assertEqual(expected, actual)
