   M S B A M L   `   `   `  ����C  ?OlimpSet, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null#clr-namespace:OlimpSetOlimpSet  5          OlimpSet.FMain   5      \ XPresentationFramework, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      8x,http://schemas.microsoft.com/winfx/2006/xaml    5      &localclr-namespace:OlimpSet    5        � Title$+  %Олимпийская посадка��5       � WindowState$ 	Maximized=�5       � 	Resources 5       �� DataType �� Color   OlimpSet.TRoom � RowDefinitions � ColumnDefinitions �� UpdateSourceTrigger   tmpRoomInList �� Orientation   OlimpSet.TLevel   OlimpSet.TPers  tmpPersInList	 � ToolTip
 �� CornerRadius   OlimpSet.TTable �� Path �� TargetNullValue   OlimpSet.TSetting m� Command �� Triggers �� Binding �� Value �� Property �� Value �� SelectedItem��%�   (��       5	      *,��+)(�� �     5      *, +)&	  �    (�� 
    5W      *, +)&	 j    (�� m    5{      *, +)(�� �    5�      *, +)(�� �    5�      *, +)7   7  �� 5	   
   " ��6   .R�5
      �� $��2q�6   
���   �$��1q�64   ��5      �� 5       6&   �� ._�5      �� $��4q�6   
���   �$��Center=�6:   $��Center=�6W   ��6r   �� 5      5      �� 5   
   "  6   .R�5      � $��4q�6    5      �� 5      $
��Auto �6$   �� 5      �� 5      �� 5      �� 5      �� 5       5      �� 5      �� 5      �� 5      .+�5!      � $��0��6   $��0��6$   $��3��64   $��4q�6H    5"      �� 5#      $
��Auto �6(   �� 5$      $
��Auto �6(    5&      �� 5'      $
��Auto �6+   �� 5(      .+�5+      �� $��0��6    $��0��60   $��2q�6=   $��Center=�6H   $��Кабинет №��6c   �� 5,      $��0��6    $��1��60   $��2q�6=   $��Center=�6H   $��Смотрящий��6c   �� 5-      $��1��6   $��0��6.   $��2q�6;   ��6F   �� *	NumRoom+$ PropertyChanged=��� 5.      $��1��6   $��1��6.   $��2q�6;   ��6F   �� *Boss+$ PropertyChanged=�5/      �� 51      $��0��6!   $��1��61   ��6>   �� *[0]+�� 52      $��1��6!   $��1��61   ��6>   �� *[1]+�� 53      $��2��6!   $��1��61   ��6>   �� *[2]+�� 55      $��0��6!   $��2��61   ��6>   �� *[3]+�� 56      $��1��6!   $��2��61   ��6>   �� *[4]+�� 57      $��2��6!   $��2��61   ��6>   �� *[5]+�� 59      $��0��6!   $��3��61   ��6>   �� *[6]+�� 5:      $��1��6!   $��3��61   ��6>   �� *[7]+�� 5;      $��2��6!   $��3��61   ��6>   �� *[8]+�� 5=      $��0��6!   $��4��61   ��6>   �� *[9]+�� 5>      $��1��6!   $��4��61   ��6>   �� *[10]+�� 5?      $��2��6!   $��4��61   ��6>   �� *[11]+�� 5A      $��0��6!   $��5��61   ��6>   �� *[12]+�� 5B      $��1��6!   $��5��61   ��6>   �� *[13]+�� 5C      $��2��6!   $��5��61   ��6>   �� *[14]+5D      5E      �� 5F   
   "  6   .R�5G      �� $��2q�6   
���   �$��1q�64   
�������._�5H      �� 
���   �.+�5I      �� $��2q�6!   $ 
Horizontal=�6,   $
��Bold"�6E   .+�5J      �� $��Кабинет №��6$   �� 5K      ��6$   �� *	NumRoom+5L      �� 5M      $��2q�6!   $ 
Horizontal=�6,   $��Italic$�6E   .+�5N      �� $��( ��6$   �� 5O      ��6$   �� *CurPersCount+�� 5P      $	�� / ��6$   �� 5Q      ��6$   �� *MaxPersCount+�� 5R      $�� )��6$   5S      5T      5U      5V      �� 5W   
   "  6   .R�5X      �� $��2q�6   
���   �$��1q�64   ��5Y      �� 5Z       6&   �� *Color+._�5\      �� 
���   �.+�5]      �� $��2q�6!   $ 
Horizontal=�6,   $
��Bold"�6E   .+�5^      �� $��Параллель ��6$   �� 5_      ��6$   �� *Level+5`      �� 5a      $��2q�6!   $ 
Horizontal=�6,   $��Italic$�6E   .+�5b      �� $��( ��6$   �� 5c      ��6$   �� *CurPersCount+�� 5d      $	�� / ��6$   �� 5e      ��6$   �� *MaxPersCount+�� 5f      $�� )��6$   5g      5h      5i      5j      �� 5k   
   "  6   .R�5l      �� $��2q�6   
���   �$��1q�64   ��5m      �� 5n       6&   �� *Color+._�5p      �� 
���   �.+�5q      �� $��2q�6    $
��Bold"�6+   ��6=   �� *Fio+	 6R   �� *Fio+�� 5r      $��2q�6!   $ 
Horizontal=�6,   .+�5s      �� ��6$   �� *Level+�� 5t      ��6$   �� *Symbol+�� 5u      $�� ��6$   �� 5v      $��Italic$�6$   ��67   �� *Rem+	 6L   �� *Rem+5w      5x      5y      5z      �� 5{   
   "  6   .R�5|      �� 
���   �$��1q�6)   $
 2��6=   ��5}      �� 5~       6&   �� *Color+._�5�      �  5�      �� 5�      $
