from django.db import models

from dating.models.Client import Client


class Match(models.Model):
    """Match."""

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

    def __str__(self):
        """Returns string representation."""

        s = 'Match{'
        s += ' from_id: ' + self.from_id.__str__()
        s += ' to_id: ' + self.to_id.__str__()
        s += ' is_mutually: ' + self.is_mutually.__str__()
        return s

    class Meta:
        db_table = 'matches'
        verbose_name = 'Совпадение'
        verbose_name_plural = 'Совпадения'
