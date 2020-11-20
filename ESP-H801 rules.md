//Pinout:
//R	            GPIO 15	PWM1
//G	            GPIO 13	PWM2
//B	            GPIO 12	PWM3
//W1	        GPIO 14	PWM4
//W2        	GPIO 04	PWM5
//LED D1(r) 	GPIO 05	
//LED D2 (g)	GPIO 01	


on System#Boot do
 //Turn everything off on boot
 PWM,15,0
 PWM,13,0
 PWM,12,0
 PWM,14,0
 PWM,4,0
 TaskValueSet,1,1,0
 TaskValueSet,2,1,0
 TaskValueSet,2,2,0
 TaskValueSet,2,3,0
 TaskValueSet,2,4,0
endon

on dimup_white do
 timerset,2,0
 timerSet,1,1
endon

on dimdown_white do
 timerset,1,0
 timerSet,2,1
endon

on Rules#Timer=1 do
 if [White#pct] < 600
   TaskValueSet,1,1,[White#pct]+1
   PWM,4,[White#pct]
   PWM,14,[White#pct]
   timerSet,1,1
 endif
endon

on Rules#Timer=2 do
 if [White#pct] > 0
   TaskValueSet,1,1,[White#pct]-1
   PWM,4,[White#pct]
   PWM,14,[White#pct]
   timerSet,2,1
 endif
endon

On Clock#Time=All,10:00 do
 event,dimup_white
endon

On Clock#Time=All,14:00 do
 event,dimdown_white
endon

On Clock#Time=All,16:00 do
 event,dimup_white
endon

On Clock#Time=All,20:00 do
 event,dimdown_white
endon

on White#pct do
 PWM,4,[White#pct]
 PWM,14,[White#pct]
endon

On RebootHTTP Do
 reboot
EndOn
