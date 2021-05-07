# Generated by Django 3.2 on 2021-05-07 12:03

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('dating', '0006_alter_client_avatar'),
    ]

    operations = [
        migrations.AlterField(
            model_name='match',
            name='from_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='match_from', to='dating.client', verbose_name='кто'),
        ),
        migrations.AlterField(
            model_name='match',
            name='to_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='match_to', to='dating.client', verbose_name='кого'),
        ),
    ]
