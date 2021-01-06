/**********************************************
 El siguiente programa revisa si el boton en
 PD0(ON) se presiono y prende LED(PB4), si se
 presiona PD3(OFF), se apaga el LED.
********************************************/
.INCLUDE "TN2313DEF.inc"
.CSEG
.ORG 0

           LDI  R16,LOW(RAMEND)
		   OUT  SPL,R16
		   LDI  R16,0x00        ;R16 <-- 0b0000_0000
		   OUT  DDRD,R16        ;DDR<D> <-- R16 (CONF. I/O)
		   LDI  R16,0x10        ;R16 <-- 0b0001_0000
		   OUT  DDRB,R16        ;DDR<B> <-- R16 (CONF. I/O)
LECTURA_BO:
           IN   R17,PIND        ;R17 <-- LEER(PIN<D>)
           LDI  R18,0x09        ;R18 <-- 0b0000_1001
		   AND  R17,R18         ;R17 <-- R17 AND R18 (Enmascaramiento)
		   LDI  R18,0x01        ;R18 <-- 0b0000_0001
		   CP   R17,R18         ;IF(R17 == R18)
		   BREQ LED_ON          ;   SI --> SALTA A LED_ON
		   LDI  R18,0x08        ;   NO --> R18<-- 0b0000_1000
		   CP   R17,R18         ;          IF(R17 == R19)
		   BREQ LED_OFF         ;             SI --> SALTA A LED_OFF
		   RJMP LECTURA_BO      ;             NO --> SALTA A LECTURA_BO
LED_ON:
           LDI  R16,0x10        ;R16 <-- 0b0001_0000
		   OUT  PORTB,R16       ;PORT<B> <-- R16
		   RJMP LECTURA_BO      ; saltar a LECTURA_BO
LED_OFF:
           LDI  R16,0x00        ;R16 <-- 0b0000_0000
		   OUT  PORTB,R16       ;PORT<B> <-- R16
		   RJMP LECTURA_BO



