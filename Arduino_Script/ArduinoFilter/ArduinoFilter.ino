
int pinInterruptA = 2; // The pin to receive pulse from motor controller corresponding to count2.
const int output = 13; // The pin to trigger PulsePal.
volatile long count = 0;
volatile long Judge = 0;

void blinkA()
{
         digitalWrite(output,HIGH);
         delay(1);
         digitalWrite(output,LOW);
}


void setup() {
 attachInterrupt(digitalPinToInterrupt(pinInterruptA),blinkA,FALLING);
 
 pinMode(pinInterruptA,INPUT_PULLUP);
 
 pinMode(output,OUTPUT); 
              }

void loop()
{
 }
