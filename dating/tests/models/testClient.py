import os

from django.core.files.uploadedfile import UploadedFile
from django.test import TestCase

from base import settings
from dating.models.Client import Client
from dating.models.ClientSerializer import ClientSerializer
from utils.utils import get_upload_to

# Run TestClient from project root using unittests:
# python manage.py test dating.tests.models.testClient

# Run all tests from project root using unittests:
# coverage erase
# coverage run manage.py test
# coverage html

# Run TestClient from project root using pytest with pytest.ini:
# pytest ./dating/tests/models/testClient.py

# Run all test in 'models' from project root using pytest with pytest.ini:
# pytest ./dating/tests/models/*


class TestClient(TestCase):
    """Tests class Client."""

    def setUp(self):
        """Actions before each test."""

        self.data = {
            'id': 1,
            'first_name': 'Foo',
            'last_name': 'Bar',
            'email': 'foo@mail.ru',
            'gender': Client.Gender.MALE.value
        }
        self.client = Client(**self.data)
        self.client.save()
        self.data['avatar'] = {
            'name': 'avatars/no-photo.png',
            'url': '/{0}avatars/no-photo.png'.format(settings.MEDIA_URL)
        }

    def test_str(self):
        """Tests __str__(self)."""

        expected = 'Client{'
        expected += ' id: {0}'.format(self.data['id'])
        expected += ' first_name: ' + self.data['first_name']
        expected += ' last_name: ' + self.data['last_name']
        expected += ' email: ' + self.data['email']
        expected += ' gender: ' + self.data['gender']
        expected += ' avatar: ' + self.data['avatar']['name']
        expected += ' }'

        actual = self.client.__str__()
        self.assertEqual(expected, actual)

    def test_image_tag(self):
        """Tests image_tag(self)."""

        expected = '<img src="'
        expected += self.data['avatar']['url']
        expected += '" style="width: 50px; height:75px;" />'
        actual = self.client.image_tag()
        self.assertEqual(expected, actual)

    def test_save_avatar_changed(self):
        """Tests save(
            self,
            force_insert=False,
            force_update=False,
            using=None,
            update_fields=None
        );
        Avatar changes.
        """

        for filename in ['Тестовое фото клиента.jpeg', 'test-client-foto.jpeg']:
            upload_to = get_upload_to(self.client, filename)
            expected = '/{0}{1}'.format(settings.MEDIA_URL, upload_to)
            path = settings.MEDIA_ROOT + filename
            if os.path.isfile(path):
                with open(path, 'rb') as f:
                    self.client.avatar = UploadedFile(
                        file=f,
                        name=filename
                    )
                    self.client.save()
                    actual = self.client.avatar.url
                    self.assertEqual(expected, actual)

                    # Delete file from production folder after test ends.
                    path = settings.MEDIA_ROOT + upload_to
                    if os.path.isfile(path):
                        os.remove(path)
                break

    def test_serialization(self):
        """Tests class ClientSerializer."""

        expected = {
            'id': self.data['id'],
            'first_name': self.data['first_name'],
            'last_name': self.data['last_name'],
            'email': self.data['email'],
            'gender': self.data['gender'],
            'avatar': self.data['avatar']['name'],
            'coord_x': None,
            'coord_y': None
        }
        actual = ClientSerializer(self.client).data
        self.assertEqual(expected, actual)
