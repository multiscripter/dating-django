from django.test import TestCase

from products.models.Category import Category

# Run TestClient from project root using unittests:
# python manage.py test products.tests.models.testCategory


class TestCategory(TestCase):
    """Tests class Category."""

    def setUp(self):
        """Actions before each test."""

        self.category = Category(name='Электрика')
        self.category.save()

    def test_relations(self):
        """Tests relations."""

        children = Category.objects.bulk_create([
            Category(name='Силовые кабели', parent=self.category),
            Category(name='Гофрированные трубы', parent=self.category)
        ])
        self.assertEqual(self.category.name, children[0].parent.name)
        self.assertEqual(
            set(children),
            set(c for c in Category.objects.filter(parent__id=self.category.id))
        )

    def test_str(self):
        """Tests __str__(self)."""

        expected = 'Category{'
        expected += ' id: ' + self.category.id.__str__()
        expected += ' name: ' + self.category.name.__str__()
        expected += ' }'

        actual = self.category.__str__()
        self.assertEqual(expected, actual)
