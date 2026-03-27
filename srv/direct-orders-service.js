const cds = require('@sap/cds');

module.exports = (srv) => {

    // Extract entities from service
    const { orders } = srv.entities;

    // Assign order number to new one
    srv.before('CREATE', 'orders', async (req) => {
        const query = SELECT.from('MaintenanceOrdersDirect.orders')
            .columns('number');
        const orders = await cds.db.run(query);

        // Get max order number from orders object array
        const ordersNumbers = orders.map(o => o.number);
        const maxOrder = (Math.max(...ordersNumbers));
        const newOrderNumber = maxOrder + 1;
        req.data.number = newOrderNumber;
        return(req);
    });

    // Calculate order value based on duration and equipment cost
    srv.before('CREATE', 'orders', async (req) => {
        const { duration, to_equipment_equipmentId } = req.data;
        const query = SELECT.from('MaintenanceOrdersDirect.equipments')
            .where({ equipmentId: to_equipment_equipmentId });
        const equipmentCost = await cds.db.run(query);
        const orderValue = duration * (equipmentCost[0].acquisitionCost * 0.015); // Each day cost 1.5% of equipment cost
        req.data.orderValue = orderValue;
        return(req);
    });

    // For orders created with value = 0, calculate order after listing
    srv.after('READ', 'orders', async (orders, req) => {
        const db = srv.transaction(req);

        for (const order of orders) {

            const query = SELECT.from('MaintenanceOrdersDirect.equipments')
                .columns('acquisitionCost')
                .where({ equipmentId: order.to_equipment_equipmentId });

            const equipmentCost = await db.run(query);

            if (order.orderValue === 0) {
                order.orderValue = equipmentCost[0].acquisitionCost * 0.015;
            }
        }

        return orders;
    });

}