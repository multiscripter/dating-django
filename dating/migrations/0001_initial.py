# Generated by Django 3.2 on 2021-04-29 09:20

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Client',
            fields=[
                ('id', models.SmallAutoField(primary_key=True, serialize=False, verbose_name='ИД')),
                ('first_name', models.CharField(max_length=32)),
                ('last_name', models.CharField(max_length=32)),
                ('email', models.EmailField(max_length=254)),
                ('gender', models.CharField(choices=[('1', 'Male'), ('2', 'Female')], max_length=2)),
            ],
            options={
                'verbose_name': 'Участник',
                'verbose_name_plural': 'Участники',
                'db_table': 'users',
            },
        ),
    ]