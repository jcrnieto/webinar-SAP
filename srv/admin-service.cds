using { btp.onboarding.maintenance as my } from '../db/schema';

service AdminService @(path:'/admin') {

    entity MaintenanceOrders as projection on my.MaintenanceOrder;

    entity Mechanics as projection on my.Mechanic {
        *,
        // hide password
        '********' as password : String
    };

    entity Equipments as projection on my.Equipment;

}