/*
 * IceDrone camera Wi-Fi smoke test - DIAGNOSTIC TOOL ONLY, not the V1 flight firmware.
 * Purpose: view the XIAO Sense camera live over the LAN before Open32Drone integration.
 * No motors, no IMU, no flight-control code. Safe to run on USB power alone.
 */
#include <Arduino.h>
#include <WiFi.h>
#include <esp_http_server.h>
#include "esp_camera.h"
#include "secrets.h"

// XIAO ESP32-S3 Sense OV3660/OV2640 camera pin mapping (see docs/04_FIRMWARE.md)
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

httpd_handle_t stream_httpd = NULL;

bool cameraInit() {
  camera_config_t c{};
  c.ledc_channel = LEDC_CHANNEL_0;
  c.ledc_timer = LEDC_TIMER_0;
  c.pin_d0=Y2_GPIO_NUM; c.pin_d1=Y3_GPIO_NUM; c.pin_d2=Y4_GPIO_NUM; c.pin_d3=Y5_GPIO_NUM;
  c.pin_d4=Y6_GPIO_NUM; c.pin_d5=Y7_GPIO_NUM; c.pin_d6=Y8_GPIO_NUM; c.pin_d7=Y9_GPIO_NUM;
  c.pin_xclk=XCLK_GPIO_NUM; c.pin_pclk=PCLK_GPIO_NUM; c.pin_vsync=VSYNC_GPIO_NUM; c.pin_href=HREF_GPIO_NUM;
  c.pin_sccb_sda=SIOD_GPIO_NUM; c.pin_sccb_scl=SIOC_GPIO_NUM; c.pin_pwdn=PWDN_GPIO_NUM; c.pin_reset=RESET_GPIO_NUM;
  c.xclk_freq_hz=10000000; // Kept at 10 MHz as safety margin: original camera module had a marginal FPC ribbon seat causing fb_get() to return NULL at 20 MHz; replacing the module fixed it, but 10 MHz gives more timing headroom against connector wear.
  c.pixel_format=PIXFORMAT_JPEG;
  c.frame_size=FRAMESIZE_QVGA;
  c.jpeg_quality=18;
  c.fb_count=2;
  c.fb_location=CAMERA_FB_IN_PSRAM;
  c.grab_mode=CAMERA_GRAB_WHEN_EMPTY;
  if (esp_camera_init(&c) != ESP_OK) return false;

  // Discard the first frame: on this sensor the pipeline needs one full
  // frame cycle after init before fb_get() reliably returns real data.
  delay(300);
  camera_fb_t* warmup = esp_camera_fb_get();
  if (warmup) {
    Serial.printf("[camera] warm-up frame: %u bytes\n", (unsigned)warmup->len);
    esp_camera_fb_return(warmup);
  } else {
    Serial.println("[camera] warm-up frame: NULL");
  }
  return true;
}

static esp_err_t stream_handler(httpd_req_t *req) {
  static const char* BOUNDARY = "\r\n--frame\r\n";
  static const char* CONTENT_TYPE = "multipart/x-mixed-replace;boundary=frame";
  static const char* PART_HEADER = "Content-Type: image/jpeg\r\nContent-Length: %u\r\n\r\n";

  Serial.println("[stream] client connected");
  esp_err_t res = httpd_resp_set_type(req, CONTENT_TYPE);
  if (res != ESP_OK) { Serial.printf("[stream] set_type failed: %d\n", res); return res; }

  char part_buf[64];
  int frame_count = 0;
  while (true) {
    uint32_t t0 = millis();
    camera_fb_t* fb = esp_camera_fb_get();
    uint32_t t1 = millis();
    if (!fb) { Serial.println("[stream] fb_get returned NULL"); res = ESP_FAIL; break; }
    Serial.printf("[stream] frame %d: %u bytes, fb_get took %u ms\n", frame_count++, (unsigned)fb->len, (unsigned)(t1 - t0));
    res = httpd_resp_send_chunk(req, BOUNDARY, strlen(BOUNDARY));
    if (res == ESP_OK) {
      size_t hlen = snprintf(part_buf, sizeof(part_buf), PART_HEADER, fb->len);
      res = httpd_resp_send_chunk(req, part_buf, hlen);
    }
    if (res == ESP_OK) {
      res = httpd_resp_send_chunk(req, (const char*)fb->buf, fb->len);
    }
    esp_camera_fb_return(fb);
    if (res != ESP_OK) { Serial.printf("[stream] send_chunk failed: %d (client likely disconnected)\n", res); break; }
  }
  Serial.println("[stream] handler exiting");
  return res;
}

void startCameraServer() {
  httpd_config_t config = HTTPD_DEFAULT_CONFIG();
  config.server_port = 80;
  httpd_uri_t stream_uri = { .uri = "/stream", .method = HTTP_GET, .handler = stream_handler, .user_ctx = NULL };
  if (httpd_start(&stream_httpd, &config) == ESP_OK) {
    httpd_register_uri_handler(stream_httpd, &stream_uri);
  }
}

void setup() {
  Serial.begin(115200);
  delay(1000);
  Serial.println("IceDrone camera Wi-Fi smoke test - diagnostic only, NOT flight firmware");

  Serial.printf("Camera: %s\n", cameraInit() ? "OK" : "FAILED");

  WiFi.mode(WIFI_STA);
  WiFi.begin(WIFI_SSID, WIFI_PASS);
  Serial.printf("Connecting to %s", WIFI_SSID);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println();
  Serial.printf("Connected. IP: %s\n", WiFi.localIP().toString().c_str());

  startCameraServer();
  Serial.printf("Stream ready: http://%s/stream\n", WiFi.localIP().toString().c_str());
}

void loop() {
  delay(1000);
}
