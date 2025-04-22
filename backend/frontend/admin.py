from django.contrib import admin
from . models import Video, exerciseType, muscleGroup, Equipment, User, PlayLists,PlaylistVideo

admin.site.register(Video)
admin.site.register(exerciseType)
admin.site.register(muscleGroup)
admin.site.register(Equipment)
admin.site.register(User)
admin.site.register(PlaylistVideo)
admin.site.register(PlayLists)

# Register your models here.
