//+------------------------------------------------------------------+
//|                                                        stats.mq4 |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                          https://www.awtt.com.ar |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "https://www.awtt.com.ar"
#property version   "1.00"
#property strict

extern double stopLoss=75; 
extern double takeProfit=150;
double val, longMA, valClose, delta, valLowNext, deltaPips;
int z, lastTicket;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
      z=1;
      stopLoss = stopLoss*10*Point;   
      takeProfit = takeProfit*10*Point;
 
   
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
      val=iCustom(Symbol(),0,"mysuns",0,z);
      if(val>0){
         longMA = iMA(Symbol(),PERIOD_H1,200,0,MODE_EMA,PRICE_CLOSE,z);
         valClose = iClose(Symbol(),PERIOD_H1,z);
         delta = MathAbs(valClose-longMA);
         if(delta>1000*Point){
            valLowNext = getHighestNextsCandles(z,120);
            deltaPips = (valClose-valLowNext)*10000;
            //Print("vela: ",z,", price: ",valClose,", valMinimo proximas velas: ",valLowNext, ", deltaPips to min: ",deltaPips);
            //Print(" ema: ",longMA,", delta: ", delta, 
            //", date: ",Time[z]);
            if(OrdersTotal()==0)
               lastTicket = OrderSend(Symbol(),OP_SELL,0.01,Bid,10,0,0);
            if(OrdersTotal()==1){
               OrderSelect(lastTicket,SELECT_BY_TICKET);
               if(OrderProfit()<-10){   
                  lastTicket = OrderSend(Symbol(),OP_SELL,0.02,Bid,10,0,0);
                  
               }
               }
              
            }
      }
      OrderSelect(lastTicket,SELECT_BY_TICKET);
      if(OrderProfit()>15)
               close(); 
  }
//+------------------------------------------------------------------+
 
double getLowestNextsCandles(int candle,int deep){

   double r=-1;   
   int position;
   position = iLowest(Symbol(),PERIOD_H1,MODE_LOW,deep,candle);
   if(position!=-1) r=Low[position];
   return r;

   }
   
 double getHighestNextsCandles(int candle,int deep){

   double r=-1;   
   int position;
   position = iHighest(Symbol(),PERIOD_H1,MODE_LOW,deep,candle);
   if(position!=-1) r=High[position];
   return r;

   }
   
void close(){
      int t = OrdersTotal();
      for(int i=t-1;i>=0;i--){
         OrderSelect(i, SELECT_BY_POS);
         OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),10);
         }
   }