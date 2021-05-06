import os

from django.db import models
from django.utils.html import format_html

from base import settings
from utils.utils import get_upload_to
from products.models.Category import Category


class Product(models.Model):
    """Product."""

    default_image = 'no-photo.png'
    upload_dir = 'products/'

    name = models.CharField(
        max_length=128,
        verbose_name='название'
    )

    category = models.ForeignKey(
        Category,
        on_delete=models.DO_NOTHING
    )

    price = models.DecimalField(
        decimal_places=2,
        max_digits=8,
        verbose_name='цена'
    )

    image = models.ImageField(
        blank=True,
        default=default_image,
        null=True,
        upload_to=get_upload_to,
        verbose_name='файл изображения'
    )

    def delete(self, using=None, keep_parents=False):
        if self.image.name != self.default_image:
            file = '{0}{1}'.format(settings.BASE_DIR, self.image.url)
            if os.path.exists(file):
                os.remove(file)
        super(Product, self).delete()

    def image_tag(self):
        return format_html(
            '<img src="{0}" style="height:75px;" />'.format(
                self.image.url
            )
        )

    image_tag.short_description = 'изображение'
    image_tag.allow_tags = True

    class Meta:
        db_table = 'products'
        verbose_name = 'Товар'
        verbose_name_plural = 'Товары'
