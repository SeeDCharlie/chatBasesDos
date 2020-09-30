from django.shortcuts import HttpResponse, render
from django.http import JsonResponse
from rest_framework.response import Response
from rest_framework.views import APIView
from chat.models import *
from chat.serializers import c_states as sz_state
from rest_framework import permissions
from chat.permissions import IsOwnerOrReadOnly
from django.contrib.auth import authenticate, login, logout
# Create your views here.



def index(request):
    return HttpResponse('<h1>alv!! chat de la shit<h1/>')

class api_cStates(APIView):

    permission_classes = [permissions.IsAuthenticated]
                      #IsOwnerOrReadOnly]

    def get(self, request):
        states = c_states.objects.all()
        sz = sz_state(states, many = True)
        return Response(sz.data)
    
    def put(self, request):
        print('')

    def post(self, request):
        print('')


class api_login(APIView):

    def get(self, request):
        return Response({'email':'example@example.com', 'password':'secretPassword'})

    def post(self, request):
        email = request.data['email']
        passw = request.data['password']
        print('user: %s \npass :%s \ndata : %s'%(request.POST.get('email'),request.POST.get('password'), str(request.data) ) )
        user = authenticate(email = email, password = passw)
        if user is not None:
            login(request, user)
            return Response({'is_login': True})
        else:
            return Response({'is_login': False})


def logout_view(request):
    logout(request) 
    return JsonResponse({'ok':True})





