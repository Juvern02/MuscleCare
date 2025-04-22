from django.urls import path
from django.conf.urls.static import static
from django.conf import settings
from .views import index, get_videos_for_muscles, select_video, signin, signup, logout, updateUser, user_select_video, addnewPlaylist, addtoPlaylist, removePlaylist, removefromPlaylist, getPlaylist, selectPlaylist, getAllVideos, updatePlaylistOrder

urlpatterns = ([
    path('', index, name='index'),
    path('get_all_videos', getAllVideos, name='getallvids'),
    path('get_videos_for_muscles/<muscles>', get_videos_for_muscles, name='get_videos_for_muscles'),
    path('get_video/<int:id>', select_video, name='select_video'),
    path('signup/', signup, name='signup'),
    path('signin/', signin, name='signin'),
    path('logout/', logout, name='logout'),
    path('update_user/', updateUser, name='update_user'),
    path('select_user_video/<int:id>/<username>', user_select_video, name='select_user_video'),
    path('add_playlist/<username>/<name>', addnewPlaylist, name='addPlaylist'),
    path('add_to_playlist/<playlistname>/<username>/<int:videoID>', addtoPlaylist, name='addtoPlaylist'),
    path('remove_playlist/<username>/<name>', removePlaylist, name = 'removePlaylist'),
    path('remove_from_playlist/<playlistname>/<username>/<int:order>', removefromPlaylist, name='removeFromPlaylist'),
    path('getPlaylist/<username>', getPlaylist, name='getPlaylists'),
    path('selectPlaylist/<playlistname>/<username>', selectPlaylist, name='selectPlayList'),
    path('update_playlist_order/<playlistname>/<username>', updatePlaylistOrder, name='updateOrder')
]
    + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
    + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
)
