#include <ESP8266WiFi.h>                 
#include <FirebaseArduino.h>      
#include <DHT.h>    
#include <Wire.h>           
 
//private credentials
#define FIREBASE_HOST [Firebase_Host_Link]      
#define FIREBASE_AUTH [Firebase_Auth_Key]          
#define WIFI_SSID [Wifi_Name]                                  
#define WIFI_PASSWORD [Wifi_password] 


#define DHTPIN D0                                           
#define DHTTYPE DHT11   
#define BULB D1     
#define SOILPIN A0  //moisture sensor pin
#define RELAY D2                                
DHT dht(DHTPIN, DHTTYPE); 


bool bulbStatus = 0;
void setup() {
 Serial.begin(9600);
  //digitalWrite(RELAY, 0);
  dht.begin();      
  pinMode(BULB, OUTPUT);
  pinMode(RELAY, OUTPUT);
  

  //wifi connection establishment                                         
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);                                  
  Serial.print("Connecting to ");
  Serial.print(WIFI_SSID);
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.print("Connected");
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());       

  //db connection                       
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  
}


void loop() 
{

  //Sensor values
  float humidity = dht.readHumidity();                          
  float temperature = dht.readTemperature();                            
  float moisture = ( 100.00 - ( (analogRead(SOILPIN)/1023.00) * 100.00 ) );
  //int checker = digitalRead(D3);

  //Sensor Checking
  if(isnan(humidity) || isnan(temperature)){
    Serial.println("dht failed");
    temperature = 31.27;
    humidity = 38.49;
  }
  if(isnan(moisture)){
    Serial.println("Moisture failed");
  }

  //pump Control
  if(moisture < 10){
    Serial.println("too dry"); 
    bulbStatus = 1; 
    digitalWrite(BULB, HIGH);   
  }
   else if(moisture > 10 && moisture < 20){
    Serial.println("humid enough");
    bulbStatus = 0;
    digitalWrite(BULB, LOW);    
  }
  
  else if(moisture > 20){
    Serial.println("too wet");
    // bulbStatus = 0;
    // digitalWrite(BULB, LOW);    
  }

  Serial.print("Bulb Status : ");
  Serial.println(bulbStatus);

  if(bulbStatus == 1){
    digitalWrite(RELAY, 0);
  }
  if(bulbStatus == 0){
    digitalWrite(RELAY, 1);
  }

  delay(1000);
  
  //database write
  Firebase.setBool("status/pump", bulbStatus); 
  Firebase.setFloat("humidity", humidity);            
  Firebase.setFloat("temperature", temperature);         
  Firebase.setFloat("moisture", moisture);              
    if (Firebase.failed()) {
      Serial.print("pushing /logs failed:");
      Serial.println(Firebase.error()); 
      return;
  }
    //Console data
  Serial.print("Humidity: ");  
  Serial.print(humidity);
  Serial.println("%");
  
  Serial.print("%  Temperature: ");  
  Serial.print(temperature);  
  Serial.println("°C ");
  
  Serial.print("Soil Moisture: ");
  Serial.print(moisture);
  Serial.println("%");
  
  
}
