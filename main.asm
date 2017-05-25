;||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
;||------------------------------13.05.2017------------------------------||
;||----------------------------Ferhat Inalkac----------------------------||
;||----------Mikroislemci Tabanli Sistem Tasarimi Donem Projesi----------||
;||------------Bluetooth ve PWM Kontrollu Model Arac Tasarimi------------||
;||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
org 00h
sjmp main
org 0bh
sjmp pwm_kesme
org 0023h
sjmp seri_kesme
org 30h
main:
;--------------------PIN ATAMALARI
motorSag_ileri equ p1.0
motorSag_geri equ p1.1
motorSol_ileri equ p1.2
motorSol_geri equ p1.3
;--------------------PWM KONTROL
pwm equ r1
pwm_pin equ p1.4
mov th0,#00h
mov tl0,#00h
mov r2,#255
mov r1,#00h
setb et0
setb tr0
;--------------------INTERRUPT VE TIMER KONTROL
mov tmod,#21h
mov scon,#50h
mov th1,#-3
setb tr1
setb es
setb ea
sjmp $
;--------------------PWM KESMESI
pwm_kesme:
clr tr0
jb pwm_pin,dongu1
sjmp dongu2
dongu1:
clr pwm_pin
mov a,#255
subb a,pwm
mov r0,a
mov a,#0ffh
subb a,r0
mov th0,#0ffh
mov tl0,a
sjmp bitir
dongu2:
setb pwm_pin
mov a,#0ffh
subb a,pwm
mov th0,#0ffh
mov tl0,a
bitir:
setb tr0
reti
;--------------------SERI HABERLESME KESMESI
seri_kesme:
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
cjne a,#"L",Gdurumu
setb motorSag_ileri
clr motorSag_geri
clr motorSol_ileri
setb motorSol_geri
reti
Gdurumu:
cjne a,#"G",Idurumu
setb motorSag_ileri
clr motorSag_geri
clr motorSol_ileri
clr motorSol_geri
reti
Idurumu:
cjne a,#"I",Hdurumu
clr motorSag_ileri
clr motorSag_geri
setb motorSol_ileri
clr motorSol_geri
reti
Hdurumu:
cjne a,#"H",Jdurumu
clr motorSag_ileri
setb motorSag_geri
clr motorSol_ileri
clr motorSol_geri
reti
Jdurumu:
cjne a,#"J",HIZ1
clr motorSag_ileri
clr motorSag_geri
clr motorSol_ileri
setb motorSol_geri
reti
HIZ1:
cjne a,#"1",HIZ2
mov pwm,#25
reti
HIZ2:
cjne a,#"2",HIZ3
mov pwm,#50
reti
HIZ3:
cjne a,#"3",HIZ4
mov pwm,#75
reti
HIZ4:
cjne a,#"4",HIZ5
mov pwm,#100
reti
HIZ5:
cjne a,#"5",HIZ6
mov pwm,#125
reti
HIZ6:
cjne a,#"6",HIZ7
mov pwm,#150
reti
HIZ7:
cjne a,#"7",HIZ8
mov pwm,#175
reti
HIZ8:
cjne a,#"8",HIZ9
mov pwm,#200
reti
HIZ9:
cjne a,#"9",HIZ10
mov pwm,#225
reti
HIZ10:
cjne a,#"q",Ddurumu
mov pwm,#255
reti
Ddurumu:
cjne a,#"D",dur1
dur1:
clr motorSag_ileri
clr motorSag_geri
clr motorSol_ileri
clr motorSol_geri
reti
end