
// Arduino MEGA2560
////////////////////////////////////////////////
//        CO2 advection measurement
///////////////////////////////////////////////
// Peng Zhao
// Institute of Ecology, University of Innsbruck
// This script is used to control valves in the CO2 advection measurement. Cowork with the script advection_logger.CR1 uploaded to Datalogger.
// Updates
// 2015-01-21, created. Test basic functions.
// 2015-03-18, control valves with no valve delivered yet.
// 2018-06-15, adapted to an additional inlet.


//////// declarations ////////////////////////
int thisPin; // pins to use
char fromChar; // Where to store the character read
String fromString = ""; // Where to concatenate fromChar into a string
String tempString = "";
byte index = 0; // Index into array; where to store fromChar in fromString
int nmbrPin; // Pin to output (switch on the valve)
String toString = ""; // Where to store the string to be sent to Datalogger
//const int maxPin = 53;
const int minPin = 13;
int i;

//////// initiation at start up
void setup() {
  Serial.begin(9600);  // Open the serial port connected to PC USB port
  Serial3.begin(9600); // Open the serial port 3, connected to Datalogger
  while (!Serial3) {
    ; // wait for serial port to connect
  }
}

//////// main program
void loop() {

  if (Serial3.available() > 0) {
    //Serial.println("Time since started: " + String(micros()));
    //// set pins as output to control valves
    for (thisPin = 22; thisPin < 55; thisPin++) {
      pinMode(thisPin, OUTPUT);
    }
    for (thisPin = 16; thisPin < 20; thisPin++) {
      pinMode(thisPin, OUTPUT);
    }

    //// receive characters from Datalogger and concatenate them into a 2-digit integer
    if (index < 2) // One less than the size of the array
    {
      fromChar = Serial3.read(); // Read a character
      //      fromChar = Serial.read(); // Read a character
      fromString += (char)fromChar; // Store it
      index++; // Increment where to write next

      //      tempString += (char)fromChar; // Store it
      //      nmbrPin = int(tempString.toFloat());
      //      if (nmbrPin == 6) {
      //        index = 0;
      //        tempString = "";
      //        fromString = "";
      // }

    }
    //// when a 2-digit integer is received
    else {
      nmbrPin = int(fromString.toFloat());
      Serial.println(fromString + '-' + String(nmbrPin));
      if (nmbrPin == 99) {
        // switch off all valves
        for (thisPin = 22; thisPin < 55; thisPin++) {
          digitalWrite(thisPin, LOW);
        }
        digitalWrite(45, HIGH);
        digitalWrite(23, HIGH);
        Serial.println("pin " + String(23) + " on");
        digitalWrite(24, HIGH);
        Serial.println("pin " + String(24) + " on");
        toString = String(23) + "," + String(24);
        for (thisPin = 16; thisPin < 20; thisPin++) {
          digitalWrite(thisPin, LOW);
        }
        Serial.println("pin " + String(nmbrPin) + " off");

      }
      else if (nmbrPin < 45) {
        // switch off all valves
        for (thisPin = 22; thisPin < 55; thisPin++) {
          digitalWrite(thisPin, LOW);
        }
        digitalWrite(nmbrPin, HIGH);
        Serial.println("pin " + String(nmbrPin) + " on");
        digitalWrite(nmbrPin + 2, HIGH);
        Serial.println("pin " + String(nmbrPin + 2) + " on");
        digitalWrite(nmbrPin + 3, HIGH);
        Serial.println("pin " + String(nmbrPin + 3) + " on");
        toString = String(nmbrPin) + "," + String(nmbrPin + 2) + "," + String(nmbrPin + 3);
      }
      else if (nmbrPin == 45) {
        // switch off all valves
        for (thisPin = 22; thisPin < 55; thisPin++) {
          digitalWrite(thisPin, LOW);
        }
        digitalWrite(nmbrPin, HIGH);
        Serial.println("pin " + String(nmbrPin) + " on");
        toString = String(nmbrPin);
      }
      else if (nmbrPin == 97) {
        // switch off all valves
        for (thisPin = 22; thisPin < 55; thisPin++) {
          digitalWrite(thisPin, LOW);
        }
        digitalWrite(22, HIGH);
        Serial.println("pin " + String(22) + " on");
        toString = String(nmbrPin) + "," + String(nmbrPin + 1) + "," + String(22);
      }
      else if (nmbrPin == 47) {
        // switch off all valves
        for (thisPin = 22; thisPin < 55; thisPin++) {
          digitalWrite(thisPin, LOW);
        }
        digitalWrite(53, HIGH);
        Serial.println("pin " + String(53) + " on");
        digitalWrite(47, HIGH);
        Serial.println("pin " + String(nmbrPin) + " on");
        digitalWrite(48, HIGH);
        Serial.println("pin " + String(nmbrPin + 1) + " on");
        toString = String(nmbrPin) + "," + String(nmbrPin + 1) + "," + String(53);
      }
      else if (nmbrPin == 75) {
        // switch off all valves
        for (thisPin = 22; thisPin < 55; thisPin++) {
          digitalWrite(thisPin, LOW);
        }
        digitalWrite(53, HIGH);
        Serial.println("pin " + String(53) + " on");
        digitalWrite(47, HIGH);
        Serial.println("pin " + String(nmbrPin) + " on");
        digitalWrite(48, HIGH);
        Serial.println("pin " + String(nmbrPin + 1) + " on");
        digitalWrite(16, HIGH);
        Serial.println("pin " + String(nmbrPin) + " on");
        toString = String(nmbrPin) + "," + String(nmbrPin + 1) + "," + String(53);
      }

      else if (nmbrPin == 49) {
        // switch off all valves
        for (thisPin = 22; thisPin < 55; thisPin++) {
          digitalWrite(thisPin, LOW);
        }
        digitalWrite(53, HIGH);
        Serial.println("pin " + String(53) + " on");
        digitalWrite(49, HIGH);
        Serial.println("pin " + String(nmbrPin) + " on");
        digitalWrite(50, HIGH);
        Serial.println("pin " + String(nmbrPin + 1) + " on");
        toString = String(nmbrPin) + "," + String(nmbrPin + 1) + "," + String(53);
        digitalWrite(16, LOW);
        Serial.println("pin " + String(nmbrPin) + " off");
      }

      else if (nmbrPin == 77) {
        // switch off all valves
        for (thisPin = 22; thisPin < 55; thisPin++) {
          digitalWrite(thisPin, LOW);
        }
        digitalWrite(53, HIGH);
        Serial.println("pin " + String(53) + " on");
        digitalWrite(49, HIGH);
        Serial.println("pin " + String(nmbrPin) + " on");
        digitalWrite(50, HIGH);
        Serial.println("pin " + String(nmbrPin + 1) + " on");
        toString = String(nmbrPin) + "," + String(nmbrPin + 1) + "," + String(53);
        digitalWrite(17, HIGH);
        Serial.println("pin " + String(nmbrPin) + " on");
      }
      else if (nmbrPin == 51) {
        // switch off all valves
        for (thisPin = 22; thisPin < 55; thisPin++) {
          digitalWrite(thisPin, LOW);
        }
        digitalWrite(53, HIGH);
        Serial.println("pin " + String(53) + " on");
        digitalWrite(51, HIGH);
        Serial.println("pin " + String(nmbrPin) + " on");
        digitalWrite(52, HIGH);
        Serial.println("pin " + String(nmbrPin + 1) + " on");
        toString = String(nmbrPin) + "," + String(nmbrPin + 1) + "," + String(53);
        digitalWrite(17, LOW);
        Serial.println("pin " + String(nmbrPin) + " off");
      }

      else if (nmbrPin == 79) {
        // switch off all valves
        for (thisPin = 22; thisPin < 55; thisPin++) {
          digitalWrite(thisPin, LOW);
        }
        digitalWrite(53, HIGH);
        Serial.println("pin " + String(53) + " on");
        digitalWrite(51, HIGH);
        Serial.println("pin " + String(nmbrPin) + " on");
        digitalWrite(52, HIGH);
        Serial.println("pin " + String(nmbrPin + 1) + " on");
        toString = String(nmbrPin) + "," + String(nmbrPin + 1) + "," + String(53);
        digitalWrite(18, HIGH);
        Serial.println("pin " + String(nmbrPin) + " on");
      }

      else if (nmbrPin == 71) { //AM16/32B on
        digitalWrite(19, HIGH);
        Serial.println("pin " + String(nmbrPin) + " on");
      }
      else if (nmbrPin == 73) { //AM16/32B off
        digitalWrite(19, LOW);
        Serial.println("pin " + String(nmbrPin) + " off");
      }

      // reset and wait for the next command from the Datalogger
      index = 0;
      fromString = "";
      Serial3.print(toString);
      Serial.print(toString);

    }
  }
}
///////////////////////////////////////////////////



















