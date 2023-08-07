#SingleInstance force
SetWorkingDir A_ScriptDir

!n::RunWait "komorebic focus left",, "Hide"
!e::RunWait "komorebic focus down",, "Hide"
!u::RunWait "komorebic focus up",, "Hide"
!i::RunWait "komorebic focus right",, "Hide"

!+n::RunWait "komorebic move left",, "Hide"
!+e::RunWait "komorebic move down",, "Hide"
!+u::RunWait "komorebic move up",, "Hide"
!+i::RunWait "komorebic move right",, "Hide"

!^+n::RunWait "komorebic stack left",, "Hide"
!^+e::RunWait "komorebic stack down",, "Hide"
!^+u::RunWait "komorebic stack up",, "Hide"
!^+i::RunWait "komorebic stack right",, "Hide"

!l::RunWait "komorebic cycle-workspace previous",, "Hide"
!y::RunWait "komorebic cycle-workspace next",, "Hide"
!+l::RunWait "komorebic cycle-move-to-workspace previous",, "Hide"
!+y::RunWait "komorebic cycle-move-to-workspace next",, "Hide"

!^n::RunWait "komorebic cycle-stack previous",, "Hide"
!^i::RunWait "komorebic cycle-stack next",, "Hide"
!a::RunWait "komorebic unstack",, "Hide"

!m::RunWait "komorebic minimize",, "Hide"
!f::RunWait "komorebic toggle-monocle",, "Hide"
!+f::RunWait "komorebic toggle-maximize",, "Hide"
!+Space::RunWait "komorebic toggle-float",, "Hide"

!+q::RunWait "komorebic close",, "Hide"
!+r::RunWait "schtasks /run /tn WMRestart",, "Hide"

!1::RunWait "komorebic focus-workspace 0",, "Hide"
!2::RunWait "komorebic focus-workspace 1",, "Hide"
!3::RunWait "komorebic focus-workspace 2",, "Hide"
!4::RunWait "komorebic focus-workspace 3",, "Hide"
!5::RunWait "komorebic focus-workspace 4",, "Hide"
!6::RunWait "komorebic focus-workspace 5",, "Hide"
!7::RunWait "komorebic focus-workspace 6",, "Hide"
!8::RunWait "komorebic focus-workspace 7",, "Hide"
!9::RunWait "komorebic focus-workspace 8",, "Hide"

!+1::RunWait "komorebic move-to-workspace 0",, "Hide"
!+2::RunWait "komorebic move-to-workspace 1",, "Hide"
!+3::RunWait "komorebic move-to-workspace 2",, "Hide"
!+4::RunWait "komorebic move-to-workspace 3",, "Hide"
!+5::RunWait "komorebic move-to-workspace 4",, "Hide"
!+6::RunWait "komorebic move-to-workspace 5",, "Hide"
!+7::RunWait "komorebic move-to-workspace 6",, "Hide"
!+8::RunWait "komorebic move-to-workspace 7",, "Hide"
!+9::RunWait "komorebic move-to-workspace 8",, "Hide"
