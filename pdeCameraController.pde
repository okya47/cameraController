// Serial.printにpotentioValAveを追?��?
// goDirectionを読みこませるために(;)の対処が�?�??��??��ため
// セットアップ中用のServo90を追加(190930)

import controlP5.*;
import processing.serial.*;

ControlP5 cp5;

// servo90
boolean Servo90 = false;
int toggleServo = 0;
int ex_toggleServo = 0;

Slider sINTERVAL; //interval
Slider sSA; //Sail_Base_Angle
Slider srA; //brudderAngle
Slider suA; //upwindAngle
Slider sdA; //downwindAngle
Slider sdR; //dis_return

Serial myPort;  // Create object from Serial class
//String str = "";        // Data received from the serial port
// int n = 0;      //位置セ??��?��?ト�???��?��表示開始に使用
// int m = 0;      //SerialWriteの識別
// PImage img;
// int warmup = 0;
// float c1x = 452;  //100
// float c1y = 386;  //100
// float c2x = 533;  //100
// float c2y = 513;  //300
// float tarx = 500;
// float tary = 100;
// float prex = 500;
// float prey = 300;
// int circleSize = 15;
// boolean overCircle1 = false;
// boolean c1locked = false;
// boolean overCircle2 = false;
// boolean c2locked = false;
// boolean overCircleT = false;
// boolean Tlocked = false;
// boolean overCircleP = false;
// boolean Plocked = false;
// float c1xOffset = 0.0; 
// float c1yOffset = 0.0; 
// float c2xOffset = 0.0; 
// float c2yOffset = 0.0; 
// float tarxOffset = 0.0; 
// float taryOffset = 0.0; 
// float prexOffset = 0.0; 
// float preyOffset = 0.0; 

// float c1Lat = 0.0 ;
// float c1Lng = 0.0;
// float c2Lat = 0.0;
// float c2Lng = 0.0;
// float tarLat = 0.0;
// float tarLng = 0.0;
// float GPSLat = 0.0;
// float GPSLng = 0.0;

// Textlabel txtLat;
// Textlabel txtLng;

// String LR = "";
// String UpDown = "";
// String str_count;
// String str_targetGPSLat;
// String str_targetGPSLng;
// String str_GPSLat;
// String str_GPSLng;
// String str_WSpd;
// String str_Sail_Base_Angle;
// String str_Sail_Angle;
// String str_brudderAngle;
// String str_windDeg;
// String str_windTargetAngle;
// String str_machineAngle;
// String str_upwindAngle;
// String str_downwindAngle;
// String str_dis_return;
// String str_battery;
// String str_windAxisDistance;
// String str_windCrossDistance;
// String str_potentioVal;
// String str = "";

// String ex_starLat = "";
// String ex_starLng = "";
// String ex_sSail_Base_Angle = "";
// String ex_sSail_Angle = "";
// String ex_sbrudderAngle = "";
// String ex_supwindAngle = "";
// String ex_sdownwindAngle = "";
// String ex_sdis_return = "";
// int count;
// float targetGPSLat;
// float targetGPSLng;
// float GPSLat;
// float GPSLng;
// int WSpd = 0;
// int Sail_Base_Angle = 15;
// int Sail_Angle = 0;
// int brudderAngle = 15;
// int windDeg = 0;
// int windTargetAngle = 0;
// int machineAngle = 0;
// int upwindAngle = 15;
// int downwindAngle = 15;
// int dis_return = 20;
// float battery = 6.777;
// float windAxisDistance = 0;
// float windCrossDistance = 0;
// int potentioVal = 0;
// float disTarget = 0.0;
// float disLat = 0.0;
// float disLong = 0.0;
// int targetDeg = 0;
// int compassDeg = 0;
// float tempBME280 = 0.0;
// float humidBME280 = 0.0;
// float presBME280 = 0.0;
// float dGPSSpdMph = 0.0;
// int dGPSCourse = 0;
// int goDirection = 0;
// int potentioValAve = 0;
// int widthback1 = 400;
// int widthback2 = 220;
int interval = 100;

