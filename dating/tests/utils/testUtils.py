from django.test import TestCase
from unittest.mock import patch
from dating.utils.Mailer import Mailer


# Run TestClient from project root using unittests:
# python manage.py test dating.tests.utils.testUtils

class TestUtils(TestCase):
    """Test utils."""

    @patch('django.core.mail.send_mail')
    def test_send_email(self, mocked_send_mail):
        mocked_send_mail.side_effect = Exception('Connection refused')
        with patch(
                'dating.utils.Mailer.Mailer.func',
                new=mocked_send_mail
        ):
            mailer = Mailer()
            self.assertEqual(-1, mailer.send('a', 'a', 'a', ['a']))
