from chat.models import *
from rest_framework import serializers

class c_states(serializers.ModelSerializer):
    
    class Meta:
        model = c_states
        fields = '__all__'

