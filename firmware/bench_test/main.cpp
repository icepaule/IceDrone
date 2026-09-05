/*
 * ESP32CAM MicroDrone bench-test firmware
 * Purpose: verify IMU, four PWM motor outputs and XIAO Sense camera BEFORE installing props.
 * This is NOT flight-control firmware.
 */
#include <Arduino.h>
#include <Wire.h>
#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include "camera.h"

static const int PIN_SDA = 2;
static const int PIN_SCL = 43;
static const int MOTOR_PINS[4] = {4, 3, 6, 5};
static const int PWM_HZ = 10000;
static const int PWM_BITS = 10;
Adafruit_MPU6050 mpu;

// ESP32 Arduino core 3.x LEDC API is pin-based (ledcAttach/ledcWrite take the
// GPIO directly); there is no separate channel argument to manage anymore.
void motorsOff(){ for(int i=0;i<4;i++) ledcWrite(MOTOR_PINS[i],0); }
void pulseMotor(int idx){
  if(idx<0 || idx>3) return;
  Serial.printf("Pulsing motor %d for 250 ms at 12%%. REMOVE PROPS.\n",idx);
  ledcWrite(MOTOR_PINS[idx],123); delay(250); ledcWrite(MOTOR_PINS[idx],0);
}

void setup(){
  Serial.begin(115200); delay(1000);
  Serial.println("ESP32CAM MicroDrone bench test - PROPS MUST BE REMOVED");
  Wire.begin(PIN_SDA,PIN_SCL,400000);
  if(!mpu.begin(0x68,&Wire)) Serial.println("WARN: MPU6050 not found. If using MPU9250/GY-91, use upstream Open32Drone IMU backend.");
  else Serial.println("MPU6050 detected.");
  for(int i=0;i<4;i++){ ledcAttach(MOTOR_PINS[i],PWM_HZ,PWM_BITS); }
  motorsOff();
  Serial.printf("Camera: %s\n",cameraInit()?"OK":"FAILED");
  Serial.println("Commands: 0/1/2/3 pulse a motor; i = print IMU; c = capture one JPEG length; x = motors off");
}

void loop(){
  if(Serial.available()){
    char ch=Serial.read();
    if(ch>='0'&&ch<='3') pulseMotor(ch-'0');
    else if(ch=='x') motorsOff();
    else if(ch=='i'){
      sensors_event_t a,g,t; mpu.getEvent(&a,&g,&t);
      Serial.printf("ACC %.3f %.3f %.3f | GYR %.3f %.3f %.3f\n",a.acceleration.x,a.acceleration.y,a.acceleration.z,g.gyro.x,g.gyro.y,g.gyro.z);
    } else if(ch=='c'){
      size_t len=0;
      if(cameraCaptureJpegLength(len)) Serial.printf("JPEG frame: %u bytes\n",(unsigned)len);
      else Serial.println("capture failed");
    }
  }
  delay(5);
}
