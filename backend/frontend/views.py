from django.contrib.auth import login, authenticate, logout
from django.shortcuts import render, get_object_or_404
from django.http import JsonResponse
from django.conf import settings
from .models import Video, User, muscleGroup, PlayLists, PlaylistVideo
from django import forms
from typing import Any, Dict, List, Optional
import json
import os, openai
from django.http import HttpResponse
from openai import OpenAI
from django.db.models.functions import Lower

from django.http import JsonResponse

def index(request):
    return render(request, 'frontend/index.html')

class SignupForm(forms.ModelForm):
    password1 = forms.CharField(label='Password', widget=forms.PasswordInput)
    password2 = forms.CharField(label='Confirm Password', widget=forms.PasswordInput)

    class Meta:
        model = User
        fields = ['username', 'email']

    def clean_password2(self) -> Optional[str]:
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and password1 != password2:
            raise forms.ValidationError("Passwords do not match.")
        return password2

def getAllVideos(request):
    videos = Video.objects.all().order_by(Lower('name'))
    
    videoData = []
    
    for video in videos:
        dangerous_names = [danger.name for danger in video.dangerous.all()]
        videoData.append({
            'id': video.pk,
            'title': video.name,
            'url': str(os.path.basename(video.url.path)),
            'desc': video.description,
            'danger': ', '.join(dangerous_names)
        })
        
    return JsonResponse({'videos': videoData})


def get_videos_for_muscles(request, muscles):
    muscleList = muscles.split(',')
    
    videos = Video.objects.all()
    videos = videos.filter(muscles__name__in=muscleList).distinct()
    
    videoData = []
    for video in videos:
        dangerous_names = [danger.name for danger in video.dangerous.all()]
        videoData.append({
            'id': video.pk,
            'title': video.name,
            'url': str(os.path.basename(video.url.path)),
            'desc': video.description,
            'danger': ', '.join(dangerous_names)
        })
        
    return JsonResponse({'videos': videoData})

def user_select_video(request, id, username, i=0):
    if i == 5:
        return JsonResponse({'success': 'False'})
    video = Video.objects.get(pk = id)

    try:
        user = User.objects.get(username=username)
    except User.DoesNotExist:
        return JsonResponse({'success': False, 'error': 'User not found'})
    
    if not user.is_authenticated:
        return JsonResponse({'success': False, 'error': 'User not authenticated'})
    
    serialized_injuries = list(user.injuries.values_list('name', flat=True))
    related_videos = Video.objects.filter(muscles__in=video.muscles.all()).exclude(dangerous__name__in=serialized_injuries)
    injury_list = ', '.join(serialized_injuries)
  
    prompt = f"Select the name of a video from the database with the same muscle as '{video.name}' but without any dangerous exercises. Related videos include:"
    for related_video in related_videos:
        prompt += f"\n- {related_video.name}"

    client = OpenAI(api_key = "sk-proj-S7pVNElk5izl5OpmFeRgT3BlbkFJwj9RRhTwM3MvyobjUa5E")

    response = client.chat.completions.create(
        model = "gpt-3.5-turbo",
        messages = [{
            "role": "user",
            "content": prompt,
        }],
        n = 1,
    )

    print(response.choices[0].message)
    selected_video_title = response.choices[0].message.content

    prompt2 = f"Give a short explaination (less than 50 words) why '{selected_video_title}' is good for people with {injury_list} injuries"

    selected_video = related_videos.filter(name=selected_video_title).first()

    response2 = client.chat.completions.create(
        model = "gpt-3.5-turbo",
        messages = [{
            "role": "user",
            "content": prompt2,
        }],
        max_tokens = 100,
    )
    
    try:
        videoData = {
            'id': video.pk,
            'title': video.name,
            'url': str(os.path.basename(video.url.path)),
            'desc': video.description,
            'danger': ', '.join(serialized_injuries),
            'AIText': response2.choices[0].message.content,
            'recExercise': str(os.path.basename(selected_video.url.path)),
        }

    except Exception:
        i += 1
        return select_video(request, id, i)

    return JsonResponse({'success': 'True','video': videoData})

def select_video(request, id, i=0):
    if i == 5:
        return JsonResponse({'success': 'False'})
    
    video = Video.objects.get(pk = id)
    dangerous_names = [danger.name for danger in video.dangerous.all()]
    dangerous_muscles = ', '.join(dangerous_names)

    related_videos = Video.objects.filter(muscles__in=video.muscles.all()).exclude(dangerous__name__in=dangerous_names)
  
    prompt = f"Select the name of a video from the database with the same muscle as '{video.name}' but without any dangerous exercises. Related videos include:"
    for related_video in related_videos:
        prompt += f"\n- {related_video.name}"

    client = OpenAI(api_key = "sk-proj-S7pVNElk5izl5OpmFeRgT3BlbkFJwj9RRhTwM3MvyobjUa5E")

    response = client.chat.completions.create(
        model = "gpt-3.5-turbo",
        messages = [{
            "role": "user",
            "content": prompt,
        }],
        n = 1,
    )
    
    print(response.choices[0].message)
    selected_video_title = response.choices[0].message.content

    prompt2 = f"Give a short explaination (less than 50 words) why'{selected_video_title}' is good for people with {dangerous_muscles} injuries"

    selected_video = related_videos.filter(name=selected_video_title).first()

    response2 = client.chat.completions.create(
        model = "gpt-3.5-turbo",
        messages = [{
            "role": "user",
            "content": prompt2,
        }],
        max_tokens = 100,
    )

    try:
        videoData = {
            'id': video.pk,
            'title': video.name,
            'url': str(os.path.basename(video.url.path)),
            'desc': video.description,
            'danger': ', '.join(dangerous_names),
            'AIText': response2.choices[0].message.content,
            'recExercise': str(os.path.basename(selected_video.url.path)),
            'recID': selected_video.pk,
        }
    except Exception:
        i += 1
        return select_video(request, id, i)

    return JsonResponse({'success': 'True','video': videoData})

