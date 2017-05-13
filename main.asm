;13.05.2017
;Ferhat Inalkaç
;Mikroislemci Tabanli Sistem Tasarimi Dönem Projesi
;Bluetooth Kontrollü Model Araç Tasarimi
org 00h
sjmp main
org 0023h
sjmp veri
org 30h
main:
motorSag_ileri equ p1.0
motorSag_geri equ p1.1
motorSol_ileri equ p1.2
motorSol_geri equ p1.3
hiz_kontrol equ p1.4
mov tmod,#20h
mov scon,#50h
mov th1,#-3
setb tr1
setb es
setb ea
sjmp $

veri:
clr ri
mov a,sbuf
cjne a,#"S",ileri
dur:
clr motorSag_ileri
clr motorSag_geri
clr motorSol_ileri
clr motorSol_geri
reti
ileri:
cjne a,#"F",geri
setb motorSag_ileri
clr motorSag_geri
setb motorSol_ileri
clr motorSol_geri
reti
geri:
cjne a,#"B",sag
clr motorSag_ileri
setb motorSag_geri
clr motorSol_ileri
setb motorSol_geri
reti
sag:
cjne a,#"R",sol
clr motorSag_ileri
setb motorSag_geri
setb motorSol_ileri
clr motorSol_geri
reti
sol:
cjne a,#"L",dur
setb motorSag_ileri
clr motorSag_geri
clr motorSol_ileri
setb motorSol_geri
reti
end