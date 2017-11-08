
/*
Code writtent to provide a square wave output signal and measure a signal on AI0
 Uses delay() to sample at a fixed rate. Use the serial monitor to see the data. 
 Copy and Paste the data into excel.
 
 J. Kolodziej
04.12.16
 */

int k;
float currentTime;
float RPM;
float Vcmd;
int AI=8;
float Kp=6.2879;
float e;
float Vsp;
int i;
float T;
float Ki;
float e_prev;
float Vcmd_prev;
float b=-0.9194;
float c=-0.9575;
float Ktach=58.1395;
void setup()
{
  Serial.begin(9600); 
  Serial.println("time \t Vsp \t Vcmd \t RPM"); 
  k=0;
  Ki=8.83;
  T=0.05;
}




void loop()
{


  if (i < 8000000)
  {
      currentTime = millis()/1000.000;
      RPM = analogRead(AI)*5.00/1023*Ktach; //converted from 10bit to voltage
      
    // Set Point
      if (k<50) {
        Vsp=0;
      }
      else {
        Vsp=100;
      }
      k=k+1;
      i=i+1;
      if (k>100) {
        k=0;  
      }
    
    // Error
       e = Vsp - RPM;
        
    // Proportional Comp
      Vcmd = (1/Ktach)*Kp*e + (1/Ktach)*Kp*b*e_prev-c*Vcmd_prev;
          
    if (Vcmd>5) Vcmd=5;
    if (Vcmd<0) Vcmd=0;
    
    
      analogWrite(4, Vcmd/5.00*255);  
      
      
      Serial.print(currentTime);
      Serial.print("\t");    
      Serial.print(Vsp);
      Serial.print("\t");    
      Serial.print(Vcmd);
      Serial.print("\t");    
      Serial.print(RPM);
      Serial.print('\n');    // Setting up command signal. The delay and counter k set up the square wave frequency. 
      
      e_prev = e;
      Vcmd_prev = Vcmd;
      
      delay(50);
  }
  else
  {
    //do nothing
  }
  
}



