//+------------------------------------------------------------------+
//|                                                        stats.mq4 |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                          https://www.awtt.com.ar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "https://www.awtt.com.ar"
#property version   "1.00"
#property strict

double val, longMA, valClose, delta, valLowNext, deltaPips;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   for(int z=1;z<7000;z++){
      val=iCustom(Symbol(),0,"mysuns",1,z);
      if(val>0){
         longMA = iMA(Symbol(),PERIOD_H1,200,0,MODE_EMA,PRICE_CLOSE,z);
         valClose = iClose(Symbol(),PERIOD_H1,z);
         delta = MathAbs(valClose-longMA);
         if(delta>1500*Point){
            valLowNext = getHighestNextsCandles(z,240);
            deltaPips = (valClose-valLowNext)*10000*(-1);
            Print("vela: ",z,", price: ",valClose,", valMinimo proximas velas: ",valLowNext, ", deltaPips to min: ",deltaPips);
            Print(" ema: ",longMA,", delta: ", delta, 
            ", date: ",Time[z]);
            
            
            }
         }   
         
   }
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
 
double getLowestNextsCandles(int candle,int deep){

   double r=-1;   
   int position;
   position = iLowest(Symbol(),PERIOD_H1,MODE_LOW,deep,candle-deep);
   if(position!=-1) r=Low[position];
   return r;

   }
   
 double getHighestNextsCandles(int candle,int deep){

   double r=-1;   
   int position;
   position = iHighest(Symbol(),PERIOD_H1,MODE_HIGH,deep,candle-deep);
   if(position!=-1) r=High[position];
   return r;

   }