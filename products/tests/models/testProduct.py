import os
import pathlib

from django.core.files.uploadedfile import UploadedFile
from django.test import TestCase

from base import settings
from utils.utils import transliterate_filename
from products.models.Category import Category
from products.models.Product import Product

# Run all tests from project root using unittests:
# coverage erase
# coverage run manage.py test
# coverage html

# Run TestClient from project root using unittests:
# python manage.py test products.tests.models.testProduct


class TestProduct(TestCase):
    """Tests class Product."""

    def setUp(self):
        """Actions before each test."""

        self.cat_root = Category(name='Строительство и ремонт')
        self.cat_root.save()

        self.filename = 'Кабель ЭлПроКабель ВВГП-нг(А) LS 3x1.5мм2 50м ГОСТ медь черный.jpg'
        path = '{0}/{1}'.format(
            pathlib.Path(__file__).parent.absolute(),
            self.filename
        )
        f = open(path, 'rb')
        self.image = UploadedFile(
            file=f,
            name=self.filename
        )
        self.product = Product(
            name='Кабель ЭлПроКабель ВВГП-нг(А) LS 3x1.5мм2 50м ГОСТ медь черный',
            category=self.cat_root,
            price=2470,
            image=self.image
        )
        self.trans_filename = '{0}{1}'.format(
            self.product.upload_dir,
            transliterate_filename(self.filename)
        )

    def test_creation(self):
        """Tests creation."""

        cat_1 = Category(name='Электрика', parent=self.cat_root)
        cat_1.save()
        self.product.category = cat_1
        self.product.save()

        self.assertTrue(self.product.id > 0)
        self.assertEqual(self.trans_filename, self.product.image)

        file = '{0}{1}'.format(
            settings.MEDIA_ROOT,
            self.trans_filename
        )
        if os.path.exists(file):
            os.remove(file)

    def test_delete(self):
        """Tests delete(self, using=None, keep_parents=False)."""

        self.product.save()
        product_id = self.product.id
        self.product.delete()
        self.assertEqual(0, len(Product.objects.filter(id=product_id)))

    def test_image_tag(self):
        """Tests image_tag(self)."""

        self.product.save()
        expected = '<img src="/'
        expected += settings.MEDIA_URL
        expected += self.trans_filename
        expected += '" style="height:75px;" />'
        actual = self.product.image_tag()
        self.assertEqual(expected, actual)

        self.product.delete()

