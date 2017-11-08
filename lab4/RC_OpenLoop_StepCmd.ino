
/*
Code writtent to provide a square wave output signal and measure a signal on AI0
 Uses delay() to sample at a fixed rate. Use the serial monitor to see the data. 
 Copy and Paste the data into excel.
 
 J. Kolodziej
04.12.16
 */

int k;
float currentTime;
float Vcap;
float Vsp;
int AI=8;

void setup()
{
  Serial.begin(9600); 
  Serial.println("time \t Vcmd \t Vcap"); 
  k=0;
}

void loop()
{
  currentTime = millis()/1000.000;
  Vcap = analogRead(AI)*5.00/1023;
  if (k<100) {
    Vsp=2;
  }
  else {
    Vsp=0;
  }
  k=k+1;
  if (k>200) {
    k=0;  
  }
  delay(50);
  analogWrite(4, Vsp/5.00*255);  
  Serial.print(currentTime);
  Serial.print("\t");    
  Serial.print(Vsp);
  Serial.print("\t");    
  Serial.print(Vcap);
  Serial.print('\n');    // Setting up command signal. The delay and counter k set up the square wave frequency. 
}



