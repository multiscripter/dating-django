from django.db import models
from django.utils.html import format_html
from django.utils.translation import gettext_lazy as _

from base import settings
from dating.utils.utils import get_upload_to, add_watermark_to_image


class Client(models.Model):
    """Client."""

    __orig = None
    upload_dir = 'avatars/'

    id = models.AutoField(
        primary_key=True,
        verbose_name='ИД'
    )

    first_name = models.CharField(
        max_length=32,
        verbose_name='имя'
    )

    last_name = models.CharField(
        max_length=32,
        verbose_name='фамилия'
    )

    email = models.EmailField(
        max_length=254,
        verbose_name='э-почта'
    )

    class Gender(models.TextChoices):
        MALE = 1, _('Male'),
        FEMALE = 2, _('Female')

    gender = models.CharField(
        max_length=2,
        choices=Gender.choices,
        verbose_name='пол'
    )

    avatar = models.ImageField(
        upload_to=get_upload_to,
        default='avatars/no-photo.png',
        verbose_name='файл аватара'
    )

    def __init__(self, *args, **kwargs):
        super(Client, self).__init__(*args, **kwargs)
        self.__orig = self.avatar.name

    def image_tag(self):
        return format_html(
            '<img src="{0}" style="width: 50px; height:75px;" />'.format(
                self.avatar.url
            )
        )

    image_tag.short_description = 'аватар'
    image_tag.allow_tags = True

    def save(
            self,
            force_insert=False,
            force_update=False,
            using=None,
            update_fields=None
    ):
        is_avatar_changed = self.avatar.name != self.__orig

        super(Client, self).save(
            force_insert, force_update, using, update_fields
        )
        self.__orig = self.avatar.name
        if is_avatar_changed:
            watermark = settings.STATIC_ROOT + '/watermark.png'
            add_watermark_to_image(
                self.avatar.path,
                self.avatar.path,
                watermark
            )

    def to_dict(self):
        d = {}
        for field in self._meta.get_fields(include_hidden=True):
            d[field.name] = self.__getattribute__(field.name).__str__()
        return d

    def __str__(self):
        """Returns string representation."""

        s = 'Client{'
        s += ' id: ' + self.id.__str__()
        s += ' first_name: ' + self.first_name.__str__()
        s += ' last_name: ' + self.last_name.__str__()
        s += ' email: ' + self.email.__str__()
        s += ' gender: ' + self.gender.__str__()
        s += ' avatar: ' + self.avatar.__str__()
        return s

    class Meta:
        db_table = 'users'
        verbose_name = 'Участник'
        verbose_name_plural = 'Участники'
