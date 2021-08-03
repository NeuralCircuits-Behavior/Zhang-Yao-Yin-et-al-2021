
const int outputSTP = 13; 
const int outputDIR = 6; 
const int outputENA = 4;
int DelayTime;
char ch;

void setup() {
 Serial.begin(9600);
 pinMode(outputSTP,OUTPUT); 
 pinMode(outputDIR,OUTPUT); 
              }

void loop()
{
ch = Serial.read();

    if (ch=='a')
   {  
 digitalWrite(outputDIR, LOW);
 digitalWrite(outputENA, LOW);
    for (int i=1; i<268;i++)
    {
      if (i<268)
        {DelayTime=2;}
      else 
        {DelayTime=1;}
        
      digitalWrite(outputSTP, HIGH);
      delay(DelayTime);                       
      digitalWrite(outputSTP, LOW); 
      delay(DelayTime); 
    }


     
    }
    else if (ch  =='f')
    {digitalWrite(outputENA, HIGH);
      }
    
      else if (ch=='z')
   {  
 digitalWrite(outputDIR, HIGH);
 digitalWrite(outputENA, LOW);
    for (int i=1; i<268;i++)
    {
      if (i<268)
        {DelayTime=2;}
      else 
        {DelayTime=1;}
      
 digitalWrite(outputSTP, HIGH);
 delay(DelayTime);                       
 digitalWrite(outputSTP, LOW); 
 delay(DelayTime); 
    }
     
    }
   }
 
