#include <Servo.h>
#include <Ultrasonic.h>

const int buzzerPin = 8;
const int servoPin = 9;
const int triggerPin = 12;
const int echoPin = 11;

Servo myservo; 
Ultrasonic ultrasonic(triggerPin, echoPin);

long distance;

int printDistance(int i, int distance) {
    Serial.print(i);
    Serial.print(",");
    Serial.print(distance);
    Serial.println(".");
};

void beepBuzzer(int beepInterval){
  digitalWrite(buzzerPin, HIGH);
  delay(beepInterval);
  digitalWrite(buzzerPin, LOW);
  delay(beepInterval);
}

void setup() {
  // put your setup code here, to run once:
  pinMode(buzzerPin, OUTPUT);
  myservo.attach(servoPin);
  Serial.begin(9600); 
}

void loop() {
  // put your main code here, to run repeatedly:
  for(int i = 0; i<= 180; i++){
    myservo.write(i);
    delay(20);
    distance =ultrasonic.read();
    printDistance(i,distance);

    if(distance < 40){
      int beepInterval = map(distance, 40, 0, 30, 1);
      beepBuzzer(beepInterval);
    }

  }
  for(int i = 180; i>= 0; i--){
    myservo.write(i);
    delay(20);
     distance =ultrasonic.read();
    printDistance(i,distance);

      if(distance < 40){
      int beepInterval = map(distance, 40, 0, 30, 1);
      
    }
  }
}






