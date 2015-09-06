/*
Svdvorak remapping bygger på "Svorak Remapping ett portabelt program som gör att du kan använda svorak var du vill.", med små modifikationer för Svdvorak

    Copyright (C) 2009  Viktor Barsk
	Modifierat av: Jite 2010 för Svdvorak

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/


Version:="0.60.1"
Layout:="A1/A5"


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
SetWorkingDir %A_ScriptDir%  
#MaxHotkeysPerInterval 999999


Menu, tray, NoStandard
Menu, tray, add,Om Svdvorak remapping...,Info
Menu, tray, add 
Menu, tray, add,Inställningar...,GUIshow
Menu, tray, add,Starta i detta läge,Inisavelbl
Menu, tray, add 
Menu, tray, add,Qwerty när Ctrl/Win/Alt är nedtryckt. (Shift+F11),Ctrmeny
Menu, tray, add,Paus (Shift+F12),Paus
Menu, tray, add 
Menu, tray, add,Stäng,Stang
Menu, tray, Tip, Svdvorak Remapping 
; Hovernamn

Iniload()


Gui, Add, Text, x16 y40 w270 h30 , Ersätter tangenterna med de i rutorna.`nLämna rutorna tomma för att använda tidigare inställt.

Gui, Add, Text, x16 y80 w140 h20 , Caps Lock
Gui, Add, DropDownList, x155 y80 w130 vCapsGUIsubmit ,|(Funktionen avstängd)|Backspace|Esc|Delete|Enter|Space|Ctrl|LWin|Alt|Shift|Browser_Home|Browser_Forward|Browser_Back|Browser_Search|Volume_Mute|Media_Next|Media_Prev|Media_Play_Pause|Launch_Media
Gui, Add, Text, x15 y109  w140 h20 , §-knappen
Gui, Add, DropDownList, x156 y110 w130 vParaGUIsubmit ,|(Funktionen avstängd)|Backspace|Esc|Delete|Enter|Space|Ctrl|LWin|Alt|Shift|Browser_Home|Browser_Forward|Browser_Back|Browser_Search|Volume_Mute|Media_Next|Media_Prev|Media_Play_Pause|Launch_Media
Gui, Add, Text, x15 y140 w140 h20 , Appskey (Bredvid högra Ctrl)
Gui, Add, DropDownList, x155 y140 w130 vAppsGUIsubmit,|(Funktionen avstängd)|Backspace|Esc|Delete|Enter|Space|Ctrl|LWin|Alt|RAlt|Shift|Browser_Home|Browser_Forward|Browser_Back|Browser_Search|Volume_Mute|Media_Next|Media_Prev|Media_Play_Pause|Launch_Media
Gui, Add, Edit, x296 y40 w260 h190 readonly,Browser_Home`n    Starta webbläsare/gå till startsida`nBrowser_Forward/Browser_Back`n    Framåt/Bakåt i webbläsaren`nBrowser_Search`n    Flytta fokus till sökfältet i webbläsaren`nVolume_Mute`n    Stäng av/Slå på ljudet`nMedia_Next/Media_Prev`n    Nästa/Förra låten i mediespelaren`nMedia_Play_Pause`n    Pausa/Fortsätt mediespelaren`nLaunch_Media`n    Starta mediespelare
Gui, Add, CheckBox, x16 y220 w190 h20 Checked%A5% vA5, A5 (D.v.s. symboler under Alt Gr)
Gui, Add, CheckBox, x15 y249 w190 h20 Checked%Tip% vTip, Visa Pratbubblor
Gui, Add, Button, x306 y240 w110 h30 gAvbryt, Avbryt
Gui, Add, Button, x436 y240 w110 h30 Default gOK, OK
Gui, Font, S12 CDefault Bold, Verdana
Gui, Add, Text, x296 y10 w110 h20 , Förklaring
Gui, Add, Text, x16 y10 w180 h20 , Onödiga tangenter
Gui, Add, Text, x16 y180 w190 h20 , Andra inställningar
return

;------ Meny ------

;BeginRegion
Info:
	MsgBox,,Svdvorak remapping(baserat på Svorak remapping),Version: %Version%`n`nSvdvorak remapping fångar upp tangenttryckningar från qwerty-standarden`noch ändrar dem till Svdvorak. `n`nCopyright (C) 2009  Viktor Barsk <email: viktor@ubarskit.com>`nsnabbmodifierat för Svdvorak av Jite 2010`n`nThis program is free software: you can redistribute it and/or modify`nit under the terms of the GNU General Public License as published by`nthe Free Software Foundation, either version 3 of the License, or`n(at your option) any later version.`n`nThis program is distributed in the hope that it will be useful,`nbut WITHOUT ANY WARRANTY; without even the implied warranty of`nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the`nGNU General Public License for more details.`n`nYou should have received a copy of the GNU General Public License`nalong with this program.  If not, see <http://www.gnu.org/licenses/>.`n
return
;------
Inisavelbl:
	Inisave()
return
;------
GUIshow:
	Gui, Show,h290 w570, Svdvorak remapping config
return
;------
Ctrmeny:
	Ctrfunct(toggle(ctr))
return
;------
Paus:
	Pausefunct(toggle(paus))
return
;------
Stang:
	ExitApp
return

;EndRegion
;------ Hotkeys ------
;BeginRegion
+F12::
	Suspend,permit
	Pausefunct(toggle(paus))
	Sleep,100
return
;------
+F11::
	Suspend,permit
	Ctrfunct(toggle(ctr))
	Sleep,100
return
;EndRegion
;------ GUI functioner ------
;BeginRegion
KeyGUI(ByRef GUIsubmit,ByRef keysendDown,ByRef keysendUp,ByRef sendkey,hkname) {
	If (GUIsubmit="(Funktionen avstängd)"){
		Hotkey,%hkname%,off
		keysend=0
		sendkey=%GUIsubmit%
	}
	Else If (GUIsubmit="Ctrl" or GUIsubmit="LWin" or GUIsubmit="Alt" or GUIsubmit="Shift" or GUIsubmit="RAlt"){
		keysendDown={%GUIsubmit% Down}
		keysendUp={%GUIsubmit% Up}
		sendkey=%GUIsubmit%
		Hotkey,%hkname%,on
	}
	Else If (GUIsubmit!=""){
		keysendDown={%GUIsubmit% Down}
		keysendUp={%GUIsubmit% Up}
		keysendUp:=false
		sendkey=%GUIsubmit%
		Hotkey,%hkname%,on
	}
	return
}
return

Onodigonoff(ByRef GUIsubmit,hkname) {
	If (GUIsubmit="(Funktionen avstängd)"){
		Hotkey,%hkname%,off
	}
	Else If (GUIsubmit!=""){
		Hotkey,%hkname%,on
	}
	return
}
return

GuiClose:
Gui, Cancel
return

OK:
Gui, Submit
KeyGUI(CapsGUIsubmit,CapssendDown,CapssendUp,Capssendkey,"*Capslock")
KeyGUI(ParaGUIsubmit,ParasendDown,ParasendUp,Parasendkey,"*§")
KeyGUI(AppsGUIsubmit,AppssendDown,AppssendUp,Appssendkey,"*AppsKey")
A15funct(fromvar(A5))
InisaveGUI()
return

Avbryt:
Gui, Cancel
return

InisaveGUI(){
	Global
	IniWrite, %Version%, Svorak_config.ini, Version, Version
	IniWrite, %Capssendkey%, Svorak_config.ini, 1, Capssendkey
	IniWrite, %Parasendkey%, Svorak_config.ini, 1, Parasendkey
	IniWrite, %Appssendkey%, Svorak_config.ini, 1, Appssendkey
	
	IniWrite, %CapssendDown%, Svorak_config.ini, 1, CapssendDown
	IniWrite, %ParasendDown%, Svorak_config.ini, 1, ParasendDown
	IniWrite, %AppssendDown%, Svorak_config.ini, 1, AppssendDown
	
	IniWrite, %CapssendUp%, Svorak_config.ini, 1, CapssendUp
	IniWrite, %ParasendUp%, Svorak_config.ini, 1, ParasendUp
	IniWrite, %AppssendUp%, Svorak_config.ini, 1, AppssendUp
	
	IniWrite, %A5%, Svorak_config.ini, 1, A5
	IniWrite, %tip%, Svorak_config.ini, 1, tip
	TrayTip , Inställningarna sparades,i %A_WorkingDir%\Svorak_config.ini, 10,
	return
}
*Capslock::
	Suspend,permit 
	If (CapssendUp!="false" && CapssendDown!="{Shift Down}" && ctr){
		Suspend,On
	}
	Send,%CapssendDown%
	If (CapssendUp!=false){
		Keywait, Capslock
		Send,%CapssendUp%
	}
	If (CapssendUp!="false" && CapssendDown!="{Shift Down}" && ctr){
		Suspend,Off
	}
return

*§::
	If (ParasendUp!="false" && ParasendDown!="{Shift Down}" && ctr){
		Suspend,On
	}
	Suspend,permit 
	Send,%ParasendDown%
	If (ParasendUp!=false){
		Keywait, §
		Send,%ParasendUp%
	}
	If (ParasendUp!="false" && ParasendDown!="{Shift Down}" && ctr){
		Suspend,Off
	}
return

*AppsKey::
	If (AppssendUp!="false" && AppssendDown!="{Shift Down}" && ctr){
		Suspend,On	
	}
	Suspend,permit 
	Send,%AppssendDown%
	If (AppssendUp!=false){
		Keywait, Appskey
		Send,%AppssendUp%
	}
	If (AppssendUp!="false" && AppssendDown!="{Shift Down}" && ctr){
		Suspend,Off	
	}
return
;EndRegion
;------ On/Off Funktioner ------
;BeginRegion
toggle(ByRef var){
	If(var){
		var:=false
		return false
	}
	Else {
		var:=true
		return true
	}
}
fromvar(ByRef var){
	If(var){
		return true
	}
	Else {
		return false
	}
}
;------
Pausefunct(onoff) {
	Global
	If(onoff){
		Menu,tray,Check,Paus (Shift+F12)
		Suspend,On
		Menu, Tray, Icon, %A_ScriptName%, 3, 1
		Hotkey,*CapsLock, Off
		Hotkey,*§, Off
		Hotkey,*AppsKey, Off
		Altgroff()
		Tipfunct("Qwerty")
	}
	else {
		Menu,tray,Uncheck,Paus (Shift+F12)
		Suspend,Off
		Menu, Tray, Icon, %A_ScriptName%, 8, 1
		Tipfunct("Svdvorak")
		If(A5=1){
			Altgron()
		}
		If(Capssend!=false){
			Hotkey,*CapsLock, On
		}
		If(Parasend!=false){
			Hotkey,*§, On
		}
		If(Appssend!=false){
			Hotkey,*AppsKey, On
		}
	}
	return
}
;------
Ctrfunct(onoff) {
	If(onoff){
		Menu,tray,Check,Qwerty när Ctrl/Win/Alt är nedtryckt. (Shift+F11)
		Hotkey,~LWin,on
		Hotkey,~RWin,on
		Hotkey,~RCtrl,on
		Hotkey,~LAlt,on
		Hotkey,~LCtrl,on
		Tipfunct("när Ctrl/Win/Alt är nedtryckt","Qwerty")
	}
	else {
		Menu,tray,Uncheck,Qwerty när Ctrl/Win/Alt är nedtryckt. (Shift+F11)
		Hotkey,~LWin,off
		Hotkey,~RWin,off
		Hotkey,~RCtrl,off
		Hotkey,~LAlt,off
		Hotkey,~LCtrl,off
		Tipfunct("när Ctrl/Win/Alt är nedtryckt","Svdvorak")
	}
	return
}
;------
A15funct(onoff) {
	If(onoff){
		Altgron()
	}
	else {
		Altgroff()
	}
	return
}
;EndRegion

;------ Ini Save/Load ------
;BeginRegion
Iniload(){
	Global
	IniRead, ctr, Svorak_config.ini, 1, ctr, 1
	IniRead, A5, Svorak_config.ini, 1, A5, 1
	IniRead, paus, Svorak_config.ini, 1, paus, 0
			Ctrfunct(fromvar(ctr))
			A15funct(fromvar(A5))
			Pausefunct(fromvar(paus))
		
	IniRead, CapssendDown, Svorak_config.ini, 1, CapssendDown,{Space Down}
	IniRead, ParasendDown, Svorak_config.ini, 1, ParasendDown,{Space Down}
	IniRead, AppssendDown, Svorak_config.ini, 1, AppssendDown,{Space Down}
	
	IniRead, CapssendUp, Svorak_config.ini, 1, CapssendUp,{Space Up}
	IniRead, ParasendUp, Svorak_config.ini, 1, ParasendUp,{Space Up}
	IniRead, AppssendUp, Svorak_config.ini, 1, AppssendUp,{Space Up}
	
	IniRead, Capssendkey, Svorak_config.ini, 1, Capssendkey,(Funktionen avstängd)
	IniRead, Parasendkey, Svorak_config.ini, 1, Parasendkey,(Funktionen avstängd)
	IniRead, Appssendkey, Svorak_config.ini, 1, Appssendkey,(Funktionen avstängd)
		Onodigonoff(Capssendkey,"*Capslock")
		Onodigonoff(Parasendkey,"*§")
		Onodigonoff(Appssendkey,"*AppsKey")
	IniRead, tip, Svorak_config.ini, 1, tip, 1
	return
}
Inisave(){
	Global
	IniWrite, %Version%, Svorak_config.ini, Version, Version
	IniWrite, %ctr%, Svorak_config.ini, 1, ctr
	IniWrite, %paus%, Svorak_config.ini, 1, paus
	TrayTip , Inställningarna sparades,i %A_WorkingDir%\Svorak_config.ini, 10,
	return
}

;EndRegion
;------ Traytip -----
;BeginRegion
Tipfunct(text ="Stäng av dessa i inställningar",title = ""){
	global tip
	If (tip) {
		TrayTip ,%title%, %text%, 10,
	}
return
}

;EndRegion
;------ ctr -----
/*
~§::
~Capslock::
~Appskey::

 AHK klarar inte av att både ~ och * kallas av sammma knapp utan det är bara ~ skickas.
*/
~LWin::
~RWin::
~RCtrl::
~LAlt::
~LCtrl:: ; Inkluderar även Alt Gr p.g.a. någon bugg i AHK.
	Suspend,On
	keywait,Ctrl
	keywait,LWin
	keywait,RWin
	keywait,LAlt
	; --------------------------------------------------------------- Detta måste fixas innar realease -----------------------------------------
