from django.db import models


class Category(models.Model):
    """Category."""

    name = models.CharField(
        max_length=64,
        verbose_name='категория'
    )

    parent = models.ForeignKey(
        "self",
        blank=True,
        default=None,
        null=True,
        on_delete=models.DO_NOTHING
    )

    def __str__(self):
        """Returns string representation."""

        s = 'Category{'
        s += ' id: ' + self.id.__str__()
        s += ' name: ' + self.name.__str__()
        s += ' }'
        return s

    class Meta:
        db_table = 'categories'
        verbose_name = 'Категория'
        verbose_name_plural = 'Категории'
