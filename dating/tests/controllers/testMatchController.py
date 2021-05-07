import json
from unittest.mock import patch

from django.http import HttpRequest, QueryDict
from django.test import TestCase
from rest_framework import status
from rest_framework.test import APIRequestFactory

from dating.controllers.match import create
from dating.models.Client import Client
from dating.models.Match import Match
from dating.models.MatchSerializer import MatchSerializer
from dating.services.MatchService import MatchService


# Run TestClient from project root using unittests:
# python manage.py test dating.tests.controllers.testMatchController

class TestMatchController(TestCase):
    """Tests functions from controllers.match"""

    def setUp(self):
        """Actions before each test."""

        self.factory = APIRequestFactory()
        self.service = MatchService()
        self.data = []
        self.clients = []
        for a in range(4):
            self.data.append({
                'first_name': f'Foo-{a}',
                'last_name': f'Bar-{a}',
                'email': f'foo-{a}@mail.ru',
                'gender': Client.Gender.MALE.value,
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
        self.post_request.method = 'POST'
        self.post_data = {'id': self.clients[1].id}
        self.post_request.POST = QueryDict().copy()
        self.post_request.POST['id'] = self.clients[1].id

    def test_create_match_creates_success(self):
        """Tests create(request, from_id).
        Match does not exist.
        Match successfully created.
        Returned HTTP status: 201 Created."""

        request = self.factory.post(
            '/api/clients/create/', self.post_data
        )
        response = create(request, self.clients[0].id)
        self.assertEqual(status.HTTP_201_CREATED, response.status_code)

        content = response.content.decode('utf-8')
        actual = json.loads(content)
        match = Match.objects.filter(
            from_id=self.clients[0], to_id=self.clients[1]
        )[0]
        expected = {
            'data': MatchSerializer(match).data,
            'errors': {},
            'is_created': True
        }
        self.assertEqual(expected, actual)

    @patch('django.db.models.query.QuerySet.get_or_create')
    def test_create_match_creates_exception(self, mocked):
        """Tests create(request, from_id).
        Match does not exist.
        Throws an exception during creating match.
        Returned HTTP status: 400 Bad Request."""

        error_message = 'Custom exception message'
        mocked.side_effect = Exception(error_message)
        expected = {
            'data': None,
            'errors': {'MatchService.create': 'Custom exception message'},
            'is_created': None
        }

        request = self.factory.post(
            '/api/clients/create/', self.post_data
        )
        response = create(request, self.clients[0].id)
        self.assertEqual(status.HTTP_400_BAD_REQUEST, response.status_code)

        content = response.content.decode('utf-8')
        actual = json.loads(content)
        self.assertEqual(expected, actual)

    def test_create_match_creates_not_modified(self):
        """Tests create(request, from_id).
        Match does not exist.
        New Match did not create.
        Returned HTTP status: 304 Not Modified."""

        self.post_data['id'] = self.clients[3].id
        request = self.factory.post(
            '/api/clients/create/', self.post_data
        )
        response = create(request, self.clients[2].id)
        self.assertEqual(status.HTTP_304_NOT_MODIFIED, response.status_code)

    def test_create_match_updates_success(self):
        """Tests create(request, from_id).
        Match exists.
        Match successfully updated.
        Returned HTTP status: 200 OK."""

        self.match.is_mutually = True
        expected = {
            'data': MatchSerializer(self.match).data,
            'errors': {}
        }

        self.post_data['id'] = self.clients[2].id
        request = self.factory.post(
            '/api/clients/create/', self.post_data
        )
        response = create(request, self.clients[3].id)
        self.assertEqual(status.HTTP_200_OK, response.status_code)

        content = response.content.decode('utf-8')
        actual = json.loads(content)
        self.assertEqual(expected, actual)

    @patch('django.db.models.base.Model.save')
    def test_create_match_updates_exception(self, mocked):
        """Tests create(request, from_id).
        Match exists.
        Match successfully updated.
        Returned HTTP status: 400 Bad Request."""

        error_message = 'Custom exception message'
        mocked.side_effect = Exception(error_message)
        expected = {
            'data': None,
            'errors': {'MatchService.update': error_message}
        }

        self.post_data['id'] = self.clients[2].id
        request = self.factory.post(
            '/api/clients/create/', self.post_data
        )
        response = create(request, self.clients[3].id)
        self.assertEqual(status.HTTP_400_BAD_REQUEST, response.status_code)

        content = response.content.decode('utf-8')
        actual = json.loads(content)
        self.assertEqual(expected, actual)

    def test_create_match_updates_not_modified(self):
        """Tests create(request, from_id).
        Match exists.
        Old and new data are same.
        Returned HTTP status: 304 Not Modified."""

        self.match.is_mutually = False
        self.post_data['id'] = self.clients[2].id
        request = self.factory.post(
            '/api/clients/create/', self.post_data
        )
        create(request, self.clients[3].id)
        response = create(request, self.clients[3].id)
        self.assertEqual(status.HTTP_304_NOT_MODIFIED, response.status_code)

    def test_create_error_method_not_allowed(self):
        """Tests create(request, from_id).
        Match exists.
        Request method is GET.
        Returned HTTP status: 405 Method Not Allowed."""

        request = HttpRequest()
        request.method = 'GET'
        response = create(request, 1)
        self.assertEqual(status.HTTP_405_METHOD_NOT_ALLOWED, response.status_code)