/*
	If (ParasendUp!="false" && ParasendDown!="{Shift Down}"){
		keywait,§
	}
	If (CapssendUp!="false" && CapssendDown!="{Shift Down}"){
		keywait,Capslock
	}
	If (AppssendUp!="false" && AppssendDown!="{Shift Down}"){
		keywait,Appskey	
	}
*/
	; --------------------------------------------------------------- Detta måste fixas innar realease (slut) ----------------------------------
	Suspend,Off
return
;------ Remapping ------
;BeginRegion
q::å
w::,
e::.
r::p
t::y
y::f
u::g
i::c
o::r
p::l
å::'

a::a
s::o
d::e
f::u
g::i
h::d
j::h
k::t
l::n
ö::s
ä::-

z::ä
x::q
c::j
v::k
b::x
n::b
m::m
,::w
.::v
-::z
<::ö
'::<
;EndRegion
;------ Remapping - Alt Gr ------
Altgroff(){
Hotkey,<^>!q,off
Hotkey,<^>!w,off
Hotkey,<^>!e,off
Hotkey,<^>!r,off
Hotkey,<^>!t,off
Hotkey,<^>!y,off
Hotkey,<^>!u,off
Hotkey,<^>!i,off
Hotkey,<^>!o,off
Hotkey,<^>!p,off
Hotkey,<^>!a,off
Hotkey,<^>!s,off
Hotkey,<^>!d,off
Hotkey,<^>!f,off
Hotkey,<^>!g,off
Hotkey,<^>!h,off
Hotkey,<^>!k,off
Hotkey,<^>!l,off
Hotkey,<^>!ö,off
Hotkey,<^>!z,off
Hotkey,<^>!x,off
Hotkey,<^>!c,off
Hotkey,<^>!v,off
Hotkey,<^>!b,off
Hotkey,<^>!n,off
Hotkey,<^>!.,off
}
Altgron(){
Hotkey,<^>!q,on
Hotkey,<^>!w,on
Hotkey,<^>!e,on
Hotkey,<^>!r,on
Hotkey,<^>!t,on
Hotkey,<^>!y,on
Hotkey,<^>!u,on
Hotkey,<^>!i,on
Hotkey,<^>!o,on
Hotkey,<^>!p,on
Hotkey,<^>!a,on
Hotkey,<^>!s,on
Hotkey,<^>!d,on
Hotkey,<^>!f,on
Hotkey,<^>!g,on
Hotkey,<^>!h,on
Hotkey,<^>!k,on
Hotkey,<^>!l,on
Hotkey,<^>!ö,on
Hotkey,<^>!z,on
Hotkey,<^>!x,on
Hotkey,<^>!c,on
Hotkey,<^>!v,on
Hotkey,<^>!b,on
Hotkey,<^>!n,on
Hotkey,<^>!.,on
Hotkey,<^>!',on
}

