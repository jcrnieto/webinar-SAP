using { managed, Currency, sap } from '@sap/cds/common';

namespace btp.onboarding.maintenance;

// Master Data
entity Mechanic : managed {
    key mechanicId : String;
    name           : String;
    email          : String;
    password       : String;
    role           : String;
}

entity Equipment : managed {
    key equipmentId  : String;
    name             : String;
    description      : String;
    category         : String;
    status           : String;
    available        : Boolean;
    acquisitionCost  : Integer;
    currency         : Currency;
}

// Code Lists
entity OrderStatus : sap.common.CodeList {
    key code        : String(5);
    criticality     : Integer;
}