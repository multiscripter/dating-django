# Generated by Django 3.2 on 2021-04-29 10:43

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dating', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='Client',
            name='avatar',
            field=models.ImageField(default='uploads/avatars/no-photo.png', height_field='avatar_height', upload_to='uploads/avatars/', width_field='avatar_width'),
        ),
    ]
