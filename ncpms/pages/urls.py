from django.urls import path
from . import views

app_name = 'pages'

urlpatterns = [
    path('', views.index, name='index'),
    path('newdata/', views.newdata, name='newdata'),
    path('newdata2', views.newdata2, name='newdata2'),
    path('map/', views.map, name='map'),
    path('map2/', views.map2, name='map2'),
    path('datas/', views.datas, name='datas'),
    path('<int:id>/datas_detail', views.datas_detail, name='datas_detail'),
    path('datas2/', views.datas2, name='datas2'),
    path('<int:id>/datas2_detail/', views.datas2_detail, name='datas2_detail'),
    path('datas3/', views.datas3, name='datas3'),
    path('datas4/', views.datas4, name='datas4'),
    path('search/', views.search, name='search')
]
