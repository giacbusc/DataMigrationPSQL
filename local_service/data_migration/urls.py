# local_service/local_service/data_migration/urls.py
from django.urls import path
from .views import insert_data

urlpatterns = [
    path('insert-data/<str:model>/', insert_data, name='insert_data'),
]