<^>!q::
Suspend,permit
Send {Raw}{
return
<^>!'::
Suspend,permit
Send {Raw}|
return
<^>!w::
Suspend,permit
Send {Raw}}
return
<^>!e::
Suspend,permit
Send {Raw}[
return
<^>!r::
Suspend,permit
Send {Raw}]
return
<^>!t::
Suspend,permit
Send {Raw}$
return
<^>!y::
Suspend,permit
Send {Raw}" ;" (För att inte förstöra syntax highlighting)
return
<^>!u::
Suspend,permit
Send {Raw}?
return
<^>!i::
Suspend,permit
Send {Raw}&
return
<^>!o::
Suspend,permit
Send {Raw}<
return
<^>!p::
Suspend,permit
Send {Raw}>
return
;--- rad 2 ---
<^>!a::
Suspend,permit
Send `;
return
<^>!s::
Suspend,permit
Send {Raw}/
return
<^>!d::
Suspend,permit
Send {Raw}(
return
<^>!f::
Suspend,permit
Send {Raw})
return
<^>!g::
Suspend,permit
Send {Raw}|
return
<^>!h::
Suspend,permit
Send {Raw}#
return
<^>!k::
Suspend,permit
Send {Raw}#
return
<^>!l::
Suspend,permit
Send {Raw}" ;"
return
<^>!ö::
Suspend,permit
Send `~
return
;--- rad 3 ---
<^>!z::
Suspend,permit
Send {Raw}:
return
<^>!x::
Suspend,permit
Send {Raw}=
return
<^>!c::
Suspend,permit
Send {Raw}@
return
<^>!v::
Suspend,permit
Send {Raw}!
return
<^>!b::
Suspend,permit
Send {Raw}\
return
<^>!n::
Suspend,permit
Send `%
return
<^>!.::
Suspend,permit
Send `;
return

/*
Ingen ändring på dessa
<^>!m::
Suspend,permit
Send {Raw} 
return
<^>!,:: 
Suspend,permit
Send {Raw}
return
<^>!.::
Suspend,permit
Send {Raw} 
return
<^>!-::
Suspend,permit
Send {Raw}
return
<^>!å::
Suspend,permit
Send {Raw}
return
<^>!j::
Suspend,permit
Send {Raw} 
return
<^>!ä::
Suspend,permit
Send {Raw} 
return
*/ 