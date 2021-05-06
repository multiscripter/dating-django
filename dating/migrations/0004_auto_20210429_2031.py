# Generated by Django 3.2 on 2021-04-29 20:31

import utils.utils
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('dating', '0003_alter_user_avatar'),
    ]

    operations = [
        migrations.AlterField(
            model_name='client',
            name='avatar',
            field=models.ImageField(default='avatars/no-photo.png', upload_to=utils.utils.get_upload_to, verbose_name='файл аватара'),
        ),
        migrations.AlterField(
            model_name='client',
            name='email',
            field=models.EmailField(max_length=254, verbose_name='э-почта'),
        ),
        migrations.AlterField(
            model_name='client',
            name='first_name',
            field=models.CharField(max_length=32, verbose_name='имя'),
        ),
        migrations.AlterField(
            model_name='client',
            name='gender',
            field=models.CharField(choices=[('1', 'Male'), ('2', 'Female')], max_length=2, verbose_name='пол'),
        ),
        migrations.AlterField(
            model_name='client',
            name='id',
            field=models.AutoField(primary_key=True, serialize=False, verbose_name='ИД'),
        ),
        migrations.AlterField(
            model_name='client',
            name='last_name',
            field=models.CharField(max_length=32, verbose_name='фамилия'),
        ),
        migrations.CreateModel(
            name='Match',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_mutually', models.BooleanField(default=False)),
                ('from_id', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='match_from', to='dating.client', verbose_name='кто')),
                ('to_id', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='match_to', to='dating.client', verbose_name='кого')),
            ],
            options={
                'verbose_name': 'Совпадение',
                'verbose_name_plural': 'Совпадения',
                'db_table': 'matches',
            },
        ),
    ]
