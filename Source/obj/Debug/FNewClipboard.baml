   M S B A M L   `   `   `  ����C  ?OlimpSet, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null#clr-namespace:OlimpSetOlimpSet  5          OlimpSet.FNewClipboard   5      \ XPresentationFramework, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      8x,http://schemas.microsoft.com/winfx/2006/xaml    5      &localclr-namespace:OlimpSet    5        � Title$5  /Загрузка из буфера обмена��5      $	��500��5      $	��700��6    � WindowStartupLocation$ CenterScreen=�5       � ShowInTaskbar .   � 	Resources 5	       �� DataType   OlimpSet.vmFromClip � IsSharedSizeScope � RowDefinitions �� Orientation �� Triggers	 �� Binding
 �� Value �� Property �� Value � ColumnDefinitions z� SharedSizeGroup   OlimpSet.TPers��%]  (��       5
      *, +)(�� v    56      *, +)�� 5
   
   "  6   .R�5      �  .  5      �� 5      $
��Auto �6$   �� 5      $
��Auto �6$   �� 5      �� 5      $
��Auto �6$   .+�5      �� $��0��6   $��4q�6&   ��61   �� *ComLoadClip+.��5      �� $��4q�6!   $ 
Horizontal=�6,   .+�5      �� $��Pics/IcoClip.png��6    �� 5      $��2q�6$   $��Center=�6/   $@��:Забрать данные из буфера обмена��6J   5      5      � 5      $��1��6   ��5      �� 5       5      �� 5   "   	 6.   �� *List.Length+
 06N   .a�5   &   ��  � y�$ Hidden=�6H   5   #   5!       5#      �� 5$      $��5* �6+   $	 gr1��66   �� 5%      $��* �6+   $	 gr2��65   �� 5&      $��4* �6+   $	 gr3��66   .+�5)      �� $��0��6    $��2q�60   $
��Bold"�6;   $��ФИО��6M   �� 5*      $��1��6    $��2q�60   $
��Bold"�6;   $��
Класс��6M   �� 5+      $��2��6    $��2q�60   $
��Bold"�6;   $��Примечание��6M   5,      �� 5-      $��2��6   $��4q�6,   $��Disabled=�67   $
��Auto=�6`   $��Stretch=�6�   .��5.      �� ��6#   �� *List+5/      �� 50      $��3��6   $��4q�6*   $ 
Horizontal=�65   .+�51      �� $!��Всего дебилов: ��6    �� 52      $
��Bold"�6=   ��6    �� *List.Length+6=   53      54      55      �� 56   
   "  6   .R�57      �  58      �� 59      $	 gr1��6'   �� 5:      $	 gr2��6'   �� 5;      $	 gr3��6'   .+�5>      �� $��0��6   $��2q�6,   ��67   �� *Fio+�� 5?      $��1��6   $��2q�6-   $ 
Horizontal=�68   .+�5@      �� ��6    �� *Level+�� 5A      ��6    �� *Symbol+5B      �� 5C      $��2��6   $��2q�6,   ��67   �� *Rem+5D      5E      5F      .��5H      �  .  5I   
   �� 5J      �� 5K      $
��Auto �6    5M   
   �� 5N      �� 5O      $
��Auto �6   $ grButton��6,   �� 5P      $
��Auto �6   $ grButton��6,   .+�5S   
   �� -   5         ��Name$	 Box��5S   J   $��0��6   $��0��6&   $��3��66   ��5T        5U      5W      �� 5X   
   -   5        $��1��5X      $��1��6!   $��4q�6.   $��Ok��69    �� 	IsDefault . 6W   �� 5Y   
   $��2��6   $��1��6!   $��4q�6.   $��Cancel��69    �� IsCancel . 6J   5Z      5[      