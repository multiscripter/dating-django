from django.test import TestCase

from dating.models.Client import Client
from dating.models.Match import Match

# Run TestClient from project root using unittests:
# python manage.py test dating.tests.models.testMatch


class TestMatch(TestCase):
    """Tests class Match."""

    def setUp(self):
        """Actions before each test."""

        client_m = Client()
        client_m.first_name = 'John'
        client_m.last_name = 'Doe'
        client_m.email = 'JohnDoe@mail.ru'
        client_m.gender = Client.Gender.MALE.value
        client_m.save()

        client_f = Client()
        client_f.first_name = 'Jane'
        client_f.last_name = 'Doe'
        client_f.email = 'JaneDoe@mail.ru'
        client_f.gender = Client.Gender.FEMALE.value
        client_f.save()

        self.data = {
            'from_id': client_m,
            'to_id': client_f
        }
        self.match = Match(**self.data)
        self.match.save()

    def test_to_dict(self):
        """Tests to_dict(self)."""

        expected = {
            'id': self.match.id,
            'from_id': self.data['from_id'].__str__(),
            'to_id': self.data['to_id'].__str__(),
            'is_mutually': False
        }
        actual = self.match.to_dict()
        self.assertEqual(expected, actual)

    def test_str(self):
        """Tests __str__(self)."""

        expected = 'Match{'
        expected += ' from_id: ' + self.data['from_id'].id.__str__()
        expected += ' to_id: ' + self.data['to_id'].id.__str__()
        expected += ' is_mutually: ' + self.match.is_mutually.__str__()
        expected += ' }'

        actual = self.match.__str__()
        self.assertEqual(expected, actual)

    def test_save_mutual_changed(self):
        """Tests save(
            self,
            force_insert=False,
            force_update=False,
            using=None,
            update_fields=None
        );
        is_mutual changes."""

        self.match.is_mutually = True
        self.match.save()
        self.assertTrue(self.match.is_mutually)
