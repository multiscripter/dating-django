from django.conf.urls.static import static
from django.urls import path

from base import settings
from . import views
from .controllers import client, match

urlpatterns = [
    path('', views.index, name='index'),
    path('api/clients/create', client.create),
    path('api/clients/<int:from_id>/match', match.create),
    path('api/list', client.get_list)
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
