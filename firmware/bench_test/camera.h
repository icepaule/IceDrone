#pragma once
#include <stddef.h>

// Kept out of main.cpp: esp_camera.h's sensor.h and Adafruit_Sensor.h both
// declare a `sensor_t` typedef with incompatible underlying types, so they
// cannot be included in the same translation unit.
bool cameraInit();
bool cameraCaptureJpegLength(size_t &outLen);
