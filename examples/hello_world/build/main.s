;
; File generated by cc65 v 2.18 - Git 0f1a5e05
;
	.fopt		compiler,"cc65 v 2.18 - Git 0f1a5e05"
	.setcpu		"6502"
	.smart		on
	.autoimport	on
	.case		on
	.debuginfo	off
	.importzp	sp, sreg, regsave, regbank
	.importzp	tmp1, tmp2, tmp3, tmp4, ptr1, ptr2, ptr3, ptr4
	.macpack	longbranch
	.forceimport	__STARTUP__
	.export		_lcd_ready
	.export		_lcd_send_instruction
	.export		_lcd_send_char
	.export		_lcd_clear
	.export		_lcd_init
	.export		_lcd_print
	.export		_main

.segment	"RODATA"

L0073:
	.byte	$48,$65,$6C,$6C,$6F,$20,$77,$6F,$72,$6C,$64,$21,$00

; ---------------------------------------------------------------
; void __near__ lcd_ready (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_lcd_ready: near

.segment	"CODE"

;
; STA(_DDR_B, 0x00);
;
	lda     #$00
	sta     $6002
;
; STA(_PORT_A, 0x40);
;
L0007:	lda     #$40
	sta     $6001
;
; STA(_PORT_A, 0xc0);
;
	lda     #$C0
	sta     $6001
;
; if ((LDA(_PORT_B) & 0x10000000) != 0) {
;
	ldx     #$00
	lda     $6000
	jsr     axulong
	jsr     pusheax
	ldx     #$00
	stx     sreg
	lda     #$10
	sta     sreg+1
	txa
	jsr     tosandeax
	jsr     pusheax
	ldx     #$00
	stx     sreg
	stx     sreg+1
	txa
	jsr     tosneeax
;
; goto check;
;
	bne     L0007
;
; STA(_PORT_A, 0x40);
;
	lda     #$40
	sta     $6001
;
; STA(_DDR_B, 0xff);
;
	lda     #$FF
	sta     $6002
;
; }
;
	rts

.endproc

; ---------------------------------------------------------------
; void __near__ lcd_send_instruction (int)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_lcd_send_instruction: near

.segment	"CODE"

;
; void lcd_send_instruction(int instruction) {
;
	jsr     pushax
;
; lcd_ready();
;
	jsr     _lcd_ready
;
; STA(_PORT_B, instruction);
;
	ldy     #$00
	lda     (sp),y
	sta     $6000
;
; STA(_PORT_A, 0x00);
;
	sty     $6001
;
; STA(_PORT_A, 0x80);
;
	lda     #$80
	sta     $6001
;
; STA(_PORT_A, 0x00);
;
	sty     $6001
;
; }
;
	jmp     incsp2

.endproc

; ---------------------------------------------------------------
; void __near__ lcd_send_char (unsigned char)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_lcd_send_char: near

.segment	"CODE"

;
; void lcd_send_char(char ch) {
;
	jsr     pusha
;
; lcd_ready();
;
	jsr     _lcd_ready
;
; STA(_PORT_B, ch);
;
	ldy     #$00
	lda     (sp),y
	sta     $6000
;
; STA(_PORT_A, 0x20);
;
	lda     #$20
	sta     $6001
;
; STA(_PORT_A, 0xa0);
;
	lda     #$A0
	sta     $6001
;
; STA(_PORT_A, 0x20);
;
	lda     #$20
	sta     $6001
;
; }
;
	jmp     incsp1

.endproc

; ---------------------------------------------------------------
; void __near__ lcd_clear (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_lcd_clear: near

.segment	"CODE"

;
; lcd_send_instruction(0x01);
;
	ldx     #$00
	lda     #$01
	jmp     _lcd_send_instruction

.endproc

; ---------------------------------------------------------------
; void __near__ lcd_init (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_lcd_init: near

.segment	"CODE"

;
; STA(_DDR_B, 0xff);
;
	lda     #$FF
	sta     $6002
;
; STA(_DDR_A, 0xe0);
;
	lda     #$E0
	sta     $6003
;
; lcd_send_instruction(0x38);
;
	ldx     #$00
	lda     #$38
	jsr     _lcd_send_instruction
;
; lcd_send_instruction(0x0e);
;
	ldx     #$00
	lda     #$0E
	jsr     _lcd_send_instruction
;
; lcd_send_instruction(0x06);
;
	ldx     #$00
	lda     #$06
	jsr     _lcd_send_instruction
;
; lcd_send_instruction(0x01);
;
	ldx     #$00
	lda     #$01
	jmp     _lcd_send_instruction

.endproc

; ---------------------------------------------------------------
; void __near__ lcd_print (__near__ unsigned char *)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_lcd_print: near

.segment	"CODE"

;
; void lcd_print(char *text) {
;
	jsr     pushax
;
; for (t = text; *t != '\0'; t++) {
;
	jsr     decsp2
	ldy     #$03
	jsr     ldaxysp
L0077:	jsr     stax0sp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	beq     L0067
;
; lcd_send_char(*t);
;
	jsr     ldax0sp
	sta     ptr1
	stx     ptr1+1
	ldy     #$00
	lda     (ptr1),y
	jsr     _lcd_send_char
;
; for (t = text; *t != '\0'; t++) {
;
	jsr     ldax0sp
	jsr     incax1
	jmp     L0077
;
; }
;
L0067:	jmp     incsp4

.endproc

; ---------------------------------------------------------------
; int __near__ main (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_main: near

.segment	"CODE"

;
; lcd_init();
;
	jsr     _lcd_init
;
; lcd_print("Hello world!");
;
	lda     #<(L0073)
	ldx     #>(L0073)
	jsr     _lcd_print
;
; return 0;
;
	ldx     #$00
	txa
;
; }
;
	rts

.endproc
