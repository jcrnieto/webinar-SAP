using { btp.onboarding.maintenance as my } from '../db/schema.cds';

@(path:'/direct-orders')
service MaintenanceOrdersDirect {

    entity orders as projection on my.MaintenanceOrder;

    entity equipments as projection on my.Equipment
        excluding { createdBy, createdAt, updatedAt, modifiedAt, modifiedBy };

    entity mechanics as projection on my.Mechanic
        excluding { password, createdBy, createdAt, updatedAt, modifiedAt, modifiedBy };

}