//+------------------------------------------------------------------+
//|                                                        stats.mq4 |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                          https://www.awtt.com.ar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "https://www.awtt.com.ar"
#property version   "1.00"
#property strict

double val, longMA, valClose, delta;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   for(int z=3000;z<6000;z++){
      val=iCustom(Symbol(),0,"mysuns",0,z);
      if(val>0){
         longMA = iMA(Symbol(),PERIOD_H1,200,0,MODE_EMA,PRICE_CLOSE,z);
         valClose = iClose(Symbol(),PERIOD_H1,z);
         delta = MathAbs(valClose-longMA);
         if(delta>1000*Point)
            Print("vela: ",z,", price: ",valClose,", ema: ",longMA,", delta: ", delta, 
            ", date: ",Time[z]);
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