��Auto �6(   �� 5�      �� 5�      $
��Auto �6(    5�      �� 5�      �� 5�      $
��Auto �6+   .+�5�      �� $��0��6!   $��0��61   $��2q�6>   $ 
Horizontal=�6I   $
��Bold"�6b   .+�5�      �� ��6$   �� *Level+�� 5�      ��6$   �� *Symbol+5�      �� 5�      $��1��6   $��0��6-   $��2q�6:   ��6E   �� *	ComRemove+.��5�      �� $��Pics/IcoDel.png��6    5�      �� 5�      $��0��6    $��1��60   $��2��6=   $��2q�6Q   $
��Wrap=�6�   	 6\   �� *Fio+��6t   �� *Fio+6�   �� 5�      $��0��6    $��2��60   $��2��6=   $��2q�6Q   $��Italic$�6\   	 6o   �� *Rem+��6�   �� *Rem+5�      5�      5�      �� 5�   
   "  6   .R�5�      �� $��8, 10, 8, 20q�6   
���   �$��3q�6?   $
 4��6S   ._�5�      � $��4q�6    5�      �� 5�      �� 5�      .+�5�      �� $��0��6%   $��4q�65   ��5�      �� 5�      $
 Left�6&    5�   "   �� 5�   &   ��6-   �� *
ComSetLeft+5�      5�      �� 5�      $��1��6%   $��4q�65   ��5�      �� 5�      $ Right�6&    5�   "   �� 5�   &   ��6-   �� *ComSetRight+5�      5�      5�      5�      5�      �� 5�   
   "  6   .R�5�      �  5�      �� 5�      $
��Auto �6$   �� 5�      .+�5�      o� $��0��6   .@�5�      m�  6   �� *ComNew+��5�      �� 5�      $��2q�6$   $��Pics/IcoNew.png��6/   $	 Новая посадка��6H   $��32��6`   5�      m� 5�       6   �� *	ComLoad+��5�      �� 5�      $��2q�6$   $��Pics/IcoLoad.png��6/   $'	 !Загрузить посадку��6I   $��32��6e   5�      m� 5�       6   �� *	ComSave+��5�      �� 5�      $��2q�6$   $��Pics/IcoSave.png��6/   $'	 !Сохранить посадку��6I   $��32��6e   5�      �� 5�      m� 5�       6   �� *
ComAddPers+��5�      �� 5�      $��2q�6$   $��Pics/IcoAddPers.png��6/   $!	 Добавить людей��6L   $��32��6e   5�      m� 5�      ��5�      �� 5�      $��2q�6$   $��Pics/IcoReport.png��6/   $	 Карта посадки��6K   $��32��6c   .@�5�      m� $��Карта посадки��6A    6#   �� *	ComRepMap+6A   m� 5�      $!��Список посадки��6B    6#   �� *
ComRepList+6B   m� 5�      $(��"Список по комнатам��6B    6#   �� *
ComRepRoom+6B   5�      5�      � 5�      $��1��6   ��5�      �� 5�       5�      �� 5�   "    6.   �� *	IsEmpty+ true6J   .a�5�   &   ��  � y�$ Hidden=�6H   5�   #   5�       5�      �� 5�      �� 5�      $
��Auto �6(    5�      �� 5�      �� 5�      $��3* �6+   �� 5�      $��3* �6+   �� 5�      �� 5�      $��2* �6+   .+�5�      �� $��0��6   $��0��6.   $��2��6;   $��4q�6L   8��  $��Stretch=�6�   $��Disabled=�6�   ��6W   �� *
RoomList+ 6x   �� *	CurRoom+6�   �� 5�      $��1��6   $��0��6-   $��2��6:   $��4q�6N   
���   �$��1q�6m   ._�5�      �� $��4q�6)   ��64   �� *	CurRoom+5�      �� 5�      $��1��6   $��1��6-   $��4q�6:   ��6E   �� *
ComAddRoom+.��5�      �� $��2q�6%   $ 
Horizontal=�60   .+�5�      �� $��Pics/IcoAdd.png��6$   �� 5�      $��2q�6(   $,��&Добавить еще кабинет��63   $��Center=�6O   5�      5�      �� 5�      $��2��6   $��1��6-   $��4q�6:   ��6E   �� *
ComDelRoom+{�6d   �� *IsEnableDelRoom+.��5�      �� $��2q�6%   $ 
Horizontal=�60   .+�5�      �� $��Pics/IcoDel.png��6$   �� 5�      $��2q�6(   $#��Удалить кабинет��63   $��Center=�6J   5�      5�      �� 5�      $��3��6   $��0��6.   $��2��6;   $��4q�6L   $��Stretch=�6�   $��Disabled=�6�   ��6W   �� *	LevelList+ 6y   �� *
CurLevel+6�   �� 5      $��4��6   $��0��6-   $��4q�6:   
���   �$��1q�6Y   ._�5     �� $��Disabled=�6'   $
��Auto=�6P   .��5     �� 8�� $��Stretch=�6}   ��6+   �� *CurPersList+6}   5     5     �� 5     $��4��6   $��1��6/   $��4q�6<   $��Stretch=�6�   $��Stretch=�6�   ��6G   �� *	ColorList+ 6i   �� *CurLevel.Color+6�   5     5     5     5	     .��5
       5     