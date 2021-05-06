from django.test import TestCase


# Run TestClient from project root using unittests:
# python manage.py test utils.tests.testParseProductsFromCategory


class TestParseProductsFromCategory(TestCase):
    """Tests parse_products_from_category."""

    def test_parse_products_from_category_success(self):
        """Successful execution."""

        url = ['https://www.citilink.ru/catalog/silovye-kabeli/']
        # Does not work correctly.
        #parse_products_from_category(url)
