
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
float Vcmd;
int AI=8;
float Vsp=0;
float kp=2.5;

void setup()
{
  Serial.begin(9600); 
  Serial.println("time \t Vsp \t Vcmd \t Vcap"); 
  k=0;
}

void loop()
{
  currentTime = millis()/1000.000;
  Vcap = analogRead(AI)*5.00/1023;

  if (k<50) {
    Vsp=2;
  }
  else {
    Vsp=0;
  }
  k=k+1;
  if (k>100) {
    k=0;  
  }
  Vcmd=kp*(Vsp-Vcap);
  if (Vcmd>5) {
    Vcmd = 5;
  }
  if (Vcmd<0) {
    Vcmd = 0;
  } 
  
  analogWrite(4, Vcmd/5.00*255);
    
  Serial.print(currentTime);
  Serial.print("\t");    
  Serial.print(Vsp);
  Serial.print("\t");
  Serial.print(Vcmd);
  Serial.print("\t"); 
  Serial.print(Vcap);
  Serial.print('\n');    // Setting up command signal. The delay and counter k set up the square wave frequency. 
  delay(50);
}



