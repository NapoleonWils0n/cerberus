FasdUAS 1.101.10   ��   ��    k             l      ��  ��   
http://veritrope.com
Evernote URL List Exporter
Version 1.1
November 27, 2010

PROJECT PAGE:
http://veritrope.com/tips/save-a-list-of-urls-from-your-evernote-items-as-a-list

CHANGELOG:
1.10    ADDED NOTE TITLE AND URL FIELDS TO EXPORTED TEXT FILE
1.00    INITIAL RELEASE
     � 	 	" 
 h t t p : / / v e r i t r o p e . c o m 
 E v e r n o t e   U R L   L i s t   E x p o r t e r 
 V e r s i o n   1 . 1 
 N o v e m b e r   2 7 ,   2 0 1 0 
 
 P R O J E C T   P A G E : 
 h t t p : / / v e r i t r o p e . c o m / t i p s / s a v e - a - l i s t - o f - u r l s - f r o m - y o u r - e v e r n o t e - i t e m s - a s - a - l i s t 
 
 C H A N G E L O G : 
 1 . 1 0         A D D E D   N O T E   T I T L E   A N D   U R L   F I E L D S   T O   E X P O R T E D   T E X T   F I L E 
 1 . 0 0         I N I T I A L   R E L E A S E 
   
  
 l     ��������  ��  ��        l      ��  ��     MAIN PROGRAM      �    M A I N   P R O G R A M        l     ��������  ��  ��        l      ��  ��    - 'PREPARE A EVERNOTE'S LIST OF NOTEBOOKS      �   N P R E P A R E   A   E V E R N O T E ' S   L I S T   O F   N O T E B O O K S        l   � ����  O    �    k   �       I   	������
�� .miscactvnull��� ��� null��  ��       !   r   
  " # " J   
 ����   # o      ���� "0 listofnotebooks listOfNotebooks !  $ % $ l   ��������  ��  ��   %  & ' & l    �� ( )��   (  GET THE NOTEBOOK LIST     ) � * * , G E T   T H E   N O T E B O O K   L I S T   '  + , + r     - . - 2    ��
