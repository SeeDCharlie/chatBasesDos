from django.urls import path, include
from chat.views import *


urlpatterns = [
    path('', index, name = 'index'),
    path('estados/', api_cStates.as_view(), name = 'getStates'),
    path('loggin/', include('rest_framework.urls')),
]