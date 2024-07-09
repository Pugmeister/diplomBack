import express from 'express';
import { protect } from '../middleware/auth.middleware.js';
import {
    createAppointment,
    getAppointments,
    getAppointmentById,
    updateAppointment,
    deleteAppointment,
} from '../appointment/appointment.controller.js';
import { 
    completeAppointmentLog, 
    createAppointmentLog, 
    getAppointmentLogById 
} from './log/appointmentLog.js';

const router = express.Router();

router.route('/appointment').post(createAppointment).get(getAppointments)
router
    .route('/appointment/:id')
    .get(getAppointmentById)
    .put(updateAppointment)
    .delete(deleteAppointment);

router.route('/appointment/log/').post(protect, createAppointmentLog);
router.route('/appointment/log/:id').get(protect, getAppointmentLogById);
router.route('/appointment/log/:id/complete').put(protect, completeAppointmentLog);

export default router;