�� 
EVnb . o      ���� 0 evnotebooks EVNotebooks ,  / 0 / X    4 1�� 2 1 k   % / 3 3  4 5 4 r   % * 6 7 6 l  % ( 8���� 8 l  % ( 9���� 9 n   % ( : ; : 1   & (��
�� 
pnam ; o   % &���� "0 currentnotebook currentNotebook��  ��  ��  ��   7 o      ���� *0 currentnotebookname currentNotebookName 5  <�� < s   + / = > = o   + ,���� *0 currentnotebookname currentNotebookName > l      ?���� ? n       @ A @  ;   - . A o   , -���� "0 listofnotebooks listOfNotebooks��  ��  ��  �� "0 currentnotebook currentNotebook 2 o    ���� 0 evnotebooks EVNotebooks 0  B C B l  5 5��������  ��  ��   C  D E D l   5 5�� F G��   F  SORT THE LIST     G � H H  S O R T   T H E   L I S T   E  I J I r   5 = K L K n  5 ; M N M I   6 ;�� O���� 0 simple_sort   O  P�� P o   6 7���� "0 listofnotebooks listOfNotebooks��  ��   N  f   5 6 L o      ����  0 folders_sorted Folders_sorted J  Q R Q l  > >��������  ��  ��   R  S T S l   > >�� U V��   U ( "USER SELECTION FROM NOTEBOOK LIST     V � W W D U S E R   S E L E C T I O N   F R O M   N O T E B O O K   L I S T   T  X Y X r   > S Z [ Z I  > O�� \ ]
�� .gtqpchltns    @   @ ns   \ o   > ?����  0 folders_sorted Folders_sorted ] �� ^ _
�� 
appr ^ m   @ A ` ` � a a 0 S e l e c t   E v e r n o t e   N o t e b o o k _ �� b c
�� 
prmp b l 	 B C d���� d m   B C e e � f f 4 C u r r e n t   E v e r n o t e   N o t e b o o k s��  ��   c �� g��
�� 
okbt g m   F I h h � i i  O K��   [ o      ���� 0 selnotebook SelNotebook Y  j k j r   T ^ l m l n   T Z n o n 4   W Z�� p
�� 
cobj p m   X Y����  o o   T W���� 0 selnotebook SelNotebook m o      ���� 0 
evnotebook 
EVnotebook k  q r q l   _ e s t u s r   _ e v w v J   _ a����   w o      ���� 0 listofnotes listofNotes t . (PREPARE TO GET EVERNOTE'S LIST OF NOTES     u � x x P P R E P A R E   T O   G E T   E V E R N O T E ' S   L I S T   O F   N O T E S   r  y z y r   f l { | { J   f h����   | o      ���� 0 note_records note_Records z  } ~ } r   m {  �  n  m w � � � 2   s w��
�� 
EVnn � 4   m s�� �
�� 
EVnb � o   o r���� 0 
evnotebook 
EVnotebook � o      ���� 0 allnotes allNotes ~  � � � X   | � ��� � � Q   � � � ��� � k   � � � �  � � � r   � � � � � l  � � ����� � l  � � ����� � n   � � � � � 1   � ���
�� 
EVsu � o   � ����� 0 currentnote currentNote��  ��  ��  ��   � o      ����  0 currentnoteurl currentNoteURL �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
EVet � o   � ����� 0 currentnote currentNote � o      ���� $0 currentnotetitle currentNoteTitle �  ��� � Z   � � � ����� � >  � � � � � o   � �����  0 currentnoteurl currentNoteURL � m   � ���
�� 
msng � k   � � � �  � � � s   � � � � � o   � �����  0 currentnoteurl currentNoteURL � l      ����� � n       � � �  ;   � � � o   � ����� 0 listofnotes listofNotes��  ��   �  ��� � s   � � � � � K   � � � � �� � �
�� 
pnam � o   � ����� $0 currentnotetitle currentNoteTitle � �� ���
�� 
url  � o   � �����  0 currentnoteurl currentNoteURL��   � l      ����� � n       � � �  ;   � � � o   � ����� 0 note_records note_Records��  ��  ��  ��  ��  ��   � R      ������
�� .ascrerr ****      � ****��  ��  ��  �� 0 currentnote currentNote � o    ����� 0 allnotes allNotes �  � � � l  � ���������  ��  ��   �  � � � l   � ��� � ���   �  SORT THE LIST     � � � �  S O R T   T H E   L I S T   �  � � � r   � � � � � n  � � � � � I   � ��� ����� 0 simple_sort   �  ��� � o   � ����� 0 listofnotes listofNotes��  ��   �  f   � � � o      ���� 0 notes_sorted Notes_sorted �  � � � r   � � � � l 	 � ����� � I  ��� � �
�� .gtqpchltns    @   @ ns   � o   � ����� 0 notes_sorted Notes_sorted � �� � �
�� 
appr � l 	 � � ����� � m   � � � � � � � * L i s t   O f   U R L s   I n   N o t e s��  ��   � �� � �
�� 
okbt � m   � � � � � � �  E x p o r t   L i s t � �� � �
�� 
cnbt � m   � � � � � � �  C l o s e   W i n d o w � �� ���
�� 
empL � m  ��
�� boovtrue��  ��  ��   � o      ���� 0 selnote SelNote �  � � � l ����~��  �  �~   �  � � � l  �} � ��}   �  PROCESS RECORDS LIST     � � � � * P R O C E S S   R E C O R D S   L I S T   �  � � � r   � � � J  �|�|   � o      �{�{ 0 record_text record_Text �  � � � X  Y ��z � � k  &T � �  � � � r  &K � � � c  &G � � � l &C ��y�x � b  &C � � � b  &? � � � b  &; � � � b  &5 � � � b  &1 � � � b  &- � � � m  &) � � � � �  T i t l e :   � n  ), � � � 1  *,�w
�w 
pnam � o  )*�v�v 0 note_record note_Record � o  -0�u
�u 
ret  � m  14 � � � � � 
 U R L :   � n  5: � � � m  6:�t
�t 
url  � o  56�s�s 0 note_record note_Record � o  ;>�r
�r 
ret  � o  ?B�q
�q 
ret �y  �x   � m  CF�p
�p 
ctxt � o      �o�o $0 thecurrentrecord theCurrentRecord �  ��n � s  LT   o  LO�m�m $0 thecurrentrecord theCurrentRecord l     �l�k n        ;  RS o  OR�j�j 0 record_text record_Text�l  �k  �n  �z 0 note_record note_Record � o  �i�i 0 note_records note_Records �  l ZZ�h�g�f�h  �g  �f    l  ZZ�e	
�e  	  EXPORT LIST OPTION    
 � & E X P O R T   L I S T   O P T I O N   �d Z  Z��c l Z_�b�a > Z_ o  Z]�`�` 0 selnote SelNote m  ]^�_
�_ boovfals�b  �a   O  b� k  h�  l hh�^�^      convert list to text FILE    � 4   c o n v e r t   l i s t   t o   t e x t   F I L E  r  h� c  h�  b  h�!"! b  h�#$# b  h}%&% b  hy'(' b  hs)*) b  ho+,+ m  hk-- �.. D C u r r e n t   L i s t   o f   U R L s   i n   N o t e s   f o r  , o  kn�]�] 0 
evnotebook 
EVnotebook* m  or// �00  - -  ( l sx1�\�[1 I sx�Z�Y�X
�Z .misccurdldt    ��� null�Y  �X  �\  �[  & o  y|�W
�W 
ret $ o  }��V
�V 
ret " o  ���U�U 0 record_text record_Text  m  ���T
�T 
utxt o      �S�S 0 
exportlist 
ExportList 232 r  ��454 I ���R�Q6
�R .sysonwflfile    ��� null�Q  6 �P78
�P 
prmt7 m  ��99 �::  N a m e   t h i s   f i l e8 �O;<
�O 
dfnm; b  ��=>= b  ��?@? m  ��AA �BB 8 U R L   L i s t   f o r   N o t e b o o k   N a m e d  @ o  ���N�N 0 
evnotebook 
EVnotebook> l 	��C�M�LC m  ��DD �EE  . t x t�M  �L  < �KF�J
�K 
dflcF l ��G�I�HG I ���GH�F
�G .earsffdralis        afdrH 1  ���E
�E 
desk�F  �I  �H  �J  5 o      �D�D 0 fn  3 IJI r  ��KLK I ���CMN
�C .rdwropenshor       fileM o  ���B�B 0 fn  N �AO�@
�A 
permO m  ���?
�? boovtrue�@  L o      �>�> 0 fid  J PQP I ���=RS
�= .rdwrwritnull���     ****R o  ���<�< 0 
exportlist 
ExportListS �;T�:
�; 
refnT o  ���9�9 0 fid  �:  Q U�8U I ���7V�6
�7 .rdwrclosnull���     ****V o  ���5�5 0 fid  �6  �8   m  beWW�                                                                                  sevs  alis    |  Pollux                     �FGaH+   
h#System Events.app                                               
�4�85G        ����  	                CoreServices    �FGa      �8'7     
h# 
  
 �  4Pollux:System:Library:CoreServices:System Events.app  $  S y s t e m   E v e n t s . a p p    P o l l u x  -System/Library/CoreServices/System Events.app   / ��  �c   r  ��XYX n  ��Z[Z 4  ���4\
�4 
cobj\ m  ���3�3 [ o  ���2�2 0 selnotebook SelNotebookY o      �1�1 0 
evnotebook 
EVnotebook�d    m     ]]�                                                                                  EVRN  alis    B  Pollux                     �FGaH+    Evernote.app                                                    ���?�Z        ����  	                Applications    �FGa      �?�Z         Pollux:Applications:Evernote.app    E v e r n o t e . a p p    P o l l u x  Applications/Evernote.app   / ��  ��  ��    ^_^ l     �0�/�.�0  �/  �.  _ `a` l      �-bc�-  b   SUBROUTINES    c �dd    S U B R O U T I N E S  a efe l     �,�+�*�,  �+  �*  f ghg l     �)ij�)  i  SORT SUBROUTINE   j �kk  S O R T   S U B R O U T I N Eh l�(l i     mnm I      �'o�&�' 0 simple_sort  o p�%p o      �$�$ 0 my_list  �%  �&  n k     uqq rsr r     tut J     �#�#  u l     v�"�!v o      � �  0 
index_list  �"  �!  s wxw r    	yzy J    ��  z l     {��{ o      �� 0 sorted_list  �  �  x |}| U   
 r~~ k    m�� ��� r    ��� m    �� ���  � l     ���� o      �� 0 low_item  �  �  � ��� Y    c������ Z   ) ^����� H   ) -�� E  ) ,��� l  ) *���� o   ) *�� 0 