void setupcp5() {
//   txtLat = cp5.addTextlabel("lblStart")
//               .setText("Start")
//               .setPosition(30, 100)
//               .setColorValue(0)
//               .setFont(createFont("ariel", 20))
//               ;
//   txtLng = cp5.addTextlabel("lblStop")
//               .setText("Stop")
//               .setPosition(30, 200)
//               .setColorValue(0)
//               .setFont(createFont("ariel", 20))
//               ;

  cp5.addBang("START")
    .setPosition(150, 100)
    .setSize(150, 50)
    .setFont(createFont("ariel", 20))
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;

  cp5.addBang("STOP")
    .setPosition(150, 250)
    .setSize(150, 50)
    .setFont(createFont("ariel", 20))
    .setColorForeground(#ff0000)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    ;



  PFont font = createFont("arial", 20);

  sINTERVAL = cp5.addSlider(" INTERVAL")
            .setRange(0, 1000)
            .setValue(interval)  //初期値
            .setPosition(150, 400)
            .setColorForeground(#ffd700)
            .setSize(150, 40)
            .setFont(font)
            .setNumberOfTickMarks(100)
            .setSliderMode(Slider.FLEXIBLE)
            ;
}

void setup(){
    size(800, 500);
    smooth();
    background(#66cdaa);
    println("Start!");
    // background(#0000ff);

    // Serial通信する時に必要
    // printArray(Serial.list());
    // String portName = Serial.list()[0];{} 
    // myPort = new Serial(this, portName, 9600);

    cp5 = new ControlP5(this);
    setupcp5();

}

void draw() {
    fill(#0000ff);
    // rect(0,20,width, height-40);
    // int Lline = 100;
    // int Sline = 30;

    // fill(#444444);
    // rect(30, 30, 370, 240);

    // ラダーの取り付け用にサーボを90度に揃える
    if(Servo90 == true) {
        // fill(255, 255, 220);
        toggleServo = 1; 
    } else {
        // fill(128, 128, 110);
        toggleServo = 0;
    }
    if(ex_toggleServo != toggleServo) {
        String stoggleServo = nf(toggleServo);
        myPort.write('t' + stoggleServo + ';');
        println('t'+ stoggleServo + ';');
    }
    ex_toggleServo = toggleServo;

    //シリアル??��?��?報受信
    // print(myPort.available() > 0);
    // if(myPort.available() > 0) {
    //     str = myPort.readStringUntil(';');
    //     if(str != null)  {
    //         println(str);
    //         String[] str_temp = splitTokens(str, ",");
    //         for(int k=0; k<str_temp.length; k++) {
    //             switch(k) {
    //                 case 0:
    //                     LR = trim(str_temp[k]);
    //                 case 1:
    //                     UpDown = trim(str_temp[k]);
    //                 case 2:
    //                     count = int(trim(str_temp[k]));
    //                 case 3:
    //                     targetGPSLat = float(str_temp[k]);
    //                 case 4:
    //                     targetGPSLng = float(str_temp[k]);
    //                 case 5:
    //                     GPSLat = float(str_temp[k]);
    //                 case 6:
    //                     GPSLng = float(str_temp[k]);
    //                 case 7:
    //                     WSpd = int(trim(str_temp[k]));
    //                 case 8:
    //                     Sail_Base_Angle = int(trim(str_temp[k]));
    //                 case 9:
    //                     Sail_Angle = int(trim(str_temp[k]));
    //                 case 10:
    //                     brudderAngle = int(trim(str_temp[k]));
    //                 case 11:
    //                     windDeg = int(trim(str_temp[k]));
    //                 case 12:
    //                     windTargetAngle = int(trim(str_temp[k]));
    //                 case 13:
    //                     machineAngle = int(trim(str_temp[k]));
    //                 case 14:
    //                     upwindAngle = int(trim(str_temp[k]));
    //                 case 15:
    //                     downwindAngle = int(trim(str_temp[k]));
    //                 case 16:
    //                     dis_return = int(trim(str_temp[k]));
    //                 case 17:
    //                     battery = float(str_temp[k]);
    //                 case 18:
    //                     windAxisDistance = float(str_temp[k]);
    //                 case 19:
    //                     windCrossDistance = float(str_temp[k]);
    //                 case 20:
    //                     potentioVal = int(trim(str_temp[k]));
    //                 case 21:
    //                     disTarget = float(str_temp[k]);
    //                 case 22:
    //                     disLat = float(str_temp[k]);
    //                 case 23:
    //                     disLong = float(str_temp[k]);
    //                 case 24:
    //                     targetDeg = int(str_temp[k]);
    //                 case 25:
    //                     compassDeg = int(str_temp[k]);
    //                 case 26:
    //                     tempBME280 = float(str_temp[k]);
    //                 case 27:
    //                     humidBME280 = float(str_temp[k]);
    //                 case 28:
    //                     presBME280 = float(str_temp[k]);
    //                 case 29:
    //                     dGPSSpdMph = float(str_temp[k]);
    //                 case 30:
    //                     dGPSCourse = int(str_temp[k]);
    //                 case 31:
    //                     goDirection = int(str_temp[k]);
    //                 case 32:
    //                     potentioValAve = int(str_temp[k]);
    //             }
    //         }

    //         prex = (c1x-c2x)/(c1Lng-c2Lng)*(GPSLng-c2Lng)+c2x;
    //         prey = (c1y-c2y)/(c1Lat-c2Lat)*(GPSLat-c2Lat)+c2y;

    //     } else {
    //         int j = 1;
    //     }
    // }

    //現在位置、情報表示、および設定に変化があればヨットに送信
    // if(n != 0) {
    //     tarLat = (tary-c1y)/(c2y-c1y)*(c2Lat-c1Lat)+c1Lat;
    //     tarLng = (tarx-c1x)/(c2x-c1x)*(c2Lng-c1Lng)+c1Lng;
    //     Sail_Base_Angle = int(sSA.getValue());
    //     brudderAngle = int(srA.getValue());
    //     upwindAngle = int(suA.getValue());
    //     downwindAngle = int(sdA.getValue());
    //     dis_return = int(sdR.getValue());


    //     int textspace = 25;

    //     rect(width - widthback1-20, 180, width - 1120, 200 + textspace * 10 + 50);

    //     m++;
    // }


    //??��?��?ポイント描画
}
