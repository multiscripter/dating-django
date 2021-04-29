from django.test import TestCase

from dating.models.Client import Client

# Run TestClient from project root using unittests:
# python manage.py test dating.tests.models.testClient

# Run TestClient from project root using pytest with pytest.ini:
# pytest ./dating/tests/models/testClient.py

# Run all test in 'models' from project root using pytest with pytest.ini:
# pytest ./dating/tests/models/*


class TestClient(TestCase):
    """Tests class Client."""

    def test_str(self):
        """Tests __str__(self)"""

        data = {
            'id': 1,
            'first_name': 'Foo',
            'last_name': 'Bar'
        }
        expected = 'Client{{id:{0}, name:{1} {2}}}'.format(
            data['id'], data['last_name'], data['first_name']
        )
        client = Client(**data)
        actual = client.__str__()
        self.assertEqual(expected, actual)
