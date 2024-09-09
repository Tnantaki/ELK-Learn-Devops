from django.db import models

class Person(models.Model):
  name = models.CharField(max_length=100)
  game_plays = models.IntegerField(default=0)
  wines = models.IntegerField(default=0)
  losses = models.IntegerField(default=0)
  updated = models.DateTimeField(auto_now=True)

  def __str__(self):
    return self.name
