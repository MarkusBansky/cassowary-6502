//
// Created by Markiian Benovskyi on 10/08/2020.
//

#ifndef CASSOWARY_6502_CASSOWARY_6502_H
#define CASSOWARY_6502_CASSOWARY_6502_H

#define _PORT_B 0x6000
#define _PORT_A 0x6001
#define _DDR_B  0x6002
#define _DDR_A  0x6003

#define _E       0b10000000
#define _RW      0b01000000
#define _RS      0b00100000

#define STA(addr, val)  (*(unsigned char*) (addr) = (val))
//#define LCD_STATUS (*(volatile unsigned int *) _PORT_B)
#define LDA(addr) (*(unsigned char*) (addr))

//void lcd_ready() {
//    STA(_DDR_B, 0x00);
//
//check:
//    STA(_PORT_A, 0x40);
//    STA(_PORT_A, 0xc0);
//    if ((LDA(_PORT_B) & 0x10000000) != 0) {
//        goto check;
//    }
//
//    STA(_PORT_A, 0x40);
//    STA(_DDR_B, 0xff);
//}

//void lcd_send_instruction(int instruction) {
////    lcd_ready();
//
//    STA(_PORT_B, instruction);
//
//    STA(_PORT_A, 0x00);
//    STA(_PORT_A, 0x80);
//    STA(_PORT_A, 0x00);
//}

//void lcd_send_char(char ch) {
//    lcd_ready();
//
//    STA(_PORT_B, ch);
//
//    STA(_PORT_A, 0x20);
//    STA(_PORT_A, 0xa0);
//    STA(_PORT_A, 0x20);
//}

//void lcd_clear() {
//    lcd_send_instruction(0x01);
//}

void lcd_init() {
    STA(_DDR_B, 0b11111111);
    STA(_DDR_A, 0b11100000);

//    lcd_send_instruction(0b00111000);
//
//    lcd_send_instruction(0b00001110);
//
//    lcd_send_instruction(0b00000110);
//
//    lcd_send_instruction(0b00000001);
}

//void lcd_print(char *text) {
//    for (char character = *text; character != '\0'; character = *++text) {
//        lcd_send_char(character);
//    }
//}

#endif //CASSOWARY_6502_CASSOWARY_6502_H
