/*
 * C/RAM Wing Memory test 
 * Tests memory for rolling memory configuration
 *
 * Version 1.0 4/21/2011
 * This example code is in the Public Domain
 *
 * Created for the Papilio Platform 4/21/2011 by Jack Gassett
 * http://Papilio.cc
 * Documentation for the AVR8 is located at: http://papilio.cc/index.php?n=Papilio.ArduinoCore
 * Documentation for the AVR8 is located at: http://papilio.cc/index.php?n=Papilio.CustomAVR8UserCore 
 *
 */

struct{
    unsigned int clock : 1;
    unsigned int read : 1;    
    unsigned int write : 1;
    unsigned int data : 13;
} cram;


void setup()
{
  DDRA = 0xFF;
  DDRB = 0xFF;

  cram.write = LOW;
  cram.read = LOW;
  cram.clock = LOW;
  PORTA = _SFR_MEM8(&cram);

  Serial.begin(9600);
  Serial.flush(); 
}

void cramWrite(uint16_t data)
{
    DDRA = 0xFF;
    DDRB = 0xFF;
    
    cram.data = data;
    cram.write = HIGH;
    PORTA = _SFR_MEM8(&cram);
    PORTB = _SFR_MEM16(&cram)>>8;    
    cram.clock = HIGH;
    PORTA = _SFR_MEM8(&cram);
    
    cram.write = LOW;
    cram.clock = LOW;
    PORTA = _SFR_MEM8(&cram);
}

void cramRead()
{
    DDRA = 0x07;
    DDRB = 0x00;
    
    cram.read = HIGH;
    PORTA = _SFR_MEM8(&cram);   
    cram.clock = HIGH;
    PORTA = _SFR_MEM8(&cram);
    
    _SFR_MEM16(&cram) = PINB<<8;
    _SFR_MEM8(&cram) = PINA;   
    
    cram.read = LOW;
    cram.clock =  LOW; 
    PORTA = _SFR_MEM8(&cram);
}

void loop() 
{
  Serial.println("Press any key to start C/RAM memory test."); 
  delay(2000);
  
  if (Serial.available() > 0) {  
    Serial.flush();    
    
    for(int i=1; i<(8*1024); i++){
       cramWrite(i);
    }
    
    for(int i=1; i<(8*1024); i++){
       cramRead();
       Serial.println(cram.data, DEC); 
    }      
  }

}
