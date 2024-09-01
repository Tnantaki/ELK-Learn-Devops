from django.shortcuts import render
from django.http import HttpResponse
from myapp.models import Person

def index(request):
  all_person = Person.objects.all()
  return render(request, "index.html", {'all_person': all_person})
