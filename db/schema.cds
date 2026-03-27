namespace btp.onboarding.maintenance;

using { managed, cuid, Currency } from '@sap/cds/common';

using {
    btp.onboarding.maintenance.Equipment,
    btp.onboarding.maintenance.Mechanic,
    btp.onboarding.maintenance.OrderStatus
} from './master-data.cds';

entity MaintenanceOrder : cuid, managed {
    number        : String;
    description   : String;
    to_status     : Association to one OrderStatus;
    to_equipment  : Association to one Equipment;
    notes         : String;
    duration      : Integer;
    orderValue    : Integer;
    currency      : Currency;
    to_mechanic   : Association to one Mechanic;
}