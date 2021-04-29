from django.contrib import admin

from dating.models.Client import Client
from dating.models.Match import Match


class ClientList(admin.ModelAdmin):
    list_display = ('id', 'last_name', 'first_name')
    list_display_links = ['last_name', 'first_name']
    ordering = ['id']
    readonly_fields = ('image_tag',)


class MatchList(admin.ModelAdmin):
    list_display = ('id', 'from_id', 'to_id', 'is_mutually')
    ordering = ['id']


admin.site.register(Client, ClientList)
admin.site.register(Match, MatchList)