index_list  �  �  � o   * +�� 0 i  � k   0 Z�� ��� r   0 8��� c   0 6��� n   0 4��� 4   1 4��
� 
cobj� o   2 3�� 0 i  � o   0 1�� 0 my_list  � m   4 5�
� 
ctxt� o      �� 0 	this_item  � ��� Z   9 Z����
� =  9 <��� l  9 :��	�� o   9 :�� 0 low_item  �	  �  � m   : ;�� ���  � k   ? F�� ��� r   ? B��� o   ? @�� 0 	this_item  � l     ���� o      �� 0 low_item  �  �  � ��� r   C F��� o   C D�� 0 i  � l     �� ��� o      ���� 0 low_item_index  �   ��  �  � ��� A I L��� o   I J���� 0 	this_item  � l  J K������ o   J K���� 0 low_item  ��  ��  � ���� k   O V�� ��� r   O R��� o   O P���� 0 	this_item  � l     ������ o      ���� 0 low_item  ��  ��  � ���� r   S V��� o   S T���� 0 i  � l     ������ o      ���� 0 low_item_index  ��  ��  ��  ��  �
  �  �  �  � 0 i  � m    ���� � l   $������ n    $��� m   ! #��
�� 
nmbr� n   !��� 2   !��
�� 
cobj� o    ���� 0 my_list  ��  ��  �  � ��� r   d h��� l  d e������ o   d e���� 0 low_item  ��  ��  � l     ������ n      ���  ;   f g� o   e f���� 0 sorted_list  ��  ��  � ���� r   i m��� l  i j������ o   i j���� 0 low_item_index  ��  ��  � l     ������ n      ���  ;   k l� l  j k������ o   j k���� 0 
index_list  ��  ��  ��  ��  ��   l   ������ l   ������ n    ��� m    ��
�� 
nmbr� n   ��� 2   ��
�� 
cobj� o    ���� 0 my_list  ��  ��  ��  ��  } ���� L   s u�� l  s t������ o   s t���� 0 sorted_list  ��  ��  ��  �(       �������  � ������ 0 simple_sort  
�� .aevtoappnull  �   � ****� ��n���������� 0 simple_sort  �� ����� �  ���� 0 my_list  ��  � ���������������� 0 my_list  �� 0 
index_list  �� 0 sorted_list  �� 0 low_item  �� 0 i  �� 0 	this_item  �� 0 low_item_index  � ��������
�� 
cobj
�� 
nmbr
�� 
ctxt�� vjvE�OjvE�O g��-�,Ekh�E�O Hk��-�,Ekh �� /��/�&E�O��  �E�O�E�Y �� �E�O�E�Y hY h[OY��O��6FO��6F[OY��O�� �����������
�� .aevtoappnull  �   � ****� k    ���  ����  ��  ��  � �������� "0 currentnotebook currentNotebook�� 0 currentnote currentNote�� 0 note_record note_Record� G]������������������������ `�� e�� h������������������������������������ � ��� ��������� ��� �����W-/��������9��AD������������������~�}
�� .miscactvnull��� ��� null�� "0 listofnotebooks listOfNotebooks
�� 
EVnb�� 0 evnotebooks EVNotebooks
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
pnam�� *0 currentnotebookname currentNotebookName�� 0 simple_sort  ��  0 folders_sorted Folders_sorted
�� 
appr
�� 
prmp
�� 
okbt�� 
�� .gtqpchltns    @   @ ns  �� 0 selnotebook SelNotebook�� 0 
evnotebook 
EVnotebook�� 0 listofnotes listofNotes�� 0 note_records note_Records
�� 
EVnn�� 0 allnotes allNotes
�� 
EVsu��  0 currentnoteurl currentNoteURL
�� 
EVet�� $0 currentnotetitle currentNoteTitle
�� 
msng
�� 
url �� ��  ��  �� 0 notes_sorted Notes_sorted
�� 
cnbt
�� 
empL�� �� 0 selnote SelNote�� 0 record_text record_Text
�� 
ret 
�� 
ctxt�� $0 thecurrentrecord theCurrentRecord
�� .misccurdldt    ��� null
�� 
utxt�� 0 
exportlist 
ExportList
�� 
prmt
�� 
dfnm
�� 
dflc
�� 
desk
�� .earsffdralis        afdr
�� .sysonwflfile    ��� null�� 0 fn  
�� 
perm
�� .rdwropenshor       file�� 0 fid  
� 
refn
�~ .rdwrwritnull���     ****
�} .rdwrclosnull���     ****�����*j OjvE�O*�-E�O �[��l kh  ��,E�O��6G[OY��O)�k+ 
E�O�����a a a  E` O_ �k/E` OjvE` OjvE` O*�_ /a -E` O `_ [��l kh  C�a ,E` O�a ,E` O_ a  !_ _ 6GO�_ a _ a  _ 6GY hW X ! "h[OY��O)_ k+ 
E` #O_ #�a $a a %a &a 'a (ea ) E` *OjvE` +O D_ [��l kh a ,��,%_ -%a .%�a ,%_ -%_ -%a /&E` 0O_ 0_ +6G[OY��O_ *f �a 1 ya 2_ %a 3%*j 4%_ -%_ -%_ +%a 5&E` 6O*a 7a 8a 9a :_ %a ;%a <*a =,j >a  ?E` @O_ @a Ael BE` CO_ 6a D_ Cl EO_ Cj FUY _ �k/E` U ascr  ��ޭ