def signup(request):
    data = json.loads(request.body)
    username = data.get('username', '')
    email = data.get('email', '')
    password1 = data.get('password1', '')
    password2 = data.get('password2', '')
    print(username)

    if User.objects.filter(username=username).exists():
        print(f"Username '{username}' is already taken.")
        return JsonResponse({'success': False, 'errors': {'username': ['A user with that username already exists.']}, 'message': 'error'})

    form_data = {
        'username': username,
        'email': email,
        'password1': password1,
        'password2': password2  
    }
    form = SignupForm(form_data)
    if form.is_valid():
        user = User.objects.create_user(username=username, password='', email=email)
        user.set_password(form.cleaned_data['password1'])
        if user.is_authenticated:
            login(request, user)
        user.save()
        serialized_injuries = list(user.injuries.values_list('name', flat=True))
        return JsonResponse({'success': 'True', 'user': {'username': user.username, 'email': user.email, 'injuries': serialized_injuries ,'datebirth': user.datebirth.strftime('%Y-%m-%d') if user.datebirth else None}})
    else:
        return JsonResponse({'success': 'False', 'error': form.errors})

def signin(request):
    data = json.loads(request.body)
    
    username = data.get('username', '')
    password = data.get('password', '')

    user = authenticate(request, username=username, password=password)
    if user is not None:
        user = User.objects.get(username=username)
        try:
            login(request, user)
            serialized_injuries = list(user.injuries.values_list('name', flat=True))
            return JsonResponse({'success': 'True', 'user': {'username': user.username, 'email': user.email, 'injuries': serialized_injuries ,'datebirth': user.datebirth.strftime('%Y-%m-%d') if user.datebirth else None}})
        except Exception as e:
            return JsonResponse({'success': 'False', 'error': e})
    else:
        return JsonResponse({'success': 'False', 'error': 'Incorrect username and/or password'})
    
def logout(request):
    try:
        logout(request)
        return JsonResponse({'success': 'True'})
    except Exception:
        return JsonResponse({'success': False})
        
def updateUser(request):
    data = json.loads(request.body)
    username = data.get('username')
    newUsername = data.get('newUsername')
    password = data.get('password')
    injury_names = [injury['title'] for injury in data.get('injuries', [])]
    print(injury_names)
    
    if User.objects.filter(username=newUsername).exists():
        return JsonResponse({'success': False, 'errors': {'username': ['A user with that username already exists.']}, 'message': 'error'})

    try:
        user = User.objects.get(username=username)
    except User.DoesNotExist:
        return JsonResponse({'success': False, 'error': 'User not found'})
    
    if not user.is_authenticated:
        return JsonResponse({'success': False, 'error': 'User not authenticated'})
    
    if newUsername:
        user.username = newUsername
    if password:
        user.set_password(password)
    
    if injury_names:
        injuries = muscleGroup.objects.filter(name__in=injury_names)
        print(injuries)
        user.injuries.clear()
        user.injuries.add(*injuries)

    user.save()
    
    serialized_injuries = list(user.injuries.values_list('name', flat=True))

    return JsonResponse({'success': 'True', 'user': {'username': user.username, 'email': user.email, 'injuries': serialized_injuries ,'datebirth': user.datebirth.strftime('%Y-%m-%d') if user.datebirth else None}})

def addtoPlaylist(request, playlistname, username, videoID):
    try:
        user = User.objects.get(username=username)
    except User.DoesNotExist:
        return JsonResponse({'success': False, 'error': 'User not found'})
    
    if not user.is_authenticated:
        return JsonResponse({'success': False, 'error': 'User not authenticated'})
    
    try:
        playlist = PlayLists.objects.get(name=playlistname, user = user)
    except PlayLists.DoesNotExist:
        return JsonResponse({'success': False, 'error': 'Playlist not found'})
    
    try:
        video = Video.objects.get(pk=videoID)
    except Video.DoesNotExist:
        return JsonResponse({'success': False, 'error': 'Video not found'})
    
    ordernumber = playlist.playlistvideo_set.count() + 1

    playlistVideo, created = PlaylistVideo.objects.get_or_create(playlist=playlist, video=video, order=ordernumber)
    
    playlist.exercises.add(playlistVideo)
    
    return JsonResponse({'success': 'True', 'message': 'Video added to playlist successfully'})

