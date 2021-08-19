#include <FastLED.h>

#define NUM_LEDS 110
#define LED_PIN   5  // FIXME: Original used pin 6

CRGB leds[NUM_LEDS];
uint8_t colorIndex[NUM_LEDS];

DEFINE_GRADIENT_PALETTE( mfengineOn_gp ) {
    0,   1,  8, 87,
   71,  23,195,130,
  122, 186,248,233,
  168,  23,195,130,
  255,   1,  8, 87};

CRGBPalette16 mfengineOn = mfengineOn_gp;

void setup() {
  FastLED.addLeds<WS2812B, LED_PIN, GRB>(leds, NUM_LEDS);
  FastLED.setBrightness(10);  // FIXME: Original was 50
  engineOff();
  for (int i = 0; i < NUM_LEDS; i++) {
    colorIndex[i] = i;
  }  
}


void loop(){
  engineStart();
  delay(500);

  engineOn();
  delay(12000);

  engineOff();
  delay(1000);
  
  
}

void engineStart() {
    for(int i = 0; i <= NUM_LEDS/4; i++) {
    leds[27+i] = CRGB(0,212,255);
    leds[27-1-i] = CRGB(0,212,255);
    leds[82+i] = CRGB(0,212,255);
    leds[82-1-i] = CRGB(0,212,255);
    FastLED.show();
    delay(125);
    leds[27+i] = CRGB(255,255,255);
    leds[27-1-i] = CRGB(255,255,255);
    leds[82+i] = CRGB(255,255,255);
    leds[82-1-i] = CRGB(255,255,255);
  }
}

void engineOn() {

  uint8_t sinBeat = beatsin8(10, 50, 255, 0, 0);
  uint8_t sinBeat1 = beatsin8(30, 50, 255, 0, 60);
  uint8_t sinBeat2 = beatsin8(50, 50, 255, 0, 90);
  
  // Color each pixel from the palette using the index from colorIndex[]
  for (int i = 0; i < NUM_LEDS; i++) {
    leds[i] = ColorFromPalette(mfengineOn, colorIndex[i], sinBeat);
  }

  for (int i = 0; i < NUM_LEDS; i++) {
    leds[i] = ColorFromPalette(mfengineOn, colorIndex[i], sinBeat1);
  }

  for (int i = 0; i < NUM_LEDS; i++) {
    leds[i] = ColorFromPalette(mfengineOn, colorIndex[i], sinBeat2);
  }
  
  EVERY_N_MILLISECONDS(25){
    for (int i = 0; i < NUM_LEDS; i++) {
      colorIndex[i]++;
    }
  }

FastLED.show();

}

void engineOff()
{
    for(int i = 0; i <= NUM_LEDS/4; i++) {
    leds[54-i] = CRGB::Black;
    leds[0+i] = CRGB::Black;
    leds[109-i] = CRGB::Black;
    leds[55+i] = CRGB::Black;
    FastLED.show();
    delay(125);
}
}
