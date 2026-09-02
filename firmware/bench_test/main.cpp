/*
 * ESP32CAM MicroDrone bench-test firmware
 * Purpose: verify IMU, four PWM motor outputs and XIAO Sense camera BEFORE installing props.
 * This is NOT flight-control firmware.
 */
#include <Arduino.h>
#include <Wire.h>
#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include "esp_camera.h"

static const int PIN_SDA = 2;
static const int PIN_SCL = 43;
static const int MOTOR_PINS[4] = {4, 3, 6, 5};
static const int PWM_HZ = 10000;
static const int PWM_BITS = 10;
Adafruit_MPU6050 mpu;

// XIAO ESP32-S3 Sense OV3660/OV2640 camera pin mapping
#define PWDN_GPIO_NUM     -1
#define RESET_GPIO_NUM    -1
#define XCLK_GPIO_NUM     10
#define SIOD_GPIO_NUM     40
#define SIOC_GPIO_NUM     39
#define Y9_GPIO_NUM       48
#define Y8_GPIO_NUM       11
#define Y7_GPIO_NUM       12
#define Y6_GPIO_NUM       14
#define Y5_GPIO_NUM       16
#define Y4_GPIO_NUM       18
#define Y3_GPIO_NUM       17
#define Y2_GPIO_NUM       15
#define VSYNC_GPIO_NUM    38
#define HREF_GPIO_NUM     47
#define PCLK_GPIO_NUM     13

bool cameraInit() {
  camera_config_t c{};
  c.ledc_channel = LEDC_CHANNEL_0;
  c.ledc_timer = LEDC_TIMER_0;
  c.pin_d0=Y2_GPIO_NUM; c.pin_d1=Y3_GPIO_NUM; c.pin_d2=Y4_GPIO_NUM; c.pin_d3=Y5_GPIO_NUM;
  c.pin_d4=Y6_GPIO_NUM; c.pin_d5=Y7_GPIO_NUM; c.pin_d6=Y8_GPIO_NUM; c.pin_d7=Y9_GPIO_NUM;
  c.pin_xclk=XCLK_GPIO_NUM; c.pin_pclk=PCLK_GPIO_NUM; c.pin_vsync=VSYNC_GPIO_NUM; c.pin_href=HREF_GPIO_NUM;
  c.pin_sccb_sda=SIOD_GPIO_NUM; c.pin_sccb_scl=SIOC_GPIO_NUM; c.pin_pwdn=PWDN_GPIO_NUM; c.pin_reset=RESET_GPIO_NUM;
  c.xclk_freq_hz=20000000;
  c.pixel_format=PIXFORMAT_JPEG;
  c.frame_size=FRAMESIZE_QVGA;
  c.jpeg_quality=18;
  c.fb_count=2;
  c.fb_location=CAMERA_FB_IN_PSRAM;
  c.grab_mode=CAMERA_GRAB_LATEST;
  return esp_camera_init(&c)==ESP_OK;
}

void motorsOff(){ for(int i=0;i<4;i++) ledcWrite(i,0); }
void pulseMotor(int idx){
  if(idx<0 || idx>3) return;
  Serial.printf("Pulsing motor %d for 250 ms at 12%%. REMOVE PROPS.\n",idx);
  ledcWrite(idx,123); delay(250); ledcWrite(idx,0);
}

void setup(){
  Serial.begin(115200); delay(1000);
  Serial.println("ESP32CAM MicroDrone bench test - PROPS MUST BE REMOVED");
  Wire.begin(PIN_SDA,PIN_SCL,400000);
  if(!mpu.begin(0x68,&Wire)) Serial.println("WARN: MPU6050 not found. If using MPU9250/GY-91, use upstream Open32Drone IMU backend.");
  else Serial.println("MPU6050 detected.");
  for(int i=0;i<4;i++){ ledcSetup(i,PWM_HZ,PWM_BITS); ledcAttachPin(MOTOR_PINS[i],i); }
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
      camera_fb_t* fb=esp_camera_fb_get();
      if(fb){ Serial.printf("JPEG frame: %u bytes\n",(unsigned)fb->len); esp_camera_fb_return(fb);} else Serial.println("capture failed");
    }
  }
  delay(5);
}
