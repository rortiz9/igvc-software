int SPI_SS = 10;
int SPI_CLK = 11;
int SPI_MISO = 12;


void setup(){

	pinMode(SPI_SS, OUTPUT);
	pinMode(SPI_CLK, OUTPUT);
	pinMode(SPI_MISO, INPUT);

	digitalWrite(SPI_SS, HIGH);
	digitalWrite(SPI_CLK, LOW);
        Serial.begin(9600);
}

void loop(){
	//start main code
	unsigned int datatemp;
	int t1 = millis();
	
	digitalWrite(SPI_SS, LOW);
	delayMicroseconds(100);//delay 100us before starting clock

	for(int i = 0; i < 16; i++){
		digitalWrite(SPI_CLK, HIGH);
		delayMicroseconds(10);//delay of 10us before data is sent

		datatemp |= digitalRead(SPI_MISO);
		datatemp <<= 1;
			
		digitalWrite(SPI_CLK, LOW);
		delayMicroseconds(50);//wait the appropriate amount to make this a 2khz signal (or shorter, encoder take 1khz through 50khz)
	}
	digitalWrite(SPI_SS, HIGH);
	
        delayMicroseconds(50);//the last bit is held for 50us
        delay(1);
      
	int t2 = millis();
	unsigned int dataout = (((datatemp >> 13) & 1) << 8) | (((datatemp >> 12) & 1) << 7) | (((datatemp >> 11) & 1) << 6) | (((datatemp >> 10) & 1) << 5) | (((datatemp >> 9) & 1) << 4) | (((datatemp >> 8) & 1) << 3) | (((datatemp >> 2) & 2) << 2) | (((datatemp >> 1) & 1) << 1) | (datatemp & 1);


	//Serial.print("received: ");
	Serial.println(dataout, DEC);
	Serial.println(t2-t1,DEC);
        delay(100);
}