from django.db import models

from dating.models.Client import Client
from dating.utils.utils import send_email


class Match(models.Model):
    """Match."""

    __orig_mutual = None

    from_id = models.OneToOneField(
        Client,
        on_delete=models.CASCADE,
        related_name='match_from',
        verbose_name='кто'
    )

    to_id = models.OneToOneField(
        Client,
        on_delete=models.CASCADE,
        related_name='match_to',
        verbose_name='кого'
    )

    is_mutually = models.BooleanField(
        default=False
    )

    def __init__(self, *args, **kwargs):
        super(Match, self).__init__(*args, **kwargs)
        self.__orig_mutual = getattr(self.is_mutually, 'name', False)

    def save(
            self,
            force_insert=False,
            force_update=False,
            using=None,
            update_fields=None
    ):
        val = getattr(self.is_mutually, 'name', self.is_mutually)
        is_mutual_changed = val != self.__orig_mutual
        super(Match, self).save(
            force_insert, force_update, using, update_fields
        )
        val = getattr(self.is_mutually, 'name', self.is_mutually)
        self.__orig_mutual = val
        if is_mutual_changed and val:
            for client in [
                [
                    self.from_id.first_name,
                    self.from_id.email,
                    self.to_id.email
                ], [
                    self.to_id.first_name,
                    self.to_id.email,
                    self.from_id.email
                ]
            ]:
                msg = 'Вы понравились {0}! Почта участника: {1}'.format(
                    client[0], client[1]
                )
                send_email('Совпадение', msg, client[1], [client[2]])

    def to_dict(self):
        d = {}
        for field in self._meta.get_fields(include_hidden=True):
            val = getattr(self, field.name, False)
            if type(val).__name__ not in ['int', 'bool']:
                val = val.__str__()
            d[field.name] = val
        return d

    def __str__(self):
        """Returns string representation."""

        s = 'Match{'
        s += ' from_id: ' + self.from_id.id.__str__()
        s += ' to_id: ' + self.to_id.id.__str__()
        s += ' is_mutually: ' + self.is_mutually.__str__()
        s += ' }'
        return s

    class Meta:
        db_table = 'matches'
        verbose_name = 'Совпадение'
        verbose_name_plural = 'Совпадения'
