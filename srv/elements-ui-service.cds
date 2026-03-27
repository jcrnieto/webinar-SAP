using { btp.onboarding.maintenance as my } from '../db/schema.cds';

@(path:'/elements-ui')
service ElementsUIService {

    entity orders as projection on my.MaintenanceOrder;
    annotate orders with @odata.draft.enabled;

    entity equipments as projection on my.Equipment
        excluding { createdBy, createdAt, updatedAt, modifiedAt, modifiedBy };

    entity mechanics as projection on my.Mechanic
        excluding { password, createdBy, createdAt, updatedAt, modifiedAt, modifiedBy };

}