namespace core;
using { User, Country, cuid, managed } from '@sap/cds/common';

entity States {
  key code : String(2);
  abbrev   : String(6);
  name     : String(24);
}

entity Currencies {
  key code  : String(3);
  name      : String(128);
  UperUSD   : Double;
  USDperU   : Double;
}


