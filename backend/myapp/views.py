from django.shortcuts import render
from django.http import HttpResponse
from myapp.models import Person
import pytz


def index(request):
  all_person = Person.objects.order_by('id')
  # tz = pytz.timezone('Asia/Bangkok')

  # for person in all_person:
  #   person.updated = person.updated.astimezone(tz)

  return render(request, "index.html", {'all_person': all_person})
