from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.parsers import JSONParser
from chat.models import *
from chat.serializers import c_states as sz_state
from rest_framework import permissions
from chat.permissions import IsOwnerOrReadOnly
# Create your views here.



def index(request):
    return HttpResponse('<h1>alv!! chat de la shit<h1/>')

class api_cStates(APIView):

    permission_classes = [permissions.IsAuthenticatedOrReadOnly,
                      IsOwnerOrReadOnly]

    def get(self, request):
        states = c_states.objects.all()
        sz = sz_state(states, many = True)
        return Response(sz.data)






