from django.db import models
from django.contrib.auth.models import AbstractUser

def get_default_user():
    user = User.objects.get(username='Juvern')
    return user.pk

class muscleGroup(models.Model):
    name = models.CharField(max_length=100)
    def __str__(self):
        return self.name

class exerciseType(models.Model):
    name = models.CharField(max_length=100)
    def __str__(self):
        return self.name

class Equipment(models.Model):
    name = models.CharField(max_length=100)
    def __str__(self):
        return self.name

class Video(models.Model):
    name = models.CharField(max_length=100)
    url = models.FileField(upload_to='videos_uploaded', null = True)
    muscles = models.ManyToManyField(muscleGroup, related_name='videoMuscle')
    equipment = models.ManyToManyField(Equipment, related_name='videoEquipment', blank = True)
    type = models.ManyToManyField(exerciseType, related_name='videos')
    description = models.TextField(null = True, blank=True)
    dangerous = models.ManyToManyField(muscleGroup, related_name='videoDanger', blank = True)
    def __str__(self):
        return self.name
 
class PlaylistVideo(models.Model):
    playlist = models.ForeignKey('PlayLists', on_delete=models.CASCADE)
    video = models.ForeignKey(Video, on_delete=models.CASCADE)
    order = models.IntegerField()

class PlayLists(models.Model):
    name = models.CharField(max_length=100)
    exercises = models.ManyToManyField(PlaylistVideo, related_name='exerciseVideos')
    user = models.ForeignKey('User', on_delete=models.CASCADE, related_name='userPlaylists', default=get_default_user)
    def __str__(self):
        return self.name

class User(AbstractUser):
    datebirth = models.DateField(null=True, blank=True)
    injuries = models.ManyToManyField(muscleGroup, related_name="injuries", blank = True, null=True)
    playlists = models.ManyToManyField(PlayLists, related_name='workoutPlaylists')
    def __str__(self):
        return self.username