def removefromPlaylist(request, playlistname, username, order):
    try: user = User.objects.get(username=username)
    except User.DoesNotExist: return JsonResponse({'success': False, 'error': 'User not found'})
    if not user.is_authenticated: return JsonResponse({'success': False, 'error': 'User not authenticated'})
    print(playlistname +" "+ str(order))

    try:
        userplaylist = PlayLists.objects.get(name=playlistname, user = user)
    except PlayLists.DoesNotExist:
        return JsonResponse({'success': False, 'error': 'Playlist not found'})
    
    playlist_video_to_delete = userplaylist.playlistvideo_set.get(order=order)
    
    playlist_video_to_delete.delete()
    
    videos_to_update = userplaylist.playlistvideo_set.filter(order__gt=order)
    
    for playlist_video in videos_to_update:
        playlist_video.order -= 1
        playlist_video.save()
    
    return JsonResponse({'success': 'True', 'message': 'Video deleted from playlist successfully'})

def addnewPlaylist(request, username, name):
    try: user = User.objects.get(username=username)
    except User.DoesNotExist: return JsonResponse({'success': False, 'error': 'User not found'})
    if not user.is_authenticated: return JsonResponse({'success': False, 'error': 'User not authenticated'})

    if PlayLists.objects.filter(name=username, user = user).exists():
        return JsonResponse({'success': False, 'error': {'username': ['A playlist with that name already exists.']}, 'message': 'error'})

    user.playlists.create(name = name, user = user)
    return JsonResponse({'success': 'True', 'message': 'Playlist Created'})

def removePlaylist(request, username, name):
    try:
        user = User.objects.get(username=username)
    except User.DoesNotExist:
        return JsonResponse({'success': False, 'error': 'User not found'})

    if not user.is_authenticated:
        return JsonResponse({'success': False, 'error': 'User not authenticated'})

    try:
        playlist = PlayLists.objects.get(name=name, user = user) 
    except PlayLists.DoesNotExist:
        return JsonResponse({'success': False, 'error': 'Playlist not found'})

    user.playlists.remove(playlist) 

    return JsonResponse({'success': 'True', 'message': 'Playlist Removed'})

def getPlaylist(request, username):
    try:
        user = User.objects.get(username=username)
    except User.DoesNotExist:
        return JsonResponse({'success': False, 'error': 'User not found'})
    
    if not user.is_authenticated:
        return JsonResponse({'success': False, 'error': 'User not authenticated'})
    
    userplaylists = PlayLists.objects.filter(user = user)
    
    playlistData = []
    for playlist in userplaylists:
        try:
            playlist_video = PlaylistVideo.objects.filter(playlist=playlist).first()
            if playlist_video:
                playlistData.append({
                    'name': playlist.name,
                    'url': os.path.basename(playlist_video.video.url.path),
                })
            else:
                playlistData.append({
                    'name': playlist.name,
                    'url': None,
                })
        except PlaylistVideo.DoesNotExist:
            print("hello")

    return JsonResponse({'videos': playlistData})

def selectPlaylist(request, playlistname, username):
    try: user = User.objects.get(username=username)
    except User.DoesNotExist: return JsonResponse({'success': 'False', 'error': 'User not found'})
    if not user.is_authenticated: return JsonResponse({'success': 'False', 'error': 'User not authenticated'})

    playlist = PlayLists.objects.get(name = playlistname, user = user)
    
    playlist_videos = []

    for playlist_video in playlist.playlistvideo_set.order_by('order'):
        video = playlist_video.video
        playlist_videos.append({
            'id': playlist_video.pk,
            'name': video.name,
            'url': os.path.basename(video.url.path) if video.url else None,
            'muscles': [muscle.name for muscle in video.muscles.all()],
            'equipment': [equipment.name for equipment in video.equipment.all()],
            'type': [exercise_type.name for exercise_type in video.type.all()],
            'description': video.description,
            'dangerous': [danger.name for danger in video.dangerous.all()],
            'order': playlist_video.order
        })

    return JsonResponse({'success': 'True','videos': playlist_videos})

def updatePlaylistOrder(request, playlistname, username):
    data1 = json.loads(request.body)
    data = data1.get('orders', [])
    try:
        user = User.objects.get(username=username)
    except User.DoesNotExist:
        return JsonResponse({'success': False, 'error': 'User not found'})
    
    if not user.is_authenticated:
        return JsonResponse({'success': False, 'error': 'User not authenticated'})

    try:
        userplaylist = PlayLists.objects.get(name=playlistname, user = user)
    except PlayLists.DoesNotExist:
        return JsonResponse({'success': False, 'error': 'Playlist not found'})

    for video in data:
        try:
            playlist_video = PlaylistVideo.objects.get(pk=video['id'], playlist=userplaylist)
            playlist_video.order = video['order']
            playlist_video.save()
        except PlaylistVideo.DoesNotExist:
            return JsonResponse({'success': False, 'error': 'Playlist video not found'})

    return JsonResponse({'success': 'True', 'message': 'Playlist order updated successfully'